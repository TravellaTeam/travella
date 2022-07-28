import 'package:flutter/material.dart';
import 'package:travella_01/pages/gecici_kesfet_sayfasi_widgeti.dart';

var mainColor = const Color.fromARGB(255, 0, 202, 157);

class InformationPage extends StatefulWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {

  List<Widget> rateValue = [
    Icon(Icons.circle_rounded, color: mainColor,),
    Icon(Icons.circle_rounded, color: mainColor,),
    Icon(Icons.circle_rounded, color: mainColor,),
    Icon(Icons.circle_rounded, color: mainColor,),
    Icon(Icons.circle_outlined, color: mainColor,),
  ];

  List<Widget> actions() {
    return [
      IconButton(
        onPressed: () {
          print("tapped");
        },
        icon: Icon(Icons.star_border),
      ),
      IconButton(
        onPressed: () {
          print("tapped");
        },
        icon: Icon(Icons.alt_route),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    const header = "Saklıkent Şelalesi";
    return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
            //toolbarHeight: 45,
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(37),
                  child: Column(
                    children: [
                      Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.only(top: 3, bottom: 2),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 11,),
                            ...rateValue,
                            SizedBox(width: 7,),
                            Text(
                              "4.2/5.0",
                              style: TextStyle(fontSize: 17),
                            ),
                            SizedBox(width: 7,),
                            Text(
                              "   ●   1.3 KM YAKININDA",
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                          ],
                        )
                      ),
                    ],
                  )),
              pinned: true,
              expandedHeight: 300.0,
              backgroundColor: mainColor,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(bottom: 47, left: 55),
                title: Text(
                  header,
                  style: TextStyle(fontSize: 23, color: Colors.grey.shade800),
                ),
                background: Image.asset(
                  "assets/images/saklikent_selalesi_screenshot_2.png",
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
              leading: IconButton(
                onPressed: () async {
                  /*
                  await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AnaSayfaCenterWidget()));
                   */
                },
                icon: Icon(Icons.arrow_back),
              ),
              actions: actions(),
            ),

            SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.teal[100 * (index % 9)],
                    child: Text('Grid Item $index'),
                  );
                },
                childCount: 20,
              ),
            ),
            SliverFixedExtentList(
              itemExtent: 50.0,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.lightBlue[100 * (index % 9)],
                    child: Text('List Item $index'),
                  );
                },
              ),
            ),
          ],
        )
    );
  }
}
