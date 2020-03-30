import 'package:flutter_test/flutter_test.dart';
import 'package:e_bulletin/widgets/pages/SignIn.dart';

void main() {
  test("Testing Valid email in Sign-in", () {
    List<String> goodEmail = new List<String>();
    goodEmail.add("test@test.com");
    goodEmail.add("test@test.net");
    goodEmail.add("test@test.org");
    goodEmail.add("test@test.edu");
    List<String> badEmail = new List<String>();
    badEmail.add("");
    badEmail.add("hello");
    badEmail.add("sdfjfsfklfj sdlkjf");
    badEmail.add("jslkfjlskdjf@");

    goodEmail.forEach((element) {
      print(element);
      expect(null, isValidEmail(element));
    });
    expect(
      "Please fill out email field.",
      isValidEmail(badEmail[0]),
    );
    for (int i = 1; i < badEmail.length; i++)
      expect("Please enter a valid email address.", isValidEmail(badEmail[i]));
  });
}
