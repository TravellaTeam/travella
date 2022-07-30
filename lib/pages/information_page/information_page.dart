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
//---------------------------Build Function-------------------------------------
  @override
  Widget build(BuildContext context) {

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
                icon: CircleAvatar(
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
                  Container(
                    padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding * 1.5, defaultPadding, defaultPadding),
                    child: Column(
                      children: [
                         Text(
                          style: defaultTextStyle(),
                          """Yığılca İlçesi Yağcılar Köyü'nde bulunan Saklıkent Şelalesi, Yedigöller yolu güzergahında, Düzce’ye 45 kilometre, ilçe merkezine ise 5 kilometre mesafededir. Düzce'nin keşfedilmesi gereken doğal güzelliklerinden olan şelale, ‘‘Yığılca Saklıkent Şelalesi Peyzaj Projesi’’ ile gerekli çevre düzenlemeleri yapılarak bölgenin piknik ve mesire alanı olarak hareketlenmesi sağlanmıştır."""),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              child: Text(
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
                      ],
                    ),
                  )
                ],
              ),
            ),

          ],
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