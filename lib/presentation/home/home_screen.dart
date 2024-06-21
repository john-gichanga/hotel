import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hotel/presentation/home/hotel_rooms_screen.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../domain/models/user_model.dart';
import '../../providers/hotel_provider.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  final UserModel? user;

  MyHomePage({required this.title, super.key, this.user});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (pageController.page == 2) {
        pageController.animateToPage(0,
            duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      } else {
        pageController.nextPage(
            duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HotelProvider()..fetchHotels(),
      child: Scaffold(
        backgroundColor: Color(0xff212435), // Changed background color
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                          "https://e7.pngegg.com/pngimages/84/165/png-clipart-united-states-avatar-organization-information-user-avatar-service-computer-wallpaper-thumbnail.png",
                          fit: BoxFit.cover),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: Text(
                          'Welcome ${widget.user?.displayName ?? ' '}',
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(
                                0xffffffff), // Changed font color to white
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Icon(
                        Icons.search_off_rounded,
                        color: Color(0xffffffff), // Changed icon color to white
                        size: 24,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xff212435), // Changed background color
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(0),
                              padding: const EdgeInsets.all(8),
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                color: Color(0xffffc6e0),
                                shape: BoxShape.circle,
                              ),
                              child: const ImageIcon(
                                NetworkImage(
                                    "https://cdn1.iconfinder.com/data/icons/basi-icon-set-01/100/Fin_copy-37-256.png"),
                                size: 24,
                                color: Color.fromARGB(255, 44, 179, 224),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                              child: Text(
                                "Cities",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12,
                                  color: Color(
                                      0xffffffff), // Changed font color to white
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Add more city widgets here...
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 240,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, position) {
                        List<String> imageUrls = [
                          "https://media.istockphoto.com/id/1193996236/photo/scenic-of-night-urban-cityscape-skyline-and-golden-building-with-twilight-time.jpg?s=2048x2048&w=is&k=20&c=98Eh08jrwH9DQNxx1V7gUOjeEQoJXuX8T7AmVmFy90M=",
                          "https://media.gettyimages.com/id/1428676905/photo/family-going-to-hotel-room-with-luggage.jpg?s=612x612&w=0&k=20&c=IY5e2Sj8Vc80TK6DttKvyZyJ1h5Rc0o685m0GVFgzO8=",
                          "https://media.gettyimages.com/id/1192128830/photo/receptionist-giving-keys-to-hotel-guest.jpg?s=612x612&w=0&k=20&c=tEsOZpUefkgdGek7aildpx8_Elur6EvXZ-3jVs4l7gQ=",
                        ];
                        return Align(
                          alignment: Alignment.topCenter,
                          child: Image.network(
                            imageUrls[position],
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
                        child: SmoothPageIndicator(
                          controller: pageController,
                          count: 3,
                          axisDirection: Axis.horizontal,
                          effect: const ExpandingDotsEffect(
                            dotColor: Color(0xff9e9e9e),
                            activeDotColor: Color(0xff3a57e8),
                            dotHeight: 10,
                            dotWidth: 10,
                            radius: 16,
                            spacing: 8,
                            expansionFactor: 3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Consumer<HotelProvider>(
                builder: (context, provider, child) {
                  if (provider.hotels.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, // Increased to 4 to make cards smaller
                      crossAxisSpacing: 4.0, // Adjusted spacing
                      mainAxisSpacing: 4.0, // Adjusted spacing
                    ),
                    padding: const EdgeInsets.all(8.0), // Adjusted padding
                    itemCount: provider.hotels.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final hotel = provider.hotels[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HotelRoomsScreen(hotel: hotel),
                            ),
                          );
                        },
                        child: Card(
                          color: Color(
                              0xff212435), // Changed card color to match background
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Image.network(
                                  hotel.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(
                                    4.0), // Reduced padding
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      hotel.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            10.0, // Further adjusted font size
                                        color: Color(
                                            0xffffffff), // Changed font color to white
                                      ),
                                    ),
                                    const SizedBox(
                                        height:
                                            2.0), // Further adjusted spacing
                                    Text(
                                      hotel.location,
                                      style: const TextStyle(
                                        fontSize:
                                            8.0, // Further adjusted font size
                                        color: Color(
                                            0xffffffff), // Changed font color to white
                                      ),
                                    ),
                                    const SizedBox(
                                        height:
                                            2.0), // Further adjusted spacing
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size:
                                              10, // Further adjusted icon size
                                        ),
                                        const SizedBox(
                                            width:
                                                2.0), // Further adjusted spacing
                                        Text(
                                          hotel.rating.toString(),
                                          style: const TextStyle(
                                            fontSize:
                                                8.0, // Further adjusted font size
                                            color: Color(
                                                0xffffffff), // Changed font color to white
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
