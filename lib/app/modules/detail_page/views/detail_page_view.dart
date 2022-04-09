import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:weather_app/widgets/big_text.dart';
import 'package:weather_app/widgets/small_text.dart';

import '../../../../widgets/text_icon.dart';
import '../../../../widgets/ui_icons.dart';
import '../controllers/detail_page_controller.dart';

class DetailPageView extends GetView<DetailPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: controller.weekList.length,
        itemBuilder: (context, indexPage) {
          return Container(
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 10),
            color: Colors.lightBlue[300],
            child: StickyHeader(
              overlapHeaders: true,
              header: Container(
                height: 50,
                color: Colors.lightBlue[300],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BigText(
                            color: Colors.white,
                            text: DateFormat.EEEE().format(DateTime.parse(
                                controller.weekList[indexPage][0].dtTxt!))),
                        SmallText(
                            color: Colors.white,
                            text: DateFormat.yMd().format(DateTime.parse(
                                controller.weekList[indexPage][0].dtTxt!))),
                      ],
                    ),
                  ],
                ),
              ),
              content: ListView(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SmallText(
                            color: Colors.white,
                            text:
                                'Selamat ${controller.greet(int.parse(DateFormat.H().format(DateTime.now())))}',
                            align: TextAlign.left,
                          ),
                          BigText(
                            color: Colors.white,
                            text: controller.user.capitalizeFirst!,
                            align: TextAlign.left,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SmallText(
                            color: Colors.white,
                            text: 'INDONESIA',
                            align: TextAlign.right,
                          ),
                          BigText(
                            color: Colors.white,
                            text: controller.forecast.city!.name!,
                            align: TextAlign.right,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BigText(
                          color: Colors.white,
                          text:
                              '${controller.weekList[indexPage][0].main!.temp!.round()}°C',
                          size: 80,
                        ),
                        BigText(
                          color: Colors.white,
                          text: controller
                              .weekList[indexPage][0].weather![0].description!,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    childAspectRatio: 4 / 5,
                    crossAxisCount: 3,
                    crossAxisSpacing: 15,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: textIcon(
                            icon: UiIcons.humidity,
                            iconLabel: 'humidity',
                            text: controller
                                .weekList[indexPage][0].main!.humidity!
                                .toString(),
                            size: 10),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: textIcon(
                          icon: UiIcons.pressure,
                          iconLabel: 'pressure',
                          text: controller
                              .weekList[indexPage][0].main!.pressure!
                              .toString(),
                          size: 10,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: textIcon(
                          icon: UiIcons.wind,
                          iconLabel: 'wind',
                          text:
                              '${controller.weekList[indexPage][0].wind!.speed!} m/s',
                          size: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.white.withOpacity(0.3),
                    height: 30,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemCount: controller.weekList[indexPage].length - 1,
                    itemBuilder: (context, indexTile) => Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 59, 248, 255),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: SmallText(
                              text: DateFormat.jms().format(DateTime.parse(
                                  controller
                                      .weekList[indexPage][indexTile].dtTxt!))),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          margin: const EdgeInsets.only(top: 15),
                          height: 110,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              textIcon(
                                size: 5,
                                icon: UiIcons.humidity,
                                iconLabel: 'humidity',
                                text: controller
                                    .weekList[indexPage][indexTile + 1]
                                    .main!
                                    .humidity!
                                    .toString(),
                              ),
                              textIcon(
                                size: 5,
                                icon: UiIcons.pressure,
                                iconLabel: 'pressure',
                                text: controller
                                    .weekList[indexPage][indexTile + 1]
                                    .main!
                                    .pressure!
                                    .toString(),
                              ),
                              textIcon(
                                size: 5,
                                icon: UiIcons.wind,
                                iconLabel: 'wind',
                                text:
                                    '${controller.weekList[indexPage][indexTile + 1].wind!.speed!.toString()} m/s',
                              ),
                              textIcon(
                                size: 5,
                                isIcon: false,
                                idImg: controller
                                    .weekList[indexPage][indexTile + 1]
                                    .weather![0]
                                    .icon!,
                                iconLabel: controller
                                    .weekList[indexPage][indexTile + 1]
                                    .weather![0]
                                    .main!,
                                text:
                                    '${controller.weekList[indexPage][indexTile + 1].main!.temp!.round().toString()}°C',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
