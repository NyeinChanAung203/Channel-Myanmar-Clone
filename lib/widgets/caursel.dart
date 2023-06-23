
// class CarouselDemo extends StatelessWidget {
//   const CarouselDemo({super.key});

//   @override
//   Widget build(BuildContext context) => CarouselSlider.builder(
//         itemBuilder: (context, index, realIndex) {
//           final latestMovie =
//               context.watch<LatestProvider>().latestMovies[index];
//           return ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//               decoration: const BoxDecoration(
//                   color: Colors.black87,
//                   borderRadius:
//                       BorderRadius.only(bottomLeft: Radius.circular(10))),
//               child: CachedNetworkImage(
//                 imageUrl: latestMovie.imgUrl,
//                 fit: BoxFit.cover,
//                 placeholder: (context, url) => const CupertinoActivityIndicator(
//                   radius: 10,
//                   color: Colors.grey,
//                 ),
//                 errorWidget: (context, url, error) => const Icon(Icons.error),
//               ),
//             ),
//           );
//         },
//         itemCount: 2,
//         options: CarouselOptions(
//           height: 222,
//           aspectRatio: 16 / 9,
//           viewportFraction: 0.4,
//           initialPage: 0,
//           enableInfiniteScroll: true,
//           reverse: false,
//           autoPlay: true,
//           autoPlayInterval: const Duration(seconds: 3),
//           autoPlayAnimationDuration: const Duration(milliseconds: 800),
//           autoPlayCurve: Curves.fastOutSlowIn,
//           enlargeCenterPage: true,
//           enlargeFactor: 0.25,
//           scrollDirection: Axis.horizontal,
//         ),
//       );
// }
