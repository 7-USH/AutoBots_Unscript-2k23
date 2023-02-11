import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unscript_app/utils/unscript_theme.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    TextEditingController _controller = TextEditingController();

    return Scaffold(
      backgroundColor: UnScriptTheme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Discover",
                style: UnScriptTheme.screenText(
                    size: screenWidth / 6, weight: FontWeight.bold),
              ),
              Text(
                "News about trading!",
                style: UnScriptTheme.appText(
                    size: screenWidth / 17,
                    weight: FontWeight.w400,
                    color: UnScriptTheme.bgTextColor2.withOpacity(0.6)),
              ),
              SizedBox(
                height: screenWidth / 17,
              ),
              CupertinoSearchTextField(
                controller: _controller,
                padding: const EdgeInsets.all(10.0),
                placeholder: 'search',
                onChanged: (value) {},
                onSubmitted: (value) {},
                autocorrect: true,
                backgroundColor: Colors.white,
              ),
              SizedBox(
                height: screenWidth / 6,
              ),
              CardsOfNews(
                screenWidth: screenWidth,
                text: 'news1',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardsOfNews extends StatelessWidget {
  const CardsOfNews({
    super.key,
    required this.screenWidth,
    required this.text,
  });
  final String text;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: UnScriptTheme.bgTextColor2,
      child: SizedBox(
        height: screenWidth / 12,
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
