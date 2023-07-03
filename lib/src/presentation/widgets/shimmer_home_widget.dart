import 'package:cm_movie/src/config/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../screens/home_screen.dart';

class ShimmerHomeWidget extends StatelessWidget {
  const ShimmerHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade800,
          highlightColor: Colors.grey.shade800.withOpacity(0.6),
          child: Column(
            children: [
              const TitleBarWidget(title: 'Movies', onTap: null),
              Expanded(
                child: ListView.builder(
                    itemCount: 20,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              width: 160,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('hello $index'),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 10, top: 5),
                            width: 160,
                            decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(''),
                          )
                        ],
                      );
                    }),
              ),
              const TitleBarWidget(title: 'Series', onTap: null),
              Expanded(
                child: ListView.builder(
                    itemCount: 20,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              width: 160,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('hello $index'),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 10, top: 5),
                            width: 160,
                            decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(''),
                          )
                        ],
                      );
                    }),
              ),
            ],
          )),
    );
  }
}
