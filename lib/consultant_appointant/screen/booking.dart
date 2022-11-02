import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../controller/home_controller.dart';
import '../model/expert.dart';

class BookingPage extends StatefulWidget {
  final ExpertModel expertModel;
  const BookingPage({
    Key? key,
    required this.expertModel,
  }) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final HomeController homeController = Get.find();

  final TextEditingController address = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();

  @override
  void dispose() {
    homeController.setBookingDate(DateTime.now());
    homeController.setBookingTime(TimeOfDay.now());
    homeController.setAddress('');
    homeController.setPhone('');
    homeController.setName('');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 550,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
            ),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        "Booking Appointment Schedule",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          wordSpacing: 1,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Date",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.calendar_today),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final DateTime? _dateTime = await showDatePicker(
                                context: context,
                                initialDate: homeController.bookingDate.value,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(DateTime.now().year + 1),
                              );
                              if (_dateTime != null) {
                                homeController.setBookingDate(_dateTime);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Obx(
                                    () => Text(
                                      "${homeController.bookingDate.value.day}-${homeController.bookingDate.value.month}-${homeController.bookingDate.value.year}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Time",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(CupertinoIcons.clock),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final TimeOfDay? _timeOfDay =
                                  await showTimePicker(
                                context: context,
                                initialTime: homeController.bookingTime.value,
                              );

                              if (_timeOfDay != null) {
                                homeController.setBookingTime(_timeOfDay);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Obx(
                                    () => Text(
                                      "${homeController.bookingTime.value.hour}-${homeController.bookingTime.value.minute}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                      ],
                    ),
                    Container(
                      height: 0.2,
                      margin: EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                      ),
                      color: Colors.black,
                    ),
                    Row(
                      children: [
                        Icon(Icons.person),
                        SizedBox(width: 10),
                        Text(
                          "Booking Information",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            wordSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: name,
                      onChanged: homeController.setName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Name',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: phone,
                      onChanged: homeController.setPhone,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Phone',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    TextField(
                      controller: address,
                      onChanged: homeController.setAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Contact Email',
                      ),
                    ),


                    SizedBox(
                      height: 20,
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(

                          onPressed: () {
                             homeController
                                .booking(widget.expertModel.id!);
                            address.clear();
                            name.clear();
                            phone.clear();

                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.pinkAccent,),

                          child: Obx(
                            () => homeController.isloading.value
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 1,
                                  )
                                : Text("Submit"),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
