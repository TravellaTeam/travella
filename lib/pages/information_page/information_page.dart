import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travella_01/pages/information_page/constants.dart';

import 'contents/app_bar_background_image.dart';
import 'contents/InformationText.dart';
import 'contents/detailed_information_page.dart';
import 'contents/get_location_in_google_maps.dart';
import 'contents/information_pictures.dart';
import 'contents/pictures_gallery.dart';
import 'contents/rating_bar.dart';



class InformationPage extends StatefulWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  var rateValue = 4.2;
  String header = "Saklıkent Şelalesi";

  late bool burayaGittimMi = false; // kullanıcıya göre kaydedilmesi sağlanmalı

//---------------------------Chack In-------------------------------------------
  Future<bool?> showToast() {
    if(burayaGittimMi){
      return Fluttertoast.showToast(
        msg: "Gittiğim Yerler Listesine Eklendi.",
        toastLength: Toast.LENGTH_SHORT, // length
        gravity: ToastGravity.BOTTOM,    // location
        fontSize: 18,
        backgroundColor: Colors.grey.shade800,
        textColor: Colors.white,
      );
    }else {
      return Fluttertoast.showToast(
        msg: "Gittiğim Yerler Listesinden Kaldırıldı.",
        toastLength: Toast.LENGTH_LONG, // length
        gravity: ToastGravity.BOTTOM,    // location
        fontSize: 18,
        backgroundColor: Colors.grey.shade800,
        textColor: Colors.white,
      );
    }
  }
//--------------------------App Bar Actions Icons-------------------------------

  List<Widget> actions() {
    return [
      IconButton(
        onPressed: () {
          print("tapped");
        },
        icon: CircleAvatar(
          backgroundColor: mainColor,
          child: Icon( //CONST YAPARSAN HATA VERİR!
            size: 28,
            color: Colors.white,
            Icons.star_border)),
      ),
      GetLocationInGoogleMaps(),
    ];
  }

//------------------------Detailed Information Page-----------------------------

  Widget makeDismissable({required Widget child}) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap:() => Navigator.of(context).pop(),
    child: GestureDetector(onTap:() {}, child: child,),
  );
   Widget buildSheet() {
    return makeDismissable(
      child: DraggableScrollableSheet(
        minChildSize: 0.5,
        maxChildSize: 0.9,
        initialChildSize: 0.7,
        builder:(context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(defaultBorderRadius),

            ),
          ),
          padding: const EdgeInsets.fromLTRB(
              defaultPadding, defaultPadding * 1.5, defaultPadding, defaultPadding),
          child: ListView(
            controller: scrollController,
            children: [
              const DetailedInformationText(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: mainColor),
                    onPressed:() => Navigator.of(context).pop(),
                    child: const Text("Kapat")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }



//-----------------------------Open Gallery-------------------------------------
  void openGallery() {
    Navigator.of(context).push(MaterialPageRoute(
      builder:(context) => GalleryWidget(
        assetImages: assetImages, //firebase eklendiğinde asset images parametresi yerine urlImages parametresi getirilebilir
        index: 0,
      ),
      ),
    );
  }

//---------------------------Build Function-------------------------------------
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SafeArea(
          child: CustomScrollView(
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
                              topLeft: Radius.circular(defaultBorderRadius),
                              topRight: Radius.circular(defaultBorderRadius),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 11,),
                              buildRatingBar(),
                              SizedBox(width: 7,),
                              Text(
                                "${rateValue.toString()}/5.0",
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
                expandedHeight: 270.0,
                backgroundColor: mainColor,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(bottom: 43, left: 45),
                  title: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(10),
                      ),
                    child: Text(
                      header,
                      style: TextStyle(fontSize: 23, color: Colors.grey.shade800),
                    ),
                  ),
                  background: AppBarBackgroundImage(assetImages: assetImages), //bu parametrenin yerine firebase nin parametresi gelebilir
                ),
                leading: IconButton(
                  onPressed: () async {
                    /*
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AnaSayfaCenterWidget()));
                     */
                  },
                  icon: const CircleAvatar(
                    backgroundColor: mainColor,
                    child: Icon(
                      color: Colors.white,
                      Icons.arrow_back)),
                ),
                actions: actions(),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Column(
                      children: [
                         InformationText(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              child: Text( //const Verirsen Hata Alırsın
                                style: TextStyle(
                                  fontSize: 16,
                                  color: mainColor,
                                ),
                                "Ayrıntılı Bilgi ➪"),
                              onPressed:() => showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) => buildSheet(),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 3, top: defaultPadding, right: 3, bottom: defaultPadding),
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(defaultBorderRadius),
                            ),
                            child: Stack(
                              children:[
                                Container(
                                  child: InkWell(
                                    onTap: openGallery,
                                    child: Ink.image(
                                      height: 210,
                                      width: double.maxFinite,
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        assetImages[1],
                                      ),
                                      child: Container(
                                        alignment: Alignment.bottomLeft,
                                        padding: const EdgeInsets.fromLTRB(defaultPadding, 0, 0, defaultPadding),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 5),
                                          decoration: BoxDecoration(
                                          color: mainColor,
                                          borderRadius: BorderRadius.circular(defaultBorderRadius),
                                          ),
                                          child: Text(
                                            "${assetImages.length} Fotoğraf",
                                            style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 25,
                                            color: Colors.grey.shade800,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              ElevatedButton(
                                onPressed:() {

                                },
                                style: ElevatedButton.styleFrom(
                                  primary: mainColor,
                                  shape: StadiumBorder(),
                                ),
                                child:Text(
                                  "Haritada Aç",
                                  style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                              ),
                              ElevatedButton.icon(
                                icon: burayaGittimMi ?  Icon(
                                  Icons.beenhere,
                                  color: Colors.grey.shade800,
                                ) :Icon(
                                  Icons.square_outlined,
                                  color: Colors.grey.shade800,
                                ),
                                onPressed:() async {
                                  if(burayaGittimMi){
                                    setState(() {
                                      burayaGittimMi = false;
                                    });
                                    await showToast();
                                  }else{
                                    setState(() {
                                      burayaGittimMi = true;
                                    });
                                    await showToast();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: mainColor,
                                  shape: StadiumBorder(),
                                ),
                                label: Text(
                                  "Buraya Gittim",
                                  style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 300,)
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }

}






/*
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
 */