
import 'package:flutter/material.dart';
import 'package:app_visitor/common/common.dart';
import 'package:get/get.dart';

class BottomSheetSecurity extends StatelessWidget {
  final _textTheme = Get.textTheme;

  BottomSheetSecurity({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 50),
      padding: const EdgeInsets.all(50),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'ic_important'.assetImagesPathPNG,
            width: 100,
          ),
          Text(
            'Important Notice',
            style: Get.textTheme.headline5!.w8.textPrimary.size(22),
          ),
          10.verticalSpace,
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              5.verticalSpace,
              ..._notices.keys.toList().map(
                    (e) => _buildItem(title: e, content: _notices[e]!),
                  ),
              Text(
                '''By signing below, you acknowledge you have read the guidelines and instructions above, and afforded an opportunity to copies of environmental, health, and safety rules and guidelines. Failure to follow any rules, guidelines, or instructions may be cause for suspension of access to the processing areas.''',
                style: _textTheme.headline6!.medium.textGrey797979,
              ),
              30.verticalSpace,
              const Text('I got it')
                  .elevatedButton(
                onPressed: Get.back,
              )
                  .wrapWidth(200),
              20.verticalSpace,

            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItem({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              'ic_notice'.assetImagesPathPNG,
              width: 20,
            ),
            8.horizontalSpace,
            Text(
              title,
              style: _textTheme.headline5!.medium,
            ),
          ],
        ),
        10.verticalSpace,
        Text(
          content,
          style: _textTheme.headline6!.textGrey797979.regular,
        ),
        30.verticalSpace,
      ],
    );
  }

  final _notices = {
    'Security Notice':
        '''Security This facility is under 24-hour video surveillance. No camera, camera phones, PDA's, tablet or laptop computers, or portable drives are allowed into production areas unless prior authorization by management. All visitors to this facility are subject to search of their persons and possessions including vehicles. If you have any questions, communicate these to your escort prior to entering the processing areas.''',
    'Safety Notice':
        '''This facility processes various electronics and related components of various types, sizes, and shapes. As such certain Safety Hazards may exist throughout the facility. Safety Rules and Guidelines are available upon request. When being escorted throughout the facility you are instructed to follow and adhere to all signs and warnings, including those communicated by your escort. If you have any questions, communicate these to your escort prior to entering the processing areas.''',
    'Environmental Notice':
        '''This facility has processes and methods designed to reduce or eliminate waste entering landfills, programs such as segregation of materials, recycling, and various other methods depending upon the materials handled. You are required to adhere to all warnings, signs, and instructions while on the premises. Please follow all instructions of your escort. If you have any questions, communicate these to your escort prior to entering the processing areas.'''
  };
}
