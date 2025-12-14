# Flashlight Kiosk Project Analysis

## 🛠️ Tech Stack & Architecture
- **Framework**: Flutter (Dart SDK ^3.7.0)
- **State Management**: GetX
- **Networking**: Dio (with interceptors for retry & logging via `raccoon`)
- **Localization**: Multi-language support (Indonesia/English)
- **Flavors**: Supports multiple environments (Production, Staging, Dev) via `flutter_flavorizr`

## 🚀 Key Features

### 1. Customer Registration (Pendaftaran Pelanggan)
- **5-Step Wizard Flow**:
    1.  **Step 1: Data Diri (Personal Data)**
        -   **Input**: Nama (Name) & Nomor Handphone (Phone Number).
        -   **Validation**:
            -   Name: Minimum 2 characters.
            -   Phone: Indonesian format validation (starts with 8, 10-13 digits).
        -   **Membership Check**:
            -   Manual "Check" button to verify membership status.
            -   Statuses: *Member Addict* (Orange w/ Star), *Non-Member*, or *Loading*.
        -   **Navigation**: "Lanjutkan" button enabled only when data is valid and membership status is resolved.

    2.  **Step 2: Kendaraan (Vehicle)**
        -   **Dynamic View**: Adapts based on membership status.
            -   **Member**: Select from registered vehicles (e.g., Honda Beat, etc.).
            -   **Non-Member**: Form to input new vehicle details (Brand, License Plate, Engine CC).
        
    3.  **Step 3: Layanan (Services)**
        -   **Header**: Displays Customer & Vehicle info summary.
        -   **Selection Grid**:
            -   Service Cards with Image, Name, Description, and Price.
            -   Visual indicators for Selected items and Default services.
        -   **Real-time Summary**: Bottom bar shows total selected services and subtotal price.
        
    4.  **Step 4: Food & Beverage (F&B)**
        -   **Product Grid**: Browse and select F&B items to accompany the service.
        -   **Layout**: Consistent with Service selection (Grid + Bottom Summary).

    5.  **Step 5: Ringkasan (Order Summary)**
        -   **Review**: Detailed list of selected Services and F&B items.
        -   **Total Estimation**: Final estimated cost calculation.
        -   **Action**: "Lanjut ke Work Order" (Proceed to Work Order) to finalize transaction.
- **Membership Check**: Simulation of member status check based on phone number.
- **Input Validation**: Indonesian phone number format validation and mandatory fields.

### 2. Work Order (SPK - Surat Perintah Kerja)
- **Success Page**: This page appears immediately after a successful registration.
    -   **Success Indicators**:
        -   "Work Order Berhasil Dibuat!" (Work Order Created Successfully) title.
        -   Green Success Icon.
    -   **Work Order Card**:
        -   **Kode Work Order**: Unique identifier for the order (e.g., WO-123456).
        -   **Queue Number**: Large display of the customer's queue number.
        -   **Estimation**: Estimated wait time in minutes.
        -   **Timestamp**: Date and time of order creation.
    -   **Auto-Reset**:
        -   **Countdown**: "Auto-reset dalam X detik" notification (top of screen).
        -   **Logic**: Automatically returns to the "Welcome Screen" after 10 seconds of inactivity to reset the kiosk for the next user.
    -   **Instruction**: User is advised to wait in the designated area and monitor the main queue screen.

### 3. Onboarding
- **Splash Screen**: App opening screen.
- **Welcome Screen**: Main greeting page.

### 4. Utilities
- **Connectivity**: Internet connection status detection.
- **Assets**: Custom SVG and font support (Inter, Poppins).
