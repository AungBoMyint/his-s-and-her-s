import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kzn/controller/enroll_controller.dart';
import 'package:kzn/data/constant.dart';

class EnrollFormRoute extends StatefulWidget {
  static const routeName = '/enroll_route';
  const EnrollFormRoute({Key? key}) : super(key: key);

  @override
  State<EnrollFormRoute> createState() => _EnrollFormRouteState();
}

class _EnrollFormRouteState extends State<EnrollFormRoute> {
  @override
  void initState() {
    Get.put(EnrollController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<EnrollController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    EnrollController controller = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text("Student Enrollment",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16.0,
                letterSpacing: 2,
                wordSpacing: 2,
                color: Colors.black)),
      ),
      body: Obx(() => controller.coursePriceList.isNotEmpty
          ? Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Name and Phone FormField
                Text("အမည်", style: courseLabel),
                const SizedBox(height: 5),
                TextFormField(
                  controller: controller.nameController,
                  validator: controller.nameInputValidator,
                  decoration: InputDecoration(
                    hintText: "Name",
                    border: formBorder,
                  ),
                ),
                const SizedBox(height: 15),
                Text("ဖုန်းနံပါတ်", style: courseLabel),
                const SizedBox(height: 5),
                TextFormField(
                  controller: controller.phoneController,
                  keyboardType: TextInputType.phone,
                  validator: controller.phoneInputValidator,
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                    border: formBorder,
                  ),
                ),
                const SizedBox(height: 15),
                //Course Multiple Checkbox
                Text("တက်ရောက်လိုသော အတန်းများကို ရွေးချယ်ပါ",
                    style: courseLabel),
                Obx(() {
                  final list = controller.coursePriceList;
                  return SizedBox(
                    height: list.length * 50,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 50,
                          child: CheckboxListTile(
                              controlAffinity:
                              ListTileControlAffinity.leading,
                              contentPadding: EdgeInsets.all(0),
                              value: list[index].isSelected,
                              onChanged: (val) => controller
                                  .changeCheckboxValue(val!, index),
                              title: ListTile(
                                title: Text(
                                  list[index].courseName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: courseLabel,
                                ),
                                subtitle: Text(
                                  "သင်တန်းကြေး: ${list[index].coursePrice} ကျပ်",
                                ),
                              )),
                        );
                      },
                    ),
                  );
                }),
                const SizedBox(height: 15),
                //Total Price
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "စုစုပေါင်း: ${controller.totalPrice.value} ကျပ်",
                    )),
                const SizedBox(height: 30),
                //Payment Options

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          "assets/images/kbz.png",
                          width: 112,
                          height: 63,
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          " Zin Mar Aung",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black,
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            Clipboard.setData(new ClipboardData(
                                text: "02930102903306101"))
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "KBZ Account နံပါတ် 029 301 0290 3306 101 ကို Copy ကူး လိုက်ပါပြီ")));
                            });
                          },
                          child: const Text('029 301 0290 3306 101'),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          "assets/images/kpay.png",
                          width: 112,
                          height: 63,
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          " Zin Mar Aung",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black,
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            Clipboard.setData(new ClipboardData(
                                text: "09969545215"))
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "KBZ Pay Account နံပါတ် 09 969 5452 15 ကို Copy ကူး လိုက်ပါပြီ")));
                            });
                          },
                          child: const Text('09 969 5452 15'),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          "assets/images/wavepay.jpeg",
                          width: 112,
                          height: 63,
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          " 09 969 5452 15",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black,
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            Clipboard.setData(new ClipboardData(
                                text: "09969545215"))
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Wave Account နံပါတ် 09 969 5452 15 ကို Copy ကူး လိုက်ပါပြီ")));
                            });
                          },
                          child: const Text(
                            'Password မလိုပါ',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          "assets/images/aya.png",
                          width: 112,
                          height: 63,
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          " Zin Mar Aung",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black,
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            Clipboard.setData(new ClipboardData(
                                text: "0241222010005635"))
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "AYA Bank Account နံပါတ် 0241 2220 1000 5635 ကို Copy ကူး လိုက်ပါပြီ")));
                            });
                          },
                          child: const Text('0241 2220 1000 5635'),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          "assets/images/cbbank.png",
                          width: 112,
                          height: 63,
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          " Zin Mar Aung",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black,
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            Clipboard.setData(new ClipboardData(
                                text: "2009600100007625"))
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "CB Bank Account နံပါတ် 2009 6001 0000 7625 ကို Copy ကူး လိုက်ပါပြီ")));
                            });
                          },
                          child: const Text('2009 6001 0000 7625'),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 15),
                //Bank ScreenShot
                Text("ငွေလွှဲခဲ့သော Bank Screenshot ကို ရွေးချယ်ပါ",
                    style: courseLabel),
                const SizedBox(height: 5),
                SizedBox(
                    height: 50,
                    child: Obx(() {
                      return Row(children: [
                        //OutlineButton to get Image
                        OutlinedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey.shade300,
                          ),
                          onPressed: () => getBankScreenshot(controller),
                          child: Text(
                            "Choose Screenshot",
                            style: courseLabel.copyWith(fontSize: 16),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            controller.bankSs.isEmpty
                                ? "No file chosen"
                                : controller.bankSs.value,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ]);
                    })),
                SizedBox(height: 15),

                Text("ငွေလွှဲခဲ့သော Bank Account ကို ရွေးချယ်ပါ",
                    style: courseLabel),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Obx(() {
                    return DropdownButton<String>(
                      underline: const SizedBox(),
                      isExpanded: true,
                      alignment: Alignment.center,
                      value: controller.paymentAccValue.value,
                      onChanged: (val) =>
                          controller.changePaymentAccValue(val),
                      items: paymentAccList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          onTap: () =>
                              controller.changePaymentAccValue(value),
                          value: value,
                          child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(value)),
                        );
                      }).toList(),
                    );
                  }),
                ),

                const SizedBox(height: 30),
                //Facebook Profile ScreenShot
                Text("Facebook Account Profile Screenshot",
                    style: courseLabel),
                const SizedBox(height: 5),
                SizedBox(
                    height: 50,
                    child: Obx(() {
                      return Row(children: [
                        //OutlineButton to get Image
                        OutlinedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey.shade300,
                          ),
                          onPressed: () =>
                              getFacebookProfileScreenshot(controller),
                          child: Text(
                            "Choose Screenshot",
                            style: courseLabel.copyWith(fontSize: 16),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            controller.facebookProfileSs.isEmpty
                                ? "No file chosen"
                                : controller.facebookProfileSs.value,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ]);
                    })),

                SizedBox(height: 15),

                const SizedBox(width: 15),
                Obx(() => SizedBox(
                  height: 50,
                  width: size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pinkAccent,
                    ),
                    onPressed: () => controller.isUploading.value
                        ? null
                        : controller.uploadEnroll().then((value) =>
                    value
                        ? Navigator.of(context).pop()
                        : null),
                    child: controller.isUploading.value
                        ? SizedBox(
                        height: 50,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ))
                        : Text("အတန်းအပ်မည်",
                        style: inputLabel.copyWith(
                            color: Colors.white)),
                  ),
                )),
              ],
            ),
          ),
        ),
      )
          : Center(
        child: const SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(),
        ),
      )),
    );
  }

  getBankScreenshot(EnrollController controller) async {
    try {
      final XFile? image =
      await ImagePicker().pickImage(source: ImageSource.gallery);
      controller.setBankSs(image!.path);
    } catch (e) {
      debugPrint("Error Bank Slip Image Picking");
    }
  }

  getFacebookProfileScreenshot(EnrollController controller) async {
    try {
      final XFile? image =
      await ImagePicker().pickImage(source: ImageSource.gallery);
      controller.setFacebookProfileSs(image!.path);
    } catch (e) {
      debugPrint("Error Bank Slip Image Picking");
    }
  }
}