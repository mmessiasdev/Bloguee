import 'package:flutter/material.dart';
import 'package:fluttercode/component/colors.dart';
import 'package:shimmer/shimmer.dart';

class PostsLoading extends StatelessWidget {
  const PostsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 480,
      child: Center(
        child: Shimmer.fromColors(
          direction: ShimmerDirection.ltr,
          period: Duration(milliseconds: 2500),
          baseColor: PrimaryColor,
          highlightColor: SecudaryColor,
          child: ListView.builder(
              itemCount: 2,
              // separatorBuilder: (_, __) => const SizedBox(
              //       height: 15,
              //     ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: PrimaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
