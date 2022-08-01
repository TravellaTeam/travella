import 'package:flutter/material.dart';
import 'package:travella_01/pages/information_page/constants.dart';

class InformationText extends StatelessWidget {
  const InformationText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding * 1.5, defaultPadding, 0),
      child: Text(
          style: defaultTextStyle(),
          """Yığılca İlçesi Yağcılar Köyü'nde bulunan Saklıkent Şelalesi, Yedigöller yolu güzergahında, Düzce’ye 45 kilometre, ilçe merkezine ise 5 kilometre mesafededir. Düzce'nin keşfedilmesi gereken doğal güzelliklerinden olan şelale, ‘‘Yığılca Saklıkent Şelalesi Peyzaj Projesi’’ ile gerekli çevre düzenlemeleri yapılarak bölgenin piknik ve mesire alanı olarak hareketlenmesi sağlanmıştır."""),
    );
  }
}