import 'package:flutter/material.dart';
import 'package:journey_joy_client/Cubits/trip_cubit.dart';
import 'package:journey_joy_client/Screens/tripScreen.dart';
import 'loginScreen.dart'; 
import 'package:go_router/go_router.dart';
import 'Screens/catalogScreen.dart';
export 'package:go_router/go_router.dart';
import 'Screens/attractionScreen.dart';
import 'Dialogs/Add Form/form_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Cubits/attraction_cubit.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AttractionsCubit()),
        BlocProvider(create: (_) => TripsCubit())
      ],
      child: MaterialApp.router(
        title: 'JourneyJoy',
        routerConfig: _router,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color.fromARGB(255, 222, 235, 207),
        ),
      ),
    );
  }
}

final _router = GoRouter(

  routes: [
    GoRoute(
      path: '/',
      name: 'login',
      builder: (context, state) => LoginScreen(),  
    ),

    GoRoute(
      path: '/user/:token',
      builder: (context, state) => catalogScreen(
        token: state.pathParameters['token']!,
      ),
      routes:[
        GoRoute(path: 'trip/:tripId', 
        builder: (context,state)=>
          TripScreen(
            tripId: state.pathParameters['tripId']!, 
            token: state.pathParameters['token']!,
            ),
        
          routes:[
            GoRoute(
              path: 'attraction',
              builder: (context, state) => attractionScreen(
                token: state.pathParameters['token']!,
                tripId: state.pathParameters['tripId']!,
              ),
              routes:[
                GoRoute(
                  path: 'newAttraction',
                  builder: (context, state) => FormDialog(
                    token: state.pathParameters['token']!,
                    tripId: state.pathParameters['tripId']!,
                  ),
                ),
              ],
            )
          ]
        ),
      ],
    ),
  ], 
);