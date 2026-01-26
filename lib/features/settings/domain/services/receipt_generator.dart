import 'dart:convert';
import 'dart:developer';

import 'package:flashlight_pos/features/customer/domain/entities/customer.dart';
import 'package:flashlight_pos/features/settings/domain/entities/app_settings.dart';
import 'package:flashlight_pos/features/settings/domain/entities/receipt_settings.dart';
import 'package:flashlight_pos/features/vehicle/domain/entities/vehicle.dart';
import 'package:flashlight_pos/features/work_order/domain/entities/work_order.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img; // Need to ensure 'image' package is in pubspec or added
import 'package:intl/intl.dart';

class ReceiptGenerator {
  // ESC/POS Commands
  static const List<int> _init = [0x1B, 0x40];
  static const List<int> _boldOn = [0x1B, 0x45, 0x01];
  static const List<int> _boldOff = [0x1B, 0x45, 0x00];
  static const List<int> _alignLeft = [0x1B, 0x61, 0x00];
  static const List<int> _alignCenter = [0x1B, 0x61, 0x01];
  static const List<int> _cut = [0x1D, 0x56, 0x41, 0x10]; // Cut paper

  // Helpers
  List<int> _text(String text) {
    // Basic conversion, utf8/ascii is fine for basic latin
    return utf8.encode('$text\n');
  }

  Future<List<int>> generateReceiptBytes({
    required WorkOrder order,
    required ReceiptSettings settings,
    required AppSettings appSettings,
    Customer? customer,
    Vehicle? vehicle,
  }) async {
    final List<int> bytes = [];

    // Init command
    bytes.addAll(_init);

    // 1. Logo
    if (settings.showLogo) {
      try {
        final ByteData data = await rootBundle.load('assets/image/png/draw_logo_flashligt.png');
        final Uint8List bytesImg = data.buffer.asUint8List();
        final img.Image? image = img.decodeImage(bytesImg);

        if (image != null) {
          log("Logo loaded. Original: ${image.width}x${image.height}");
          // Resize image if too large (standard 58mm loger width ~384 dots, logo usually smaller)
          const int targetWidth = 200;
          img.Image resized = image;
          if (image.width > targetWidth) {
            resized = img.copyResize(image, width: targetWidth);
          }
          log("Logo resized to: ${resized.width}x${resized.height}");

          // Center alignment
          bytes.addAll(_alignCenter);

          // Generate ESC/POS Image Commands
          final imageBytes = _logImage(resized);
          log("Generated ${imageBytes.length} bytes for image");
          bytes.addAll(imageBytes);

          bytes.addAll(_text('')); // Spacing
        }
      } catch (e) {
        log("Error loging logo: $e");
        // Fallback or ignore
      }
    }

    // 2. Store Info
    bytes.addAll(_alignCenter);
    bytes.addAll(_boldOn);
    bytes.addAll(_text(appSettings.storeName));
    bytes.addAll(_boldOff);
    bytes.addAll(_text(appSettings.storeAddress));
    bytes.addAll(_text(appSettings.storePhone));
    bytes.addAll(_text('')); // Newline

    // 3. Header
    bytes.addAll(_boldOn);
    bytes.addAll(_text(settings.receiptHeader));
    bytes.addAll(_boldOff);
    bytes.addAll(_text('--------------------------------'));

    // 4. Transaction Info
    bytes.addAll(_alignLeft);
    // Use order date if available, otherwise current time
    final date = order.createdAt ?? DateTime.now();
    bytes.addAll(_text('Date: ${DateFormat('yyyy-MM-dd HH:mm').format(date)}'));
    bytes.addAll(_text('Invoice: ${order.workOrderCode}'));
    bytes.addAll(_text('Cashier: Admin')); // Hardcoded for now per requirements/prototype

    // 5. Customer Info (Matches new Preview Logic)
    bytes.addAll(_text('--------------------------------'));
    bytes.addAll(_text(
        'Customer: ${customer?.name ?? (order.customerId.isNotEmpty ? order.customerId : "Guest")}'));

    // Vehicle Info
    if (vehicle != null) {
      bytes.addAll(_text('Vehicle: ${vehicle.vehicleBrand} ${vehicle.vehicleSpecs}'));
      bytes.addAll(_text('Plate No: ${vehicle.licensePlate}'));
    } else {
      bytes.addAll(_text('Vehicle: -'));
      bytes.addAll(_text('Plate No: -'));
    }

    bytes.addAll(_text('--------------------------------'));

    // 6. Items - Fixed width formatting
    // Layout: Name (14 chars) Qty(3) Price(12) - approx 30-32 chars width standard
    bytes.addAll(_text('Item           Qty       Amount'));

    // Services
    for (var service in order.services) {
      String name = service.service?.name ?? 'Service';
      if (name.length > 14) name = name.substring(0, 14);

      String qty = service.quantity.toString().padLeft(3);

      // Format price
      double total = service.priceAtOrder * service.quantity.toDouble();
      String price = total.toStringAsFixed(0);
      // Simple currency formatting
      price = _formatCurrency(total);

      bytes.addAll(_text('${name.padRight(15)} $qty ${price.padLeft(12)}'));
    }

    // Products
    for (var product in order.products) {
      String name = product.product?.name ?? 'Product';
      if (name.length > 14) name = name.substring(0, 14);

      String qty = product.quantity.toString().padLeft(3);

      double total = product.priceAtOrder * product.quantity.toDouble();
      String price = _formatCurrency(total);

      bytes.addAll(_text('${name.padRight(15)} $qty ${price.padLeft(12)}'));
    }

    bytes.addAll(_text('--------------------------------'));

    // 7. Totals
    // Subtotal
    bytes.addAll(_text('Subtotal: ${_formatCurrency(order.totalPrice.toDouble())}'));

    // Discount
    if (settings.showDiscount) {
      // Assuming discount logic exists or defaulting to 0 for now based on current WorkOrder model
      bytes.addAll(_text('Discount: ${_formatCurrency(0)}'));
    }

    // Tax
    if (settings.showTaxDetails) {
      double tax = order.totalPrice * (appSettings.taxRate / 100);
      bytes.addAll(_text('Tax (${appSettings.taxRate}%): ${_formatCurrency(tax)}'));

      bytes.addAll(_text('--------------------------------'));
      bytes.addAll(_boldOn);
      double grandTotal = order.totalPrice + tax;
      bytes.addAll(_text('TOTAL: ${_formatCurrency(grandTotal)}'));
      bytes.addAll(_boldOff);
    } else {
      bytes.addAll(_text('--------------------------------'));
      bytes.addAll(_boldOn);
      // If tax is included or hidden, just show total price or assume tax added
      bytes.addAll(_text('TOTAL: ${_formatCurrency(order.totalPrice.toDouble())}'));
      bytes.addAll(_boldOff);
    }

    // 8. Payment Method
    if (settings.showPaymentMethod) {
      bytes.addAll(_text('--------------------------------'));
      bytes.addAll(_text('Payment: ${order.paymentMethod?.toUpperCase() ?? "CASH"}'));
      bytes.addAll(_text('Paid: ${_formatCurrency(order.paidAmount.toDouble())}'));

      // Change
      double change = (order.paidAmount - order.totalPrice).toDouble();
      if (change < 0) change = 0;
      bytes.addAll(_text('Change: ${_formatCurrency(change)}'));
    }

    // 9. Footer
    if (settings.showFooterMessage && settings.footerMessage.isNotEmpty) {
      bytes.addAll(_alignCenter);
      bytes.addAll(_text(''));
      bytes.addAll(_text(settings.footerMessage));
    }

    bytes.addAll(_text(''));
    bytes.addAll(_text('Powered by Flashlight POS'));
    // Feed paper
    bytes.addAll([0x1B, 0x64, 0x03]); // Feed 3 lines

    // Cut
    bytes.addAll(_cut);
    return bytes;
  }

