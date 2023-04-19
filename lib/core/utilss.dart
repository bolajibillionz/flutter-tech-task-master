

bool isExpired(String date) {
  var expiryDate = DateTime.parse(date);
  return expiryDate.isBefore(DateTime.now());
}
