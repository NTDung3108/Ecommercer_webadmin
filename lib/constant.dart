
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

const String phoneNumberNullError = "Please Enter your phone number";
const String phoneError = "Invalid phone number";
const String emailError = "Invalid email";
