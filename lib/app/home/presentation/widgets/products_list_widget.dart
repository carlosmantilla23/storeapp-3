import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/home/presentation/bloc/home_bloc.dart';
import 'package:storeapp/app/home/presentation/bloc/home_state.dart';
import 'package:storeapp/app/home/presentation/bloc/home_event.dart';
import 'package:storeapp/app/home/presentation/model/product_model.dart';

class ProductsListWidget extends StatefulWidget {
  const ProductsListWidget({super.key});

  @override
  State<ProductsListWidget> createState() => _ProductsListWidgetState();
}

class _ProductsListWidgetState extends State<ProductsListWidget> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<HomeBloc>();
    bloc.add(GetProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeErrorState) {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Error'),
                content: Text(state.message),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'OK');
                      bloc.add(GetProductsEvent());
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          } else if (state is LogoutState) {
            GoRouter.of(context).goNamed("login");
          }
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 20.0),
                  Text(state.message)
                ],
              ),
            );
          } else if (state is EmptyState) {
            return const Center(child: Text("No se encontraron productos"));
          } else if (state is LoadDataState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemCount: state.model.products.length,
                itemBuilder: (context, index) =>
                    ProductItemWidget(state.model.products[index]),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () => GoRouter.of(context).pushNamed("form-product"),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ProductItemWidget extends StatelessWidget {
  final ProductModel product;
  const ProductItemWidget(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    return InkWell(
      onTap: () => GoRouter.of(context)
          .pushNamed("form-product-u", pathParameters: {"id": product.id}),
      onLongPress: () => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Eliminación de Producto'),
          content: Text(
              "¿Seguro que deseas eliminar este producto?: ${product.name}"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
                bloc.add(DeleteProductEvent(id: product.id));
              },
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancelar'),
              child: const Text('Cancelar'),
            ),
          ],
        ),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
                child: Image.network(
                  product.urlImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "\$${product.price}",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
