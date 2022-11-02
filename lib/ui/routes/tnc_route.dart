import 'package:flutter/material.dart';

class TnCRoute extends StatefulWidget {
  static final String routeName = "/tnc_route";
  @override
  _TnCRouteState createState() => _TnCRouteState();
}

class _TnCRouteState extends State<TnCRoute> {
  final Color tileColor = Colors.redAccent;
  final Color iconColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.pinkAccent),
        backgroundColor: Colors.white,
        title: Text("Terms & Conditions", style: TextStyle(fontWeight: FontWeight.w700,
            fontSize: 16.0,
            color: Colors.pinkAccent
        )),),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
        child: SingleChildScrollView(child: Text(
            '''
Attendance
Students are expected to attend 100% of their lessons. If a student is ill or cannot attend for any other reason, 
he or she must call the school to inform staff. In any case, students must attend a minimum of 80% of their lessons. 
Failure to do so could result in the school cancelling the course.
Students with an attendance record below 80% will not receive an end-ofcourse certificate.

Courses and classes
The school reserves the right to cancel or alter a course in exceptional circumstances. 
In such cases, the school will either offer a refund or an alternative course. 
The school reserves the right to change teachers during courses. 
Such changes are always kept to the minimum, but are unavoidable when teachers are on holiday or sick.
Very occasionally, the stated maximum class size of 30 may be exceeded. 
Such occurrences are for short periods only. 
In the case of a single student enrolled on a group course, the school reserves the right to offer the cost-equivalent number of individual one-to-one lessons. 
If the student’s level is inappropriate for the course booked, the school reserves the right to move the student to a different course or, 
if preferred, to cancel the course and to refund all tuition fees.

Under 18s
The minimum age for entry into our school is 16. 
For all students below the age of 18, a copy of our Parental Consent Form signed by a parent or guardian must be provided to the school upon or before arrival.
Please note that students are largely unsupervised except during lessons.

Enrollment
Bookings must be made either by emailing the school at info@a1onlinelearning.com or by completing the online application form (top right of the home page) 
on the school's website https://a1onlinelearning.com
The school reserves the right to refuse admission to any student, at the absolute discretion of the school managers. 
If a booking is refused, all fees paid will be refunded.

Fees
All fees must be received in full a minimum of two weeks before the course and/or accommodation starts (unless agreed otherwise by school management). 
If fees are not received by this time, the course and accommodation is cancelled. 
It is not possible for students to start a course or move into accommodation if fees have not been received by the school.

Payment
Payment can be made by bank transfer to the school's account , or by credit card. 
All payments must be made in Ks (MMK).
    '''
        )),
      ),

    );
  }
}


