import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management/src/presentation/views/user_list_bloc.dart';
import '../../config/config.dart';
import '../../domain/models/product_model.dart';
import '../../utils/utils.dart';
import '../blocs/app/app_bloc.dart';
import '../blocs/get_user_bloc/getuser_bloc.dart';
import '../blocs/product/product_bloc.dart';
import '../blocs/productList/product_list_bloc.dart';
import '../widgets/inventory_card.dart';
import 'enventory/add_product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;
  static const routeName = '/';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                GeneralNavigator(
                    context: context,
                    page: BlocProvider<GetuserBloc>(
                      create: (context) =>
                          GetuserBloc()..add(const InitialGetuserEvent(1, 20)),
                      child: const UserPageList(20, 1),
                    )).navigateFromRight();
              },
              icon: const Icon(CupertinoIcons.person_2_square_stack)),
          _switch(),
          const SizedBox(
            width: 10,
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GeneralNavigator(
              context: context,
              page: BlocProvider<ProductBloc>(
                create: (context) => ProductBloc(),
                child: const AddProduct(),
              )).navigateFromRight();
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => BlocProvider<ProductBloc>(
          //       create: (context) => ProductBloc(),
          //       child: const AddProduct(),
          //     ),
          //   ),
          // );
        },
        tooltip: AppConst.addProductSign,
        child: const Icon(Icons.add),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return BlocBuilder<ProductListBloc, ProductListState>(      
      builder: (context, state) {
        if (state is ProductListInitial) {
          final list = state.productListModel.productList;
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, int index) {
                  final data = ProductModel.fromMap(
                    list[index],
                  );
                  return Dismissible(
                      background: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.red,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Icon(CupertinoIcons.delete_simple,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        context
                            .read<ProductListBloc>()
                            .add(DeleteProductEvent(index));
                      },
                      child: InventoryCards(data: data, index: index));
                }),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _switch() {
    final res = context.read<AppBloc>().state as AppInitial;
    return GestureDetector(
        onTap: () => context.read<AppBloc>().add(UpdateAppLightEvent(
            isLightTheme: res.appModel.isLightTheme ? false : true)),
        child: Icon(
          res.appModel.isLightTheme ? Icons.light : Icons.light_outlined,
          size: 28,
        ));
  }
}
