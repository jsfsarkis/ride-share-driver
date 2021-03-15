import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ride_share_driver/components/general_textfield.dart';
import 'package:ride_share_driver/components/rounded_button.dart';
import 'package:ride_share_driver/constants.dart';
import 'package:ride_share_driver/global_variables.dart';
import 'package:ride_share_driver/screens/home_screen.dart';

class VehicleInfoScreen extends StatelessWidget {
  static const String id = 'vehicle_info_screen';

  TextEditingController carModelController = TextEditingController();
  TextEditingController carColorController = TextEditingController();
  TextEditingController vehicleNumberController = TextEditingController();

  void updateProfile(BuildContext context) {
    String id = currentFirebaseUser.uid;

    DatabaseReference driverRef = FirebaseDatabase.instance
        .reference()
        .child('drivers/$id/vehicle_details');

    Map vehicleInfoMap = {
      'car_color': carColorController.text,
      'car_model': carModelController.text,
      'vehicle_number': vehicleNumberController.text,
    };

    driverRef.set(vehicleInfoMap);

    Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (route) => false);
  }

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  void showSnackBar(String title) {
    final snackbar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15.0,
        ),
      ),
    );
    // ignore: deprecated_member_use
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Image.asset(
                'assets/images/logo.png',
                height: 110,
                width: 110,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 20, 30, 30),
                child: Column(
                  children: [
                    SizedBox(height: 10.0),
                    Text('Enter Vehicle Details'),
                    SizedBox(height: 25.0),
                    GeneralTextField(
                      onChanged: (value) {},
                      controller: carModelController,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      hintText: 'Car Model',
                    ),
                    SizedBox(height: 10.0),
                    GeneralTextField(
                      onChanged: (value) {},
                      controller: carColorController,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      hintText: 'Car Color',
                    ),
                    SizedBox(height: 10.0),
                    GeneralTextField(
                      onChanged: (value) {},
                      controller: vehicleNumberController,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      hintText: 'Vehicle Number',
                    ),
                    SizedBox(height: 40.0),
                    RoundedButton(
                      onPressed: () {
                        if (carModelController.text.length < 3) {
                          showSnackBar('Please provide a valid car model');
                          return;
                        }

                        if (carColorController.text.length < 3) {
                          showSnackBar('Please provide a valid car color');
                          return;
                        }

                        if (vehicleNumberController.text.length < 3) {
                          showSnackBar('Please provide a valid vehicle number');
                          return;
                        }

                        updateProfile(context);
                      },
                      width: MediaQuery.of(context).size.width / 1.4,
                      height: 55,
                      fillColor: colorGreen,
                      title: 'PROCEED',
                      titleColor: Colors.white,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
