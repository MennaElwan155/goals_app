import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goals_app/colors.dart';
import 'package:goals_app/cubits/goals_cubit/goals_cubit.dart';
import 'package:goals_app/cubits/goals_cubit/goals_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> goals = [];
  TextEditingController controller = TextEditingController();

  void addGoal(String text) {
    setState(() {
      goals.add(text);
    });
    controller.clear();
    Navigator.pop(context);
  }

  void removeGoal(int index) {
    setState(() {
      goals.removeAt(index);
    });
    Navigator.pop(context);
  }

  void showAddGoalDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 16,
        child: Container(
          padding: EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: MyColor.mainColor50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: MyColor.mainColor600,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.edit, color: Colors.white),
                    ),
                    SizedBox(width: 14),
                    Text(
                      "Add New Goal",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: MyColor.mainColor900,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "What do you want to achieve?",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                  fillColor: Colors.grey[50],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: MyColor.mainColor600,
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.all(16),
                  prefixIcon: Icon(Icons.edit_outlined, color: Colors.grey),
                ),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.grey[900],
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.grey[200]!),
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.text.trim().isEmpty) return;
                        addGoal(controller.text.trim());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColor.mainColor700,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, size: 18),
                          SizedBox(width: 8),
                          Text(
                            "Add Goal",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showRemoveGoalDialog(int index) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 16,
        child: Container(
          padding: EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.edit_outlined, color: Colors.white),
                    ),
                    SizedBox(width: 14),
                    Text(
                      "Manage Goal",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.red[900],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18),
              Container(
                decoration: BoxDecoration(
                  color: MyColor.mainColor50,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "#${index + 1} ",
                      style: TextStyle(
                          color: MyColor.mainColor700,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      goals[index],
                      style: TextStyle(
                          color: MyColor.mainColor900,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.grey[900],
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.grey[200]!),
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        removeGoal(index);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[400],
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delete, size: 18),
                          SizedBox(width: 8),
                          Text(
                            "Remove",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>GoalsCubit()..initSql()..getData(),
      child: BlocConsumer<GoalsCubit, GoalsState>(listener: (context, state){
        if (state is InsertSuccessState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Added Successfully')));
        }
      },builder: (context, state){
        return Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 80,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [MyColor.mainColor700, MyColor.mainColor900],
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "My Goals",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      "Track Your Progress",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [MyColor.mainColor100, MyColor.mainColor50]),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: MyColor.mainColor900,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          Icons.track_changes,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${goals.length} Goals",
                            style: TextStyle(
                                color: MyColor.mainColor900,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Text("Keep pushing forward!",
                              style:
                              TextStyle(color: Colors.grey, fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Expanded(
                  child: goals.isEmpty
                      ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.flag,
                            color: MyColor.mainColor200, size: 72),
                        SizedBox(height: 14),
                        Text(
                          "No Goals Yet",
                          style: TextStyle(
                              color: MyColor.mainColor900,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Tap the + button to add your first goal",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  )
                      : ListView.builder(
                      itemCount: goals.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            showRemoveGoalDialog(index);
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 18),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: MyColor.mainColor700,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: MyColor.mainColor500.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.flag,
                                    color: MyColor.mainColor50, size: 28),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(goals[index],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)),
                                      Text("Goal #${index + 1}",
                                          style: TextStyle(
                                              color: MyColor.mainColor200,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios,
                                    color: MyColor.mainColor50, size: 18),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
          floatingActionButton: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: MyColor.mainColor500.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: FloatingActionButton.extended(
                elevation: 0,
                backgroundColor: MyColor.mainColor600,
                onPressed: showAddGoalDialog,
                icon: Icon(Icons.add, color: Colors.white),
                label: Text("Add Goal",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700))),
          ),
        );
      }, ),
    );
  }
}
