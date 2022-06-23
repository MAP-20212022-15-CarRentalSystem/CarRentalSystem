String password;

class ValidationService {
  String emailValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String ageValidator(String value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid age';
    }

    print('here');

    int intValue = int.parse(value);

    if (intValue < 18) {
      return 'Please enter a valid age';
    }

    if (intValue > 100) {
      return 'Please enter a valid age';
    }

    return null;
  }

  String bloodValidator(String value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid blood group';
    }

    String pattern = r'^(A|B|AB|O)[+-]$';
    RegExp regExp = new RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid blood group';
    }

    return null;
  }

  String licenseValidator(String value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid License Number';
    }

    String pattern =
        r'^(([A-Z]{2}[0-9]{2})( )|([A-Z]{2}-[0-9]{2}))((19|20)[0-9][0-9])[0-9]{7}$';
    RegExp regExp = new RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid License Number';
    }

    return null;
  }

  String contactValidator(String value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid phone number';
    }

    if (value.length != 10) {
      return 'Please enter a valid phone number';
    }

    String pattern = r'^[0-9]*$';
    RegExp regExp = new RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  String nameValidator(String value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid name';
    }

    String pattern = r"^[A-Za-z\s]{1,}[\.]{0,1}[A-Za-z\s]{0,}$";
    RegExp regExp = new RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid name';
    }

    return null;
  }
}
