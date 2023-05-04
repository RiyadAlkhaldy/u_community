validInputAuth(String? text, int max, int min) {
  if (text!.isEmpty)
    return 'The input field is empty';
  else if (text.length < min)
    return 'The minimum input  is $min';
  else if (text.length > max)
    return 'The maximum input  is $max';
  else
    return "";
}
