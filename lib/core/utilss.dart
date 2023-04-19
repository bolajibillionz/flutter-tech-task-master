

bool isExpired({required String date, required DateTime lunchDate }) {
  var expiryDate = DateTime.parse(date);
  return expiryDate.isBefore(lunchDate);
}
