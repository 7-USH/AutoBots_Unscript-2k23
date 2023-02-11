import 'package:flutter/material.dart';
import '../utils/unscript_theme.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TradeScreen extends StatelessWidget {
  const TradeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: UnScriptTheme.backgroundColor,
      // appBar: AppBar(title: Text('Trade')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 6,
            crossAxisSpacing: 9,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  color: UnScriptTheme.bgTextColor2.withOpacity(0.1),
                ),
                height: (index % 4 + 1) * 100,
                child: Center(
                  child: Text(
                    'text1',
                    style: UnScriptTheme.screenText(
                      size: screenWidth / 16,
                      weight: FontWeight.w100,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
