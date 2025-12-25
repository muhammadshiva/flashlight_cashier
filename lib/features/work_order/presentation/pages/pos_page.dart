import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection_container.dart';
import '../../../customer/domain/entities/customer.dart';
import '../../../vehicle/domain/entities/vehicle.dart';
import '../bloc/pos_bloc.dart';

class PosPage extends StatelessWidget {
  const PosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PosBloc>()..add(LoadCatalog()),
      child: const PosView(),
    );
  }
}

class PosView extends StatelessWidget {
  const PosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Work Order'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<PosBloc>().add(LoadCatalog()),
          ),
        ],
      ),
      body: BlocConsumer<PosBloc, PosState>(
        listener: (context, state) {
          if (state.status == PosStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Error')),
            );
          } else if (state.status == PosStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Success')),
            );
            context.pop(); // Go back on success
          }
        },
        builder: (context, state) {
          if (state.status == PosStatus.loading && state.availableServices.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                // Desktop Layout
                return Row(
                  children: [
                    // Left Panel: Selection and Catalog
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          _CustomerVehicleSelection(state: state),
                          const Divider(),
                          Expanded(child: _CatalogView(state: state)),
                        ],
                      ),
                    ),
                    const VerticalDivider(width: 1),
                    // Right Panel: Cart
                    Expanded(
                      flex: 1,
                      child: _CartView(state: state),
                    ),
                  ],
                );
              } else {
                // Mobile/Tablet Layout (Tabbed)
                return DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      const TabBar(
                        tabs: [
                          Tab(icon: Icon(Icons.grid_view), text: 'Catalog'),
                          Tab(icon: Icon(Icons.shopping_cart), text: 'Cart'),
                        ],
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.grey,
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            Column(
                              children: [
                                _CustomerVehicleSelection(state: state),
                                const Divider(),
                                Expanded(child: _CatalogView(state: state)),
                              ],
                            ),
                            _CartView(state: state),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}

class _CustomerVehicleSelection extends StatelessWidget {
  final PosState state;
  const _CustomerVehicleSelection({required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          DropdownButtonFormField<Customer>(
            initialValue: state.selectedCustomer,
            decoration: const InputDecoration(labelText: 'Select Customer'),
            items: state.customers.map((c) {
              return DropdownMenuItem(value: c, child: Text(c.name));
            }).toList(),
            onChanged: (c) {
              if (c != null) context.read<PosBloc>().add(SelectCustomer(c));
            },
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<Vehicle>(
            initialValue: state.selectedVehicle,
            decoration: const InputDecoration(labelText: 'Select Vehicle'),
            items: state.customerVehicles.map((v) {
              return DropdownMenuItem(
                  value: v, child: Text('${v.vehicleBrand} - ${v.licensePlate}'));
            }).toList(),
            onChanged: (v) {
              if (v != null) context.read<PosBloc>().add(SelectVehicle(v));
            },
            // Disable if no customer selected? Or just empty list.
          ),
        ],
      ),
    );
  }
}

class _CatalogView extends StatelessWidget {
  final PosState state;
  const _CatalogView({required this.state});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'Services'),
              Tab(text: 'Products'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                // Services Grid
                GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: state.availableServices.length,
                  itemBuilder: (context, index) {
                    final service = state.availableServices[index];
                    return Card(
                      child: InkWell(
                        onTap: () => context.read<PosBloc>().add(AddServiceToCart(service)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.cleaning_services, size: 32),
                            const SizedBox(height: 4),
                            Text(service.name, textAlign: TextAlign.center),
                            Text('\$${service.price}',
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                // Products Grid
                GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: state.availableProducts.length,
                  itemBuilder: (context, index) {
                    final product = state.availableProducts[index];
                    return Card(
                      child: InkWell(
                        onTap: () => context.read<PosBloc>().add(AddProductToCart(product)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.shopping_bag, size: 32),
                            const SizedBox(height: 4),
                            Text(product.name, textAlign: TextAlign.center),
                            Text('\$${product.price}',
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CartView extends StatefulWidget {
  final PosState state;
  const _CartView({required this.state});

  @override
  State<_CartView> createState() => _CartViewState();
}

class _CartViewState extends State<_CartView> {
  String _selectedPaymentMethod = 'cash';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.grey.shade200,
          width: double.infinity,
          child: Text('Current Order', style: Theme.of(context).textTheme.headlineSmall),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.state.cartItems.length,
            itemBuilder: (context, index) {
              final item = widget.state.cartItems[index];
              return ListTile(
                title: Text(item.name),
                subtitle: Text('${item.quantity} x \$${item.price}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('\$${item.subtotal}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.grey),
                      onPressed: () => context.read<PosBloc>().add(RemoveItemFromCart(index)),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Text('Payment: '),
                  const SizedBox(width: 8),
                  DropdownButton<String>(
                    value: _selectedPaymentMethod,
                    items: const [
                      DropdownMenuItem(value: 'cash', child: Text('Cash')),
                      DropdownMenuItem(value: 'card', child: Text('Card')),
                      DropdownMenuItem(value: 'transfer', child: Text('Transfer')),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedPaymentMethod = val);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('\$${widget.state.totalAmount}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: widget.state.cartItems.isEmpty
                      ? null
                      : () {
                          context
                              .read<PosBloc>()
                              .add(SubmitOrder(paymentMethod: _selectedPaymentMethod));
                        },
                  child:
                      const Text('Checkout', style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
