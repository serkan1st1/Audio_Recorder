import 'package:audio_recorder/View/audio_record_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../Widgets/widgets.dart';
import '../services/record_cstore_service.dart';
import '../utils/generalTextStyle.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

  final List<Widget> _pages = [
    HomeListPage(),
    AudioRecordPage(),
  ];

  void onPageChanged(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.deepPurple.shade800.withOpacity(0.8),
            Colors.deepPurple.shade200.withOpacity(0.8),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _CustomAppBar(),
        bottomNavigationBar: _CustomNavBar(onPageChanged: onPageChanged),
        body: _pages[pageIndex],
      ),
    );
  }
}

class HomeListPage extends StatefulWidget {
  const HomeListPage({
    super.key,
  });

  @override
  State<HomeListPage> createState() => _HomeListPageState();
}

class _HomeListPageState extends State<HomeListPage> {
  late RecordService _service;
  @override
  void initState() {
    super.initState();
    _service = RecordService();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SearchBar(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                StreamBuilder(
                  stream: _service.getRecords(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot mypost =
                                snapshot.data!.docs[index];
                            return AudioListCard(mypost: mypost);
                          });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomNavBar extends StatefulWidget {
  final Function(int) onPageChanged;
  _CustomNavBar({super.key, required this.onPageChanged});

  @override
  State<_CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<_CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.deepPurple.shade100.withOpacity(0.01),
      color: Colors.deepPurple.shade500.withOpacity(0.8),
      animationDuration: Duration(milliseconds: 400),
      onTap: (index) {
        setState(() {
          widget.onPageChanged(index);
        });
      },
      items: [
        Icon(
          Icons.home,
          color: Colors.white,
        ),
        Icon(
          Icons.mic,
          color: Colors.white,
        ),
        Icon(
          Icons.person,
          color: Colors.white,
        )
      ],
    );
  }
}

class _CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const _CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: const Icon(Icons.grid_view_rounded),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          child: const CircleAvatar(
            backgroundImage: NetworkImage(GeneralTextStyle.profileImage),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
