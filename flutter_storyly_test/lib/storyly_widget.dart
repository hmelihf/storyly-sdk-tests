import 'package:flutter/material.dart';
import 'package:flutter_storyly_test/data.dart';
import 'package:storyly_flutter/storyly_flutter.dart';

class StorylyWidget extends StatefulWidget {
  @override
  _StorylyWidgetState createState() => _StorylyWidgetState();
}

class _StorylyWidgetState extends State<StorylyWidget> {
  static final String storylyInstanceToken =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NfaWQiOjc2MCwiYXBwX2lkIjo0MDUsImluc19pZCI6NDA0fQ.1AkqOy_lsiownTBNhVOUKc91uc9fDcAxfQZtpm3nj40";

  StorylyViewController storylyViewController;

  StorylyParam storylyParam = StorylyParam()
    ..storylyId = storylyInstanceToken
    ..storyHeaderTextIsVisible = false
    ..storyHeaderIconIsVisible = true
    ..storyHeaderCloseButtonIsVisible = true
    ..storyGroupSize = 'small'
    ..storyGroupTextIsVisible = true
    ..storyGroupTextColor = Colors.white
    ..storyGroupListEdgePadding = 20
    ..storyGroupListPaddingBetweenItems = 20
    ..storyGroupIconBorderColorSeen = [Colors.white, Colors.black]
    ..storyGroupIconBorderColorNotSeen = [
      Colors.orange,
      Colors.deepOrangeAccent
    ]
    ..storyGroupIconBackgroundColor = Colors.grey
    ..storyGroupPinIconColor = Colors.purple
    ..storyItemTextColor = Colors.black
    ..storyItemIconBorderColor = [Colors.white, Colors.black]
    ..storyItemProgressBarColor = [Colors.white, Colors.black];

  void onStorylyViewCreated(StorylyViewController storylyViewController) {
    this.storylyViewController = storylyViewController;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        color: Color(0xff132c33),
        child: StorylyView(
          storylyLoaded: (storyGroupList) => print("storylyLoaded"),
          storylyLoadFailed: (errorMessage) {
            print("storylyLoadFailed:err:$errorMessage");
            onFailShowSnackBar(context, "fetch storyly failed",
                this.storylyViewController.refresh);
          },
          storylyActionClicked: (story) => print("storylyActionClicked"),
          storylyEvent: (event) => print("storylyEvent"),
          storylyStoryShown: () => print("storylyStoryShown"),
          storylyStoryDismissed: () => print("storylyStoryDismissed"),
          storylyUserInteracted: (eventPayload) =>
              print("storylyUserInteracted"),
          onStorylyViewCreated: onStorylyViewCreated,
          androidParam: storylyParam,
          iosParam: storylyParam,
        ));
  }
}
