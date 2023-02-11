// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:unscript_app/news/models/news_model.dart';
import 'package:unscript_app/utils/unscript_theme.dart';

class NewsCard extends StatelessWidget {
  NewsCard({super.key, required this.model});
  NewsModel model;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Text(
              model.title!,
              style: UnScriptTheme.screenText(
                size: screenWidth / 20,
                weight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: screenWidth / 3,
                  width: screenWidth / 3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: NetworkImage(model.image!), fit: BoxFit.fill),
                      border: Border.all(color: UnScriptTheme.backgroundColor)),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: SizedBox(
                  height: screenWidth / 3,
                  width: screenWidth / 3,
                  child: Text(
                    model.desc!,
                    textAlign: TextAlign.left,
                    style: UnScriptTheme.appText(
                        size: screenWidth / 35,
                        weight: FontWeight.w600,
                        color: UnScriptTheme.bgTextColor2.withOpacity(1)),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
