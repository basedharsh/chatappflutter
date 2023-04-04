import 'package:chatapp/screens/home_sreen.dart';
import 'package:flutter/material.dart';



// class DrawerFb1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {

//     return Drawer(
//         child: Material(
//           color: Color(0xff4338CA),
//           child: ListView(
//             children: <Widget>[
//               Container(
//                 padding: EdgeInsets.all(15.0),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 12),
//                     SearchFieldDrawer(),
//                     const SizedBox(height: 12),
//                     MenuItem(
//                       text: 'Friends',
//                       icon: Icons.people,
//                       onClicked: () => selectedItem(context, 0),
//                     ),
//                     const SizedBox(height: 5),
//                     MenuItem(
//                       text: 'Liked Photos',
//                       icon: Icons.favorite_border,
//                       onClicked: () => selectedItem(context, 1),
//                     ),
//                     const SizedBox(height: 5),
//                     MenuItem(
//                       text: 'Workflow',
//                       icon: Icons.workspaces_outline,
//                       onClicked: () => selectedItem(context, 2),
//                     ),
//                     const SizedBox(height: 5),
//                     MenuItem(
//                       text: 'Updates',
//                       icon: Icons.update,
//                       onClicked: () => selectedItem(context, 3),
//                     ),
//                     const SizedBox(height: 8),
//                     Divider(color: Colors.white70),
//                     const SizedBox(height: 8),
//                     MenuItem(
//                       text: 'Notifications',
//                       icon: Icons.notifications_outlined,
//                       onClicked: () => selectedItem(context, 5),
//                     ),
//                     MenuItem(
//                       text: 'Settings',
//                       icon: Icons.settings,
//                       onClicked: () => selectedItem(context, 6),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//     );
//   } 




//   void selectedItem(BuildContext context, int index) {
//     Navigator.of(context).pop();
//     switch (index) {
//       case 0:
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => Scaffold(), // Page 1
//         ));
//         break;
//       case 1:
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => Scaffold(), // Page 2
//         ));
//         break;
//     }
//   }
// }
// class MenuItem extends StatelessWidget {
//   final String text;
//   final IconData icon;
//   final VoidCallback? onClicked;
  
//   const MenuItem({required this.text,
//     required this.icon,
//     this.onClicked,Key? key, }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final color = Colors.white;
//     final hoverColor = Colors.white70;

//     return ListTile(
//       leading: Icon(icon, color: color),
//       title: Text(text, style: TextStyle(color: color)),
//       hoverColor: hoverColor,
//       onTap: onClicked,
//     );
//   }
// }
// class SearchFieldDrawer extends StatelessWidget {
//   const SearchFieldDrawer({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final color = Colors.white;

//     return TextField(
//       style: TextStyle(color: color,fontSize: 14),
//       decoration: InputDecoration(
//         contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//         hintText: 'Search',
//         hintStyle: TextStyle(color: color),
//         prefixIcon: Icon(Icons.search, color: color,size: 20,),
//         filled: true,
//         fillColor: Colors.white12,
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15),
//           borderSide: BorderSide(color: color.withOpacity(0.7)),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15),
//           borderSide: BorderSide(color: color.withOpacity(0.7)),
//         ),
//       ),
//     );
//   }
// }


// import 'package:chatapp/screens/home_sreen.dart';
// import 'package:flutter/material.dart';

// class trialui extends StatefulWidget {
//   const trialui({Key? key}) : super(key: key);

//   @override
//   State<trialui> createState() => _trialuiState();
// }

// class _trialuiState extends State<trialui> {
//   int _selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: const [
//               TopBar(),
//               SearchInput(),
//               PromoCard(),
//               Headline(),
//               CardListView(),
//               SHeadline(),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         color: Colors.white,
//         child: SizedBox(
//           height: 56,
//           width: MediaQuery.of(context).size.width,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 25.0, right: 25.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconBottomBar(
//                     text: "Home",
//                     icon: Icons.home,
//                     selected: _selectedIndex == 0,
//                     onPressed: () {
//                       setState(() {
//                         _selectedIndex = 0;
//                       });
//                     }),
//                 IconBottomBar(
//                     text: "Restaurants",
//                     icon: Icons.restaurant,
//                     selected: _selectedIndex == 1,
//                     onPressed: () {
//                       setState(() {
//                         _selectedIndex = 1;
//                       });
//                     }),
//                 IconBottomBar(
//                     text: "Map",
//                     icon: Icons.map,
//                     selected: _selectedIndex == 2,
//                     onPressed: () {
//                       setState(() {
//                         _selectedIndex = 2;
//                       });
//                     }),
//                 IconBottomBar(
//                     text: "Profile",
//                     icon: Icons.person,
//                     selected: _selectedIndex == 3,
//                     onPressed: () {
//                       setState(() {
//                         _selectedIndex = 3;
//                       });
//                     })
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class IconBottomBar extends StatelessWidget {
//   IconBottomBar(
//       {Key? key,
//       required this.text,
//       required this.icon,
//       required this.selected,
//       required this.onPressed})
//       : super(key: key);
//   final String text;
//   final IconData icon;
//   final bool selected;
//   final Function() onPressed;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         IconButton(
//           onPressed: (() {
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => HomeScreen()));
//           }),
//           icon: Icon(
//             icon,
//             color: selected ? const Color(0xff15BE77) : Colors.grey,
//           ),
//         ),
//         Text(
//           text,
//           style: TextStyle(
//               fontSize: 14,
//               height: .1,
//               color: selected ? const Color(0xff15BE77) : Colors.grey),
//         )
//       ],
//     );
//   }
// }

