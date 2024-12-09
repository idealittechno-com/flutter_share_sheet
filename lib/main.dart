import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomShareBottomSheet(),
    );
  }
}

class CustomShareBottomSheet extends StatefulWidget {
  const CustomShareBottomSheet({super.key});

  @override
  _CustomShareBottomSheetState createState() => _CustomShareBottomSheetState();
}

class _CustomShareBottomSheetState extends State<CustomShareBottomSheet> {

  List<Map<String, String>> customShareList = [
    {
      "app_name": "Share",
      "assetPath": "assets/app_icons/ic_share.png",
      "app_script": "",
      "play_store_url": "",
      "app_store_url": "",
    },
    {
      "app_name": "Whatsapp",
      "assetPath": "assets/app_icons/ic_whatsapp.png",
      "app_script": "whatsapp://send?text=",
      "play_store_url": "https://play.google.com/store/apps/details?id=com.whatsapp&pcampaignid=web_share",
      "app_store_url": "https://apps.apple.com/in/app/whatsapp-messenger/id310633997",
    },
    {
      "app_name": "Facebook",
      "assetPath":"assets/app_icons/ic_facebook.png",
      "app_script": "fb://facewebmodal/f?href=https://www.facebook.com/sharer/sharer.php?u=",
      // Only working in android
      // "app_script": "https://www.facebook.com/sharer/sharer.php?u=",
      "play_store_url": "https://play.google.com/store/apps/details?id=com.facebook.katana&pcampaignid=web_share",
      "app_store_url": "https://apps.apple.com/in/app/facebook/id284882215",
    },
    {
      "app_name": "SMS",
      "assetPath": "assets/app_icons/ic_sms.png",
      "app_script": "sms://",
      "play_store_url": "",
      "app_store_url": "",
    },
    {
      "app_name": "Copy Link",
      "assetPath": "assets/app_icons/ic_copy_link.png",
      "app_script": "",
      "play_store_url": "",
      "app_store_url": "",
    },
    {
      "app_name": "Instagram",
      "assetPath":"assets/app_icons/ic_snapchat.png",
      "app_script": "in://direct-share/link/?text=",
      "play_store_url": "https://play.google.com/store/apps/details?id=com.instagram.android&pcampaignid=web_share",
      "app_store_url": "https://apps.apple.com/in/app/instagram/id389801252",
    },
    {
      "app_name": "Snapchat",
      "assetPath":"assets/app_icons/ic_snapchat.png",
      "app_script": "snapchat://send?text=",
      "play_store_url": "",
      "app_store_url": "",
    },
    {
      "app_name": "Messenger",
      "app_script": "fb-messenger://",
      "play_store_url": "",
      "app_store_url": "",
    },
    {
      "app_name": "Threads",
      "app_script": "instagram-threads://",
      "play_store_url": "",
      "app_store_url": "",
    },
    {
      "app_name": "X",
      "app_script": "x://",
      "play_store_url": "",
      "app_store_url": "",
    },
  ];

  String shareUrl = "https://google.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Counter Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Counter Value:',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {

                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  showDragHandle: false,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
                  builder: (context) {
                    return DraggableScrollableSheet(
                      initialChildSize: 0.5, // Half-screen initially
                      minChildSize: 0.2, // Minimum size
                      maxChildSize: 1.0, // Fullscreen at max
                      expand: false,
                      snap: true,
                      // shouldCloseOnMinExtent: false,
                      snapSizes: const [
                        0.5,
                        1.0
                      ],
                      builder: (context, scrollController) {
                        return Column(
                          children: [
                            Container(
                              height: 4,
                              width: 32,
                              margin: const EdgeInsets.only(top: 24,bottom: 12),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                controller: scrollController,
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: Text("$index"),
                                    title: const Text("Share Item"),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 80,
                              child: ListView.builder(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                scrollDirection: Axis.horizontal,
                                itemCount: 6,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    splashFactory: NoSplash.splashFactory,
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      Navigator.pop(context);

                                      if (index == 0) {
                                        Share.shareUri(Uri.parse(shareUrl));
                                        return;
                                      } else if (index == 3) {
                                        final Uri smsUri = Uri(
                                          scheme: 'sms',
                                          queryParameters: {'body': shareUrl},
                                        );

                                        if (await canLaunchUrl(smsUri)) {
                                          await launchUrl(smsUri);
                                        } else {
                                          print("Could not launch SMS");
                                        }
                                        return;
                                      } else if (index == 4) {
                                        Clipboard.setData(ClipboardData(text: shareUrl));
                                        return;
                                      }

                                      final Uri url = Uri.parse("${customShareList[index]["app_script"]}$shareUrl");

                                      try{
                                        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                                          throw Exception('Could not launch $url');
                                        }
                                      } catch (e){
                                        print("exception caught ${e.toString()} ");
                                        String storeUrl = "";

                                        if (Platform.isAndroid) {
                                          storeUrl = "${customShareList[index]["play_store_url"]}";
                                        } else {
                                          storeUrl = "${customShareList[index]["app_store_url"]}";
                                        }

                                        if (!await launchUrl(Uri.parse(storeUrl))) {
                                          //Handle error
                                          throw Exception('Could not launch $url');
                                        }
                                      }
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            getIcons(index),
                                            const SizedBox(height: 4),
                                            Text("${customShareList[index]["app_name"]}")
                                          ],
                                        )
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        );
                      },
                    );
                  },
                );
              },
              child: const Text('Share Link'),
            ),
          ],
        ),
      ),
    );
  }

  Widget getIcons(index) {
    if (index == 0 || index == 3) {
      return SizedBox(
        height: 45,
        width: 45,
        child: Material(
          color: Colors.black12,
          type: MaterialType.circle,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Icon(
              index == 0 ? Icons.share : Icons.sms_outlined,
              color: Colors.black,
              size: 26,
            ),
          ),
        ),
      );
    }

    return Container(
      height: 45,
      width: 45,
      decoration: const BoxDecoration(color: Colors.black12, shape: BoxShape.circle),
      padding: const EdgeInsets.all(2),
      child: Image.asset(
        "${customShareList[index]["assetPath"]}",
        color: Colors.black,
        height: 40,
        width: 40,
      ),
    );
  }
}
