class Sales {
  final String label;
  final int earning;

  Sales(this.label, this.earning);
   @override
  String toString() {
    return '{ $label, $earning }';
  }
}
