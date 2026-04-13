// import 'package:flutter/material.dart';

// class Buildheader extends StatelessWidget {
//   const Buildheader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFF4E9BFF), Color(0xFF3B7DD8)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
//       ),
//       padding: const EdgeInsets.fromLTRB(20, 52, 20, 24),
//       child: Row(
//         children: [
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 RichText(
//                   text: const TextSpan(
//                     children: [
//                       TextSpan(
//                         text: 'Foucs',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w800,
//                           color: Colors.white,
//                         ),
//                       ),
//                       TextSpan(
//                         text: 'UP',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w800,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 Text(
//                   'صباح الخير، عمر! 👋',
//                   style: TextStyle(fontSize: 13, color: Colors.black),
//                 ),
//               ],
//             ),
//           ),
//           Stack(
//             children: [
//               Container(
//                 width: 38,
//                 height: 38,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.withOpacity(0.3),
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(
//                   Icons.notifications_outlined,
//                   color: Colors.black,
//                   size: 20,
//                 ),
//               ),
//               Positioned(
//                 top: 4,
//                 right: 4,
//                 child: Container(
//                   width: 9,
//                   height: 9,
//                   decoration: const BoxDecoration(
//                     color: Colors.amber,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(width: 10),
//           Container(
//             width: 38,
//             height: 38,
//             decoration: const BoxDecoration(
//               color: Colors.blueGrey,
//               shape: BoxShape.circle,
//             ),
//             child: const Center(
//               child: Text(
//                 'ع',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w800,
//                   color: Colors.amber,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
