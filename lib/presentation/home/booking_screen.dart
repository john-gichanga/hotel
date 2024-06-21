// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hotel/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:hotel/domain/models/booking_model.dart';
import 'package:hotel/domain/models/hotel_model.dart';
import 'package:hotel/domain/models/room_model.dart';
import 'package:hotel/providers/booking_provider.dart';


class BookingScreen extends StatefulWidget {
  final Hotel hotel;
  final Room room;

  const BookingScreen({
    super.key,
    required this.hotel,
    required this.room,
  });

  get roomType => room.type;

  get roomRate => room.rate;

  get isRoomAvailable => room.isAvailable;

  @override
  State<BookingScreen> createState() => _HotelBookingScreenState();
}

class _HotelBookingScreenState extends State<BookingScreen> {
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _numberOfGuests = 1;

  // ignore: non_constant_identifier_names
  get sk_key => null;

  @override
  Widget build(BuildContext context) {
    String userEmail = Provider.of<AuthProvider>(context).user!.email;
    return Scaffold(
      appBar: AppBar(
        title: Text('Book ${widget.hotel.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Check-in Date',
              style: TextStyle(fontSize: 18.0),
            ),
            InkWell(
              onTap: () => _selectDate(context, isCheckIn: true),
              child: Text(
                _checkInDate != null
                    ? '${_checkInDate?.toLocal()}'.split(' ')[0]
                    : 'Select Check-in Date',
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Check-out Date',
              style: TextStyle(fontSize: 18.0),
            ),
            InkWell(
              onTap: () => _selectDate(context, isCheckIn: false),
              child: Text(
                _checkOutDate != null
                    ? '${_checkOutDate?.toLocal()}'.split(' ')[0]
                    : 'Select Check-out Date',
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Number of Guests',
              style: TextStyle(fontSize: 18.0),
            ),
            Slider(
              value: _numberOfGuests.toDouble(),
              min: 1.0,
              max: 10.0,
              divisions: 9,
              label: _numberOfGuests.toString(),
              onChanged: (value) {
                setState(() {
                  _numberOfGuests = value.toInt();
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _checkInDate != null && _checkOutDate != null
                  ? () async {
                      num cost = widget.room.rate * _numberOfGuests.toInt();
                      PayWithPayStack().now(
                          context: context,
                          secretKey: sk_key,
                          customerEmail: userEmail,
                          reference:
                              DateTime.now().microsecondsSinceEpoch.toString(),
                          currency: "KES",
                          amount: "$cost",
                          transactionCompleted: () async {
                            final booking = Booking(
                              hotelName: widget.hotel.name.toString(),
                              checkInDate: _checkInDate!,
                              checkOutDate: _checkOutDate!,
                              numberOfGuests: _numberOfGuests,
                              totalCost:
                                  widget.room.rate * _numberOfGuests.toDouble(),
                              user: context.read<AuthProvider>().user!,
                              room: [widget.hotel.rooms.first],
                            );
                            await context
                                .read<BookingProvider>()
                                .addBooking(booking);
                            _showFlashMessage(context, 'Booking successful!');
                            Navigator.pushReplacementNamed(context, '/home');
                            print("Transaction Successful");
                          },
                          transactionNotCompleted: () {
                            _showFlashMessage(context, 'Transaction aborted!');
                            print("Transaction Not Successful!");
                          },
                          callbackUrl: '');
                    }
                  //   //debug all the values
                  //   print(context.read<AuthProvider>().user?.email);

                  : null,
              child: const Text('Book Now'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context,
      {required bool isCheckIn}) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = pickedDate;
        } else {
          _checkOutDate = pickedDate;
        }
      });
    }
  }

  void _showFlashMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class PayWithPayStack {
  void now(
      {required BuildContext context,
      required secretKey,
      required String customerEmail,
      required String reference,
      required String currency,
      required String amount,
      required Future<Null> Function() transactionCompleted,
      required Null Function() transactionNotCompleted,
      required String callbackUrl}) {}
}
