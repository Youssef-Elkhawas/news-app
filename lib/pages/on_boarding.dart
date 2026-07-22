import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/cubits/fetch_news_cubit/fetch_news_cubit.dart';
import 'package:news_app/pages/news_page.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Lottie.asset("assets/lotties/Global Network.json"),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Globe",
                          style: TextStyle(
                            fontSize: 24,
                            color: Color(0xFF1E3A8A),
                          ),
                        ),
                        Text(
                          "Pulse",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF97316),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Welcome for newest news",
                      style: TextStyle(fontSize: 12, color: Color(0xFF475569)),
                    ),
                  ],
                ),
              ),

              //------navigation bUTTONS---------//
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<FetchNewsCubit>(
                    context,
                  ).fetchNews(category: "General");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return NewsPage();
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2563EB),
                ),
                child: Text(
                  "Explore",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: 26),
            ],
          ),
        ),
      ),
    );
  }
}
