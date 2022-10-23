import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromRGBO(243, 242, 255, 1),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(width:20 ,),
                SizedBox(height:60,child: Image.asset('assets/IBAND LOGO.png')),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'I Band',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(12, 0, 132, 1)),
                  ),
                ),
              ],
            ),
            Container(
              height: 1,
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(vertical: 20),
              color: Colors.grey.withOpacity(0.3),
            ),
            Row(
              children: [
                SizedBox(width: 20,),
                Icon(Icons.double_arrow_outlined),
                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 15,bottom: 15),
                  child: Text(
                    'Target range',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 20,),
                Icon(Icons.history),
                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 15,bottom: 15),
                  child: Text(
                    'Review history',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 20,),
                Icon(Icons.event),
                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 15,bottom: 15),
                  child: Text(
                    'Low glucose events',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 20,),
                Icon(Icons.event),
                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 15,bottom: 15),
                  child: Text(
                    'High glucose events',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Settings',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(width: 20,),
                Icon(Icons.vibration_outlined),
                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 15,bottom: 15),
                  child: Text(
                    'Sound and vibration',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 20,),
                Icon(Icons.access_time),
                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 15,bottom: 15),
                  child: Text(
                    'Time and Date',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 20,),
                Icon(Icons.language),
                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 15,bottom: 15),
                  child: Text(
                    'Language',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: (){
                launchUrl(Uri.parse('https://wa.me/+201091153703'),mode:LaunchMode.externalApplication ) ;
              },
              child: Row(
                children: [
                  SizedBox(width: 20,),
                  Icon(Icons.help_outline),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,top: 15,bottom: 15),
                    child: Text(
                      'Help and support',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
