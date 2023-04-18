import 'package:dalilk/constant/custom_appbar.dart';
import 'package:dalilk/constant/custom_button.dart';
import 'package:dalilk/cubit/category_cubit.dart';
import 'package:dalilk/screens/category_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: 'دليلك في ايدك'),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                title: "رباطات",
                onTap: () {
                   Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CategoryScreen(title: "رباطات",categoryId:"firstCategory"),
                  ),);
                   CategoryCubit.get(context).getCategoryItems("firstCategory");
                }
              ),
              CustomButton(
                title: "صفارات",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CategoryScreen(title: "صفارات",categoryId:"secondCategory"),
                  ),);
                  CategoryCubit.get(context).getCategoryItems("secondCategory");
                },
              ),
              CustomButton(
                title: "جمع",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CategoryScreen(title: "جمع",categoryId:"thirdCategory"),
                  ),);
                  CategoryCubit.get(context).getCategoryItems("thirdCategory");
                },
              ),
              CustomButton(
                title: "شارات",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CategoryScreen(title: "شارات",categoryId:"forthCategory"),
                  ),);
                  CategoryCubit.get(context).getCategoryItems("forthCategory");
                },
              ),
              CustomButton(
                title: "شعارات",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CategoryScreen(title: "شعارات",categoryId:"fifthCategory"),
                  ),);
                  CategoryCubit.get(context).getCategoryItems("fifthCategory");
                },
              ),
              CustomButton(
                title: "game theory",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CategoryScreen(title: "game theory",categoryId:"gameTheory"),
                  ),);
                  CategoryCubit.get(context).getCategoryItems("gameTheory");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
