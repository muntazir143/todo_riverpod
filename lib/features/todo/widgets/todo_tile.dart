import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_riverpod/core/common/widgets/fading_text.dart';
import 'package:todo_riverpod/core/common/widgets/white_space.dart';
import 'package:todo_riverpod/core/extensions/date_extensions.dart';
import 'package:todo_riverpod/core/res/color_res.dart';
import 'package:todo_riverpod/features/todo/models/task_model.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 80.h,
                    width: 5.h,
                    decoration: BoxDecoration(
                      color: ColorsRes.randomColor(),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const WhiteSpace(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadingText(
                        task.title!,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      const WhiteSpace(width: 3),
                      FadingText(
                        task.description!,
                        fontSize: 12,
                      ),
                      const WhiteSpace(width: 10),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ColorsRes.darkBackground,
                              border: Border.all(
                                width: .3,
                                color: Colors.grey[900]!,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                '${task.startTime!.timeOnly} |'
                                ' ${task.endTime!.timeOnly}',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: ColorsRes.light,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
