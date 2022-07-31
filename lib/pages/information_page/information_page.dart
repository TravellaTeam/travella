import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travella_01/pages/information_page/constants.dart';



class InformationPage extends StatefulWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  var rateValue = 4.2;
  String header = "Saklıkent Şelalesi";

//---------------------------------Rating Bar-----------------------------------

  RatingBar buildRatingBar() {

    return RatingBar.builder(
      glow: false,
      initialRating: 4.2,
      minRating: 4.2, //eğer bunlara initial rating değerini verirsem sabit bir rating bar elde ediyorum.
      maxRating: 4.2,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 20,
      itemPadding: EdgeInsets.symmetric(horizontal: 1.7),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: mainColor,
      ),
      onRatingUpdate: (rating) {},
    );
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
      IconButton(
        onPressed: () {
          print("tapped");
        },
        icon: CircleAvatar(
          backgroundColor: mainColor,
          child: Icon( //CONST YAPARSAN HATA VERİR!
            size: 28,
            color: Colors.white,
            Icons.alt_route),
        ),
      ),
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
              Text(
                  style: defaultTextStyle(),
                  """Yığılca İlçesi Yağcılar Köyü'nde bulunan Saklıkent Şelalesi, Yedigöller yolu güzergahında, Düzce’ye 45 kilometre, ilçe merkezine ise 5 kilometre mesafededir. Düzce'nin keşfedilmesi gereken doğal güzelliklerinden olan şelale, ‘‘Yığılca Saklıkent Şelalesi Peyzaj Projesi’’ ile gerekli çevre düzenlemeleri yapılarak bölgenin piknik ve mesire alanı olarak hareketlenmesi sağlanmıştır.
Yığılca İlçe Merkezi’nden Yağcılar Köyü’ne günün belirli saatlerinde toplu ulaşım araçları ile ulaşım sağlanmaktadır.
Mükemmel doğa manzaralarıyla karşılaşacağınız şelaleye gitmeden önce tüm ihtiyaçlarınızı karşılamanızı öneririz çünkü şelalelerin bulunduğu bölgede ihtiyaçlarınızı karşılayacağınız işletme bulunmamaktadır.
Şelalenin yer aldığı vadiye yaya olarak inmeniz ve yürümeniz gerekmekte. Zaman zaman dere içerisinden geçmek zorunluluğu olacağından kıyafet ve ayakkabı konusuna dikkat etmeniz gerekmektedir.
"""),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: mainColor),
                    onPressed:() => Navigator.of(context).pop(),
                    child: Text("Kapat")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

//-----------------------------asset Images-------------------------------------

  final assetImages = [
    "assets/images/saklikent_selalesi_1.jpg",
    "assets/images/saklikent_selalesi_2.jpg",
    "assets/images/saklikent-selalesi_3.jfif",
  ];

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
                  background: Image.asset(
                    assetImages.last,
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
                         Container(
                           padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding * 1.5, defaultPadding, 0),
                           child: Text(
                            style: defaultTextStyle(),
                            """Yığılca İlçesi Yağcılar Köyü'nde bulunan Saklıkent Şelalesi, Yedigöller yolu güzergahında, Düzce’ye 45 kilometre, ilçe merkezine ise 5 kilometre mesafededir. Düzce'nin keşfedilmesi gereken doğal güzelliklerinden olan şelale, ‘‘Yığılca Saklıkent Şelalesi Peyzaj Projesi’’ ile gerekli çevre düzenlemeleri yapılarak bölgenin piknik ve mesire alanı olarak hareketlenmesi sağlanmıştır."""),
                         ),
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
                                    onTap:() {

                                    },
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
                                          "Fotoğraflar",
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
                      ],
                    )
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