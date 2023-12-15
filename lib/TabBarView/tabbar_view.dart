import 'package:flutter/material.dart';

class TabbarViewPage extends StatefulWidget {
  const TabbarViewPage({super.key});

  @override
  State<TabbarViewPage> createState() => _TabbarViewPageState();
}

class _TabbarViewPageState extends State<TabbarViewPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  List<Tab> tabs = [
    const Tab(
      child: Text("Teal"),
    ),
    const Tab(
      child: Text("Green"),
    ),
    const Tab(
      child: Text("Blue"),
    ),
    // const Tab(
    //   child: Text("Yellow"),
    // ),
    // const Tab(
    //   child: Text("Red"),
    // ),
    // const Tab(
    //   child: Text("Orange"),
    // ),
    // const Tab(
    //   child: Text("Grey"),
    // ),
  ];

  List<Widget> page = [
    Container(
      color: Colors.teal,
    ),
    Container(
      color: Colors.green,
    ),
    Container(
      color: Colors.blue,
    ),
    // Container(
    //   color: Colors.yellow,
    // ),
    // Container(
    //   color: Colors.red,
    // ),
    // Container(
    //   color: Colors.orange,
    // ),
    // Container(
    //   color: Colors.grey,
    // ),
  ];

  @override
  void initState() {
    tabController =
        TabController(length: tabs.length, vsync: this, initialIndex: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: SizedBox(
            height: 20,
            child: TabBar(
              controller: tabController,
              indicatorColor: Colors.red,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 5,
              // isScrollable: false, // true tih mai tur a ni
              tabs: tabs,
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: page,
      ),
    );
  }
}
