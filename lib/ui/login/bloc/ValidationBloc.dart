


import 'package:rxdart/subjects.dart';

class ValidationBloc{

  var _isValid = PublishSubject<bool>();


  Stream<bool> get validation => _isValid.stream;

  validatePhoneNumber(String number) async{
    _isValid.sink.add(number.length == 10? true : false);
  }

  validateOTP(String number) async{
    _isValid.sink.add(number.length == 6? true : false);
  }



  dispose(){
    _isValid.close();
  }

}