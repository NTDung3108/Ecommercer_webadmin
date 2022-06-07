
bool regexPhone(String phone) =>
    RegExp(r"^((.+84|0)[3|4|5|6|7|8|9])([0-9]{8})+$").hasMatch(phone);

bool emailValid(String email) => RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
    .hasMatch(email);

checkPhone(String? value) {
  if (value == null) value = '';
  if (!regexPhone(value) || value.length > 12 || value.length < 10)
    return phoneError;
  return '';
}

checkEmail(String? value) {
  if (!emailValid(value ?? '')) return emailError;
  return '';
}

String convertStatus(int i){
  if(i == -1){
    return 'Cancle';
  }else if(i == 0){
    return 'New Order';
  }else if(i == 1){
    return 'Transport';
  }else{
    return 'Complete';
  }
}

int chartData(int i){
  if(1000<i && i < 10000){
    return 1000;
  }else if(10000<=i && i<100000){
    return 10000;
  }else if(100000<=i && i<1000000){
    return 100000;
  }else if(1000000<=i && i<10000000) {
    return 1000000;
  }else if(10000000<=i && i<100000000) {
    return 10000000;
  }else{
    return 100000000;
  }
}

String formatChartDataX(int i, int data){
  if(1000<i && i < 10000){
    return '${data}k';
  }else if(10000<=i && i<100000){
    return '${data}0k';
  }else if(100000<=i && i<1000000){
    return '${data}00k';
  }else if(1000000<=i && i<10000000) {
    return '${data}m';
  }else if(10000000<=i && i<100000000) {
    return '${data}0m';
  }else{
    return '${data}00m';
  }
}

const String phoneNumberNullError = "Please Enter your phone number";
const String phoneError = "Invalid phone number";
const String emailError = "Invalid email";
