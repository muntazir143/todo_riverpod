import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_riverpod/core/common/widgets/filled_field.dart';
import 'package:todo_riverpod/core/common/widgets/white_space.dart';
import 'package:todo_riverpod/core/helper/db_helper.dart';
import 'package:todo_riverpod/core/res/color_res.dart';
import 'package:todo_riverpod/features/authentication/views/signin_screen.dart';
import 'package:todo_riverpod/features/todo/views/add_task_screen.dart';
import 'package:todo_riverpod/features/todo/widgets/pending_tasks.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 2);
    final tabTextStyle = GoogleFonts.poppins(
      fontSize: 16,
      color: ColorsRes.darkBackground,
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(85),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RotatedBox(
                      quarterTurns: 2,
                      child: IconButton(
                        onPressed: () {
                          final navigator = Navigator.of(context);
                          DBHelper.deleteUser();
                          navigator.pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (_) => const SignInScreen()),
                              (route) => false);
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: ColorsRes.light,
                          size: 30,
                        ),
                      ),
                    ),
                    Text(
                      'Task Management',
                      style: GoogleFonts.poppins(
                        color: ColorsRes.light,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const AddTaskScreen()));
                      },
                      icon: const Icon(
                        Icons.add_box,
                        color: ColorsRes.light,
                        size: 30,
                      ),
                    )
                  ],
                ),
                const WhiteSpace(
                  height: 20,
                ),
                const FilledField(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  hintText: 'Search',
                  suffixIcon: Icon(
                    Icons.account_tree,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
          children: [
            Row(
              children: [
                const Icon(
                  Icons.task_alt_rounded,
                  size: 30,
                  color: ColorsRes.light,
                ),
                const WhiteSpace(
                  width: 10,
                ),
                Text(
                  "Today's Task",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: ColorsRes.light,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const WhiteSpace(
              height: 25,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: ColorsRes.light,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                controller: tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Colors.transparent,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey,
                ),
                tabs: [
                  Tab(
                    child: Text(
                      'Pending',
                      style: tabTextStyle,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Completed',
                      style: tabTextStyle,
                    ),
                  ),
                ],
              ),
            ),
            const WhiteSpace(
              height: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.26,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: TabBarView(
                  controller: tabController,
                  children: [
                    PendingTasks(),
                    ColoredBox(color: Colors.blue),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
