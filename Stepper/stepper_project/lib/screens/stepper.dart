import 'package:flutter/material.dart';

class StepperExample extends StatefulWidget {
  @override
  _StepperOrnekState createState() => _StepperOrnekState();
}

class _StepperOrnekState extends State<StepperExample> {
  int _currentStep = 0;
  String username, password, mail;
  List<Step> allSteps;
  bool mistake = false;


  var key0 = GlobalKey<FormFieldState>();
  var key1 = GlobalKey<FormFieldState>();
  var key2 = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    allSteps = _allSteps();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(35))
        ),
        title: Text("Stepper Example"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.pink[100],
        child: SingleChildScrollView(
          child: Stepper(
            steps: allSteps,
            currentStep: _currentStep,
            onStepContinue: () {
              setState(() {
                _ileriButonKontrol();
              });
            },
            onStepCancel: () {
              setState(() {
                if (_currentStep > 0) {
                  _currentStep--;
                } else {
                  _currentStep = 0;
                }
              });
            },
          ),
        ),
      ),
    );
  }

  List<Step> _allSteps() {
    List<Step> stepler = [
      Step(
        content: TextFormField(
          key: key0,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person_add,color: Colors.red,size: 35.0,),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          validator: (value) {
            if (value.length < 6) {
              return "It can't be lower than 6 characters";
            } else
              return null;
          },
          onSaved: (value) {
            username = value;
          },
        ),
        title: Text("Username",style: TextStyle(fontSize: 21.0),),
        state: _editSteps(0),
        isActive: true,
      ),
      Step(
        content: TextFormField(
          keyboardType: TextInputType.emailAddress,
          key: key1,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.mail,color: Colors.red,size: 35.0,),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          validator: (value) {
            if (value.length < 6 || !value.contains("@")) {
              return "Invalid entrance";
            }
            else return null;
          },
          onSaved: (girilenDeger) {
            mail = girilenDeger;
          },
        ),
        title: Text("Mail",style: TextStyle(fontSize: 21.0),),
        state: _editSteps(1),
        isActive: true,
      ),
      Step(
        content: TextFormField(
          key: key2,
          decoration: InputDecoration(
            icon: Icon(Icons.lock,color: Colors.red,size: 35.0,),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          validator: (value) {
            if (value.length < 6) {
              return "At least it has to have 8 characters";
            } else
              return null;
          },
          onSaved: (value) {
            password = value;
          },
        ),
        title: Text("Password",style: TextStyle(fontSize: 21.0),),
        state: _editSteps(2),
        isActive: true,
      ),
    ];

    return stepler;
  }

  StepState _editSteps(int oankiStep) {
    //Burada iconlarımızın vereceği görseli ayarlıyoruz.
    if (_currentStep == oankiStep) {
      if (mistake) {
        return StepState.error; //Hata varsa error olan iconu atıyoruz.
      } else {
        return StepState.editing;
      }
    } else {
      return StepState.complete;
    }
  }

  void _ileriButonKontrol() {
    switch (_currentStep) {
      case 0:
        if (key0.currentState.validate()) {
          key0.currentState.save();
          mistake = false;
          _currentStep++;
        } else {
          mistake = true;
        }
        break;
      case 1:
        if (key1.currentState.validate()) {
          key1.currentState.save();
          mistake = false;
          _currentStep++;
        } else {
          mistake = true;
        }
        break;
      case 2:
        if (key2.currentState.validate()) {
          key2.currentState.save();
          formTamamlandi();
        } else {
          mistake = true;
        }
        break;
    }
  }

  void formTamamlandi() {
    debugPrint("İsim : $username,  Mail : $mail,  Şifre : $password");
  }
}
