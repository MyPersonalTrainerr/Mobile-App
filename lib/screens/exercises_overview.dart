import 'package:flutter/material.dart';
import 'package:my_pt/providers/exercises_provider.dart';
import 'package:my_pt/widgets/app_drawer.dart';
import 'package:my_pt/widgets/exersice_item.dart';
import 'package:my_pt/widgets/lower_bar.dart';
import 'package:provider/provider.dart';

class ExersicesOverviewScreen extends StatelessWidget {
  static const routeName = '/exercise-overview';

  const ExersicesOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exercisesData =
        Provider.of<ExercisesProvider>(context, listen: false);
    final double height =
        MediaQuery.of(context).size.height - AppBar().preferredSize.height - 66;
    final double width = MediaQuery.of(context).size.width;
    // print(height);
    // print(heightt);
    return Scaffold(
      appBar: AppBar(
        title: const Text('YOUR PERSONAL TRAINER'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          // height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // height: height * 0.05,
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(left: 10),
                padding: const EdgeInsets.all(8.0),
                child: Text('ALL EXERCISES',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    ),
              ),
              Container(
                height: height,
                child: ListView.builder(
                  itemBuilder: (context, idx) {
                    return ChangeNotifierProvider.value(
                      value: exercisesData.items[idx],
                      child: ExerciseItem(),
                    );
                  },
                  itemCount: exercisesData.items.length,
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: LowerBar(),
      // drawer: AppDrawer(),
    );
  }
}
