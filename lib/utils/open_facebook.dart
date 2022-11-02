
import 'package:url_launcher/url_launcher.dart';

class OpenFacebook{
  static open(fbProtocolUrl, fallbackUrl) async{
    /* numeric value ကို https://lookup-id.com/ မှာ ရှာပါ */
    // ngwe-shar-soe page id 100577978558887
    // myanquizpro 100613051993989
    //String fbProtocolUrl = "fb://page/100613051993989";
    //String fallbackUrl = "https://www.facebook.com/myanquiz";
    try {
      bool launched = await launch(fbProtocolUrl, forceSafariVC: false);
      print("launching..."+fbProtocolUrl);
      if (!launched) {
        print("can't launch");
        await launch(fallbackUrl, forceSafariVC: false);
      }
    } catch (e) {
      print("can't launch exp "+e.toString());
      await launch(fallbackUrl, forceSafariVC: false);
    }
  }
}