// class TopBar extends StatelessWidget {
//   const TopBar({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(25.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Find your\nfavorie food",
//             style: TextStyle(
//                 color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
//           ),
//           Container(
//             decoration: BoxDecoration(boxShadow: [
//               BoxShadow(
//                   offset: const Offset(12, 26),
//                   blurRadius: 50,
//                   spreadRadius: 0,
//                   color: Colors.grey.withOpacity(.25)),
//             ]),
//             child: const CircleAvatar(
//               radius: 25,
//               backgroundColor: Colors.white,
//               child: Icon(
//                 Icons.icecream,
//                 size: 25,
//                 color: Color(0xff53E88B),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class SearchInput extends StatelessWidget {
//   const SearchInput({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:
//           const EdgeInsets.only(top: 8.0, left: 25.0, right: 25.0, bottom: 8.0),
//       child: Container(
//         decoration: BoxDecoration(boxShadow: [
//           BoxShadow(
//               offset: const Offset(12, 26),
//               blurRadius: 50,
//               spreadRadius: 0,
//               color: Colors.grey.withOpacity(.1)),
//         ]),
//         child: TextField(
//           onChanged: (value) {
//             //Do something wi
//           },
//           decoration: const InputDecoration(
//             prefixIcon: Icon(Icons.search),
//             filled: true,
//             fillColor: Colors.white,
//             hintText: 'Search',
//             hintStyle: TextStyle(color: Colors.grey),
//             contentPadding:
//                 EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(15.0)),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.white, width: 1.0),
//               borderRadius: BorderRadius.all(Radius.circular(15.0)),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.white, width: 2.0),
//               borderRadius: BorderRadius.all(Radius.circular(15.0)),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class PromoCard extends StatelessWidget {
//   const PromoCard({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(25.0),
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         height: 150,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             gradient: const LinearGradient(
//                 colors: [Color(0xff53E88B), Color(0xff15BE77)])),
//         child: Stack(
//           children: [
//             Opacity(
//               opacity: .5,
//               child: Image.network(
//                   "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/BACKGROUND%202.png?alt=media&token=0d003860-ba2f-4782-a5ee-5d5684cdc244",
//                   fit: BoxFit.cover),
//             ),
//             Image.network(
//                 "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/Image.png?alt=media&token=8256c357-cf86-4f76-8c4d-4322d1ebc06c"),
//             const Align(
//               alignment: Alignment.topRight,
//               child: Padding(
//                 padding: EdgeInsets.all(25.0),
//                 child: Text(
//                   "Want some\nicecream?",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Headline extends StatelessWidget {
//   const Headline({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(left: 25.0, right: 25.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: const [
//               Text(
//                 "Nearest Restaurants",
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 18,
//                     fontWeight: FontWeight.normal),
//               ),
//               Text(
//                 "The best food close to you",
//                 style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 12,
//                     fontWeight: FontWeight.normal),
//               ),
//             ],
//           ),
//           const Text(
//             "View More",
//             style: TextStyle(
//                 color: Color(0xff15BE77), fontWeight: FontWeight.normal),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SHeadline extends StatelessWidget {
//   const SHeadline({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(left: 25.0, right: 25.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Popular Menu",
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 18,
//                     fontWeight: FontWeight.normal),
//               ),
//               Text(
//                 "The best food for you",
//                 style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 12,
//                     fontWeight: FontWeight.normal),
//               ),
//             ],
//           ),
//           Text(
//             "View More",
//             style: TextStyle(
//                 color: Color(0xff15BE77), fontWeight: FontWeight.normal),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CardListView extends StatelessWidget {
//   const CardListView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 25.0, right: 25.0, bottom: 15.0),
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         height: 175,
//         child: ListView(
//           scrollDirection: Axis.horizontal,
//           children: [
//             Card(
//                 "Vegan",
//                 "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/Resturant%20Image%20(1).png?alt=media&token=461162b1-686b-4b0e-a3ee-fae1cb8b5b33",
//                 "8 min away"),
//             Card(
//                 "Italian ",
//                 "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/Restaurant%20Image.png?alt=media&token=43509b4c-269e-4279-8c88-36dc9ed27a66",
//                 "12 min away"),
//             Card(
//                 "Vegan",
//                 "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/Resturant%20Image%20(1).png?alt=media&token=461162b1-686b-4b0e-a3ee-fae1cb8b5b33",
//                 "15 min away"),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Card extends StatelessWidget {
//   final String text;
//   final String imageUrl;
//   final String subtitle;

//   Card(this.text, this.imageUrl, this.subtitle, {Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 25.0, bottom: 15),
//       child: Container(
//         width: 150,
//         height: 150,
//         padding: const EdgeInsets.all(15.0),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12.5),
//           boxShadow: [
//             BoxShadow(
//                 offset: const Offset(10, 20),
//                 blurRadius: 10,
//                 spreadRadius: 0,
//                 color: Colors.grey.withOpacity(.05)),
//           ],
//         ),
//         child: Column(
//           children: [
//             Image.network(imageUrl, height: 70, fit: BoxFit.cover),
//             Spacer(),
//             Text(text,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 )),
//             SizedBox(
//               height: 5,
//             ),
//             Text(
//               subtitle,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   color: Colors.grey,
//                   fontWeight: FontWeight.normal,
//                   fontSize: 12),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


