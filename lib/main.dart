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

  List<String> namesList = [
    "Emma",
    "Charlotte",
    "Ava",
    "Mia",
    "Luci",
    "Nancy",
    "Sophia",
    "Jennifer",
    "Ariana",
    "Claire",
    "Aurora",
    "Jessica"
  ];

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
        title: const Text('Flutter Share Sheet'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(shareUrl),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                var selectedUsers = <int>[];

                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  showDragHandle: false,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return DraggableScrollableSheet(
                          initialChildSize: 0.6, // Half-screen initially
                          minChildSize: 0.3, // Minimum size
                          maxChildSize: 1.0, // Fullscreen at max
                          expand: false,
                          snap: true,
                          shouldCloseOnMinExtent: true,
                          snapSizes: const [
                            0.6,
                            1.0
                          ],
                          builder: (context, scrollController) {
                            return Stack(
                              children: [
                                GridView.builder(
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 3/2.6
                                  ),
                                  padding: const EdgeInsets.only(top: 24),
                                  controller: scrollController,
                                  itemCount: 12,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      splashFactory: NoSplash.splashFactory,
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        if(selectedUsers.contains(index)){
                                          selectedUsers.remove(index);
                                        } else {
                                          selectedUsers.add(index);
                                        }
                                        setState(() {});
                                      },
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                                            child: SizedBox(
                                              width: 84,
                                              child: Stack(
                                                alignment: Alignment.bottomRight,
                                                children: [
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Container(
                                                      width: 76,
                                                      height: 76,
                                                      // margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                                                      clipBehavior: Clip.hardEdge,
                                                      decoration: const BoxDecoration(shape: BoxShape.circle),
                                                      child: Image.asset(
                                                          "assets/user/girl$index.jpg",
                                                          height: 76,
                                                          width: 76,
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),

                                                 if(selectedUsers.contains(index)) Align(
                                                    alignment: Alignment.bottomRight,
                                                    child: Material(
                                                      color: Colors.white,
                                                      type: MaterialType.circle,
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(2),
                                                        child: Container(
                                                          decoration: const BoxDecoration(
                                                            color: Colors.blue,
                                                            shape: BoxShape.circle,
                                                          ),
                                                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
                                                          child: const Icon(Icons.check,
                                                              color: Colors.white,
                                                              size: 16),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Text(
                                            namesList[index],
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    color: Colors.white,
                                    child: Container(
                                      height: 4,
                                      width: 38,
                                      margin: const EdgeInsets.only(top: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: AnimatedContainer(
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        border: Border(top: BorderSide(color: Colors.black12, width: 1))
                                    ),
                                    height: selectedUsers.isEmpty ? 120 : 100,
                                    padding: const EdgeInsets.only(bottom: 10),
                                    duration: const Duration(milliseconds: 100),
                                    child: selectedUsers.isEmpty ?
                                    ListView.builder(
                                      padding: const EdgeInsets.only(left: 12, right: 12),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 5,
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

                                              //Not working on some version of Android 14 (Moto g14, e13)
                                              /*if (await canLaunchUrl(smsUri)) {
                                                await launchUrl(smsUri);
                                              } else {
                                                print("Could not launch SMS");
                                              }*/

                                              try {
                                                await launchUrl(smsUri);
                                              } catch (e) {
                                                if(!mounted) return;
                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong")));
                                                print("Error launching SMS: $e");
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
                                    ) :
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 56,
                                          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                          padding: const EdgeInsets.symmetric(horizontal: 5),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(28),
                                            color: Colors.blue
                                          ),
                                          child: const Center(
                                            child: Text(
                                               "Send",
                                              style: TextStyle(
                                                color: Colors.white,
                                                  fontSize: 18,
                                                  letterSpacing: 1,
                                                  fontWeight: FontWeight.w600),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  )
                                ),
                                const SizedBox(height: 30),
                              ],
                            );
                          },
                        );
                      }
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
