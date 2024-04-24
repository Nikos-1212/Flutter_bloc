extension StringMultiplication on String {
  String multiply(String other) {
    try {
      final double thisValue = double.parse(this);
      final double otherValue = double.parse(other);
      return '${thisValue * otherValue}';
    } catch (e) {
      return 'Error: Invalid input';
    }
  }
}


