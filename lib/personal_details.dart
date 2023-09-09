import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:personal_details/ui/appstyle.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'ui/constants.dart';
import 'utils/sizeconfig.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: kBlackColor,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(16),
              ),
              CustomPaddedWidget(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Personal Details',
                      style: appstyle(
                        getProportionateScreenWidth(16),
                        kWhiteColor,
                        FontWeight.w500,
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/svg/identity_card.svg',
                      color: kWhiteColor,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(36),
              ),
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/png/my_profile_image.JPG',
                    width: getProportionateScreenWidth(150),
                    height: getProportionateScreenWidth(150),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Text(
                'Ezinne Nnabugwu',
                style: appstyle(getProportionateScreenWidth(22), kWhiteColor,
                    FontWeight.w700),
              ),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              Expanded(
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.only(
                          topLeft:
                              Radius.circular(getProportionateScreenWidth(20)),
                          topRight:
                              Radius.circular(getProportionateScreenWidth(20)),
                        ),
                      ),
                      child: CustomPaddedWidget(
                        child: Center(
                            child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(
                              getProportionateScreenWidth(20),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(16),
                              vertical: getProportionateScreenHeight(10),
                            ),
                            child: GestureDetector(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getProportionateScreenWidth(8)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/github.svg',
                                          height:
                                              getProportionateScreenHeight(30),
                                        ),
                                        SizedBox(
                                          width:
                                              getProportionateScreenWidth(18),
                                        ),
                                        Text(
                                          'Open GitHub',
                                          style: appstyle(
                                            getProportionateScreenWidth(16),
                                            kBlackColor,
                                            FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_right,
                                      size: getProportionateScreenWidth(30),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const WebViewStack(),
                                  ),
                                );
                              },
                            ),
                          ),
                        )),
                      )))
            ],
          ),
        ));
  }
}

class WebViewStack extends StatefulWidget {
  const WebViewStack({super.key});

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var loadingPercentage = 0;
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ))
      ..loadRequest(
        Uri.parse('https://github.com/Zinniie'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlackColor,
        title: const Text('GitHub Profile'),
        actions: [
          Navigation(controller: controller),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: controller,
          ),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
            ),
        ],
      ),
    );
  }
}

class Navigation extends StatelessWidget {
  const Navigation({required this.controller, super.key});

  final WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () async {
            final messenger = ScaffoldMessenger.of(context);
            if (await controller.canGoBack()) {
              await controller.goBack();
            } else {
              messenger.showSnackBar(
                const SnackBar(content: Text('No back history item')),
              );
              return;
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () async {
            final messenger = ScaffoldMessenger.of(context);
            if (await controller.canGoForward()) {
              await controller.goForward();
            } else {
              messenger.showSnackBar(
                const SnackBar(content: Text('No forward history item')),
              );
              return;
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.replay),
          onPressed: () {
            controller.reload();
          },
        ),
      ],
    );
  }
}
