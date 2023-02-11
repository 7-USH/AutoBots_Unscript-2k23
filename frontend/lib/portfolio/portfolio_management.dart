import 'package:flutter/material.dart';

class PortfolioManagement extends StatelessWidget {
  const PortfolioManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('AppBar Demo'),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Portfolio Management'),
                Text('Your analysis'),
                Row(
                  children: [
                    cardWidget(text: 'Deposits'),
                    cardWidget(text: 'Investments'),
                  ],
                ),
                Row(
                  children: [
                    cardWidget(text: 'Profit'),
                    cardWidget(text: 'Loss'),
                  ],
                ),
                BelowCard(
                  text1: 'Text1',
                  text2: 'Text2',
                  text3: 'Text3',
                ),
                BelowCard(
                  text1: 'Text1',
                  text2: 'Text2',
                  text3: 'Text3',
                ),
                BelowCard(
                  text1: 'Text1',
                  text2: 'Text2',
                  text3: 'Text3',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BelowCard extends StatelessWidget {
  String text1, text2, text3;
  BelowCard({
    Key? key,
    required this.text1,
    required this.text2,
    required this.text3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(text1),
            Text(text2),
            Text(text3),
          ],
        ),
      ),
    );
  }
}

class cardWidget extends StatelessWidget {
  String text;
  cardWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: SizedBox(
          height: 200,
          child: Center(
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