  String _formatCurrency(double amount) {
    // Basic helper to format like "Rp 150,000"
    // Using RegExp for thousands separator
    String s = amount.toStringAsFixed(0);
    return 'Rp ${s.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }

  /// Converts an image to ESC/POS Raster Bit Image (GS v 0) commands
  List<int> _logImage(img.Image image) {
    final List<int> bytes = [];

    // Image properties
    final int width = image.width;
    final int height = image.height;

    // Raster bit image mode: GS v 0 m xL xH yL yH d1...dk
    // m = 0 (Normal), 1 (Double Width), 2 (Double Height), 3 (Quadruple)
    // We use Normal mode (0)

    // xL, xH: Width in bytes (xL + xH * 256)
    // yL, yH: Height in dots (yL + yH * 256)

    final int widthBytes = (width + 7) ~/ 8;
    final int headerWidth = widthBytes;
    final int xL = headerWidth % 256;
    final int xH = headerWidth ~/ 256;

    final int yL = height % 256;
    final int yH = height ~/ 256;

    // Command Header
    bytes.addAll([0x1D, 0x76, 0x30, 0x00, xL, xH, yL, yH]);

    // Pixel Data
    for (int y = 0; y < height; y++) {
      for (int i = 0; i < widthBytes; i++) {
        int byte = 0;
        for (int j = 0; j < 8; j++) {
          int x = i * 8 + j;
          if (x < width) {
            // Get pixel
            img.Pixel pixel = image.getPixel(x, y);
            // Logic: Check if pixel should be loged (Black)
            // Thermal loger: 1 = Heat (Black point), 0 = No Heat (White)
            // User Request: Logo is WHITE, so we need to log WHITE pixels as BLACK.
            // We log if the pixel is NOT transparent AND looks "Bright/White"
            if (pixel.a > 100 && pixel.luminance > 100) {
              byte |= (1 << (7 - j));
            }
          }
        }
        bytes.add(byte);
      }
    }

    return bytes;
  }
}
