import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unscript_app/home/models/bond_model.dart';
import 'package:unscript_app/home/models/profile_details_model.dart';
import 'package:unscript_app/home/service/home_service.dart';
import 'package:unscript_app/home/ui_view/bond_card.dart';
import 'package:unscript_app/utils/unscript_theme.dart';

class Home extends StatefulWidget {
  Home({super.key, required this.model});
  ProfileDetailsModel model;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeService service = HomeService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: UnScriptTheme.backgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Hello, \n${widget.model.fullName!.split(" ")[0]}",
                    style: UnScriptTheme.screenText(
                        size: screenWidth / 11, weight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Container(
                        height: screenWidth / 8,
                        width: screenWidth / 8,
                        decoration: BoxDecoration(
                            color: UnScriptTheme.perfectWhite,
                            borderRadius:
                                BorderRadius.circular(screenWidth / 16)),
                        child: const Icon(
                          Icons.notifications,
                          color: UnScriptTheme.backgroundColor,
                        ),
                      ))
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Balance",
                    style: UnScriptTheme.appText(
                        size: screenWidth / 16,
                        weight: FontWeight.w600,
                        color: UnScriptTheme.bgTextColor2.withOpacity(0.6)),
                  ),
                  Text(
                    "₹${widget.model.accountBalance!}",
                    style: UnScriptTheme.screenText(
                        size: screenWidth / 10,
                        weight: FontWeight.bold,
                        color: UnScriptTheme.nearlyBlue),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: UnScriptTheme.buttonStyle(
                          backColor: UnScriptTheme.bgTextColor2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            FontAwesomeIcons.arrowLeftLong,
                            color: UnScriptTheme.backgroundColor,
                          ),
                          Text(
                            "Withdraw",
                            style: UnScriptTheme.screenText(
                                size: screenWidth / 20,
                                weight: FontWeight.bold,
                                color: UnScriptTheme.backgroundColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: UnScriptTheme.buttonStyle(
                          backColor: UnScriptTheme.nearlyBlue),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            FontAwesomeIcons.arrowRightLong,
                            color: UnScriptTheme.perfectWhite,
                          ),
                          Text(
                            "Deposit",
                            style: UnScriptTheme.screenText(
                              size: screenWidth / 20,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 15, bottom: 20),
              child: Text(
                "All Bonds",
                style: UnScriptTheme.screenText(
                    size: screenWidth / 16,
                    weight: FontWeight.bold,
                    color: UnScriptTheme.perfectWhite),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: service.getLiveBonds(context: context),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (_, index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) {
                            return BondCard(model: snapshot.data![index]);
                          });
                    } else {
                      return ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 10,
                          separatorBuilder: (_, index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                          itemBuilder: (_, index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade400,
                              highlightColor: UnScriptTheme.perfectWhite,
                              direction: ShimmerDirection.rtl,
                              child: Container(
                                height: screenWidth / 3.5,
                                decoration: BoxDecoration(
                                    color: UnScriptTheme.nearlyWhite,
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            );
                          });
                    }
                  }),
            )
          ],
        ),
      )),
    );
  }
}
