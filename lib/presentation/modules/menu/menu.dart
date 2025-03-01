import 'package:flutter/material.dart';
import 'package:turismo_cartagena/core/theme/colors.dart';
import 'package:turismo_cartagena/core/theme/sizes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../generated/l10n.dart';
import '../emergency/emergency.dart';
import '../layuot.dart';
import '../profile/profile.dart';
import '../profile/widgets/language-selector.dart';

class MenuBarApp extends StatefulWidget {
  final int? currentIndex;
  final Function(int) onItemSelected;

  const MenuBarApp({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  State<MenuBarApp> createState() => _MenuBarAppState();
}

class _MenuBarAppState extends State<MenuBarApp> {
  @override
  Widget build(BuildContext context) {
    void _launchURL(Uri uri, bool inApp) async {
      try {
        if (inApp) {
          await launchUrl(uri, mode: LaunchMode.inAppWebView);
        } else {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      } catch (e) {
        print(e.toString());
      }
    }

    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(""),
                  accountEmail: Text(
                      "Bienvenido",
                      style: TextStyle(
                        fontSize: AppSizes.textLarge,
                        fontWeight: FontWeight.w700
                      ),
                  ),
                  currentAccountPicture: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: const ClipOval(
                      child: Image(
                        image: AssetImage("assets/images/icon-gooway.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  decoration: const  BoxDecoration(
                    color: AppColors.primary,
                  ),
                ),
                _createDrawerItem(
                  icon: Icons.home_outlined,
                  text: S.current.Home,
                  onTap: () {
                    widget.onItemSelected(0);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Layout(currentItemPages: 0)), (route) => false
                    );
                  },
                  selected: widget.currentIndex == 0,
                ),
                _createDrawerItem(
                  icon: Icons.person_outlined,
                  text: S.current.Profile,
                  onTap: () {
                    widget.onItemSelected(1);
                    Navigator.push(context,MaterialPageRoute(builder: (context)  => ProfileView()));

                  },
                  selected: widget.currentIndex == 1,
                ),

                _createDrawerItem(
                  icon: Icons.translate_rounded,
                  text: S.current.languages,
                  onTap: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => Center(
                            child: Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height:
                                  MediaQuery.of(context).size.height * 0.3 + 20,
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            S.current.select_languages,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 24,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey[200],
                                              ),
                                              child: const Icon(
                                                Icons.clear,
                                                color: Color(0xFFFF6969),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      LanguageSelector(),
                                    ],
                                  ),
                                )
                            )
                        )
                    );
                  },
                  selected: widget.currentIndex == 2,
                ),
                _createDrawerItem(
                  icon: Icons.phone_outlined,
                  text: S.current.emergency,
                  onTap: () {

                    widget.onItemSelected(3);
                    Navigator.push(context,MaterialPageRoute(builder: (context)  => Emergency()));

                  },
                  selected: widget.currentIndex == 3,
                ),
                _createDrawerItem(
                  icon: Icons.info_outline,
                  text: S.current.about,
                  onTap: () => widget.onItemSelected(4),
                  selected: widget.currentIndex == 4,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    required bool selected,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color:  AppColors.primary
      ),
      title: Text(
        text,
        style: TextStyle(
          fontWeight:  FontWeight.bold,
          fontSize: AppSizes.textMedium,
          color: selected ? AppColors.primary : AppColors.primary80,
        ),
      ),
      onTap: onTap,
    );
  }
}
