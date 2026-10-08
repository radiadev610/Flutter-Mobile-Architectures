class BookingModel {
  final String bookingId;
  final String eventId;
  final String eventTitle;
  final String attendeeName;
  final String attendeeEmail;
  final String attendeePhone;
  final int ticketsCount;
  final double totalAmount;
  final DateTime bookedAt;

  BookingModel({
    required this.bookingId,
    required this.eventId,
    required this.eventTitle,
    required this.attendeeName,
    required this.attendeeEmail,
    required this.attendeePhone,
    required this.ticketsCount,
    required this.totalAmount,
    required this.bookedAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      bookingId: json['bookingId'] as String,
      eventId: json['eventId'] as String,
      eventTitle: json['eventTitle'] as String,
      attendeeName: json['attendeeName'] as String,
      attendeeEmail: json['attendeeEmail'] as String,
      attendeePhone: json['attendeePhone'] as String,
      ticketsCount: json['ticketsCount'] as int,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      bookedAt: DateTime.parse(json['bookedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'bookingId': bookingId,
        'eventId': eventId,
        'eventTitle': eventTitle,
        'attendeeName': attendeeName,
        'attendeeEmail': attendeeEmail,
        'attendeePhone': attendeePhone,
        'ticketsCount': ticketsCount,
        'totalAmount': totalAmount,
        'bookedAt': bookedAt.toIso8601String(),
      };
}