import 'package:flutter/material.dart';
import 'package:hotel/domain/models/room_model.dart';

import '../../domain/models/hotel_model.dart';
import 'booking_screen.dart';

class RoomDetailsScreen extends StatelessWidget {
  final Room room;
  final Hotel hotel;

  const RoomDetailsScreen({
    super.key,
    required this.room,
    required this.hotel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Details'),
        iconTheme: IconThemeData(color: Colors.white),
        toolbarTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: Color(0xFF5435FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: Card(
            elevation: 10.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Color(0xFF5435FF),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Room Type: ${room.type}',
                    style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Rate: \$${room.rate.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Availability: ${room.isAvailable ? 'Available' : 'Not Available'}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: room.isAvailable
                        ? () {
                            // Debugging print statements
                            print(
                                'Navigating to BookingScreen with hotel: ${hotel.name}, room: ${room.type}');

                            // Navigate to the BookingScreen with the selected room
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BookingScreen(hotel: hotel, room: room),
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color(0xFF5435FF), // Set the background color here
                    ),
                    child: const Text('Book Now'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
