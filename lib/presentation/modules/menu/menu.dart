import 'package:cali_turismo/presentation/shared/widgets/language-selector.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../generated/l10n.dart';

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
                  accountEmail: Text(S.current.tourist),
                  currentAccountPicture: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: Image(
                        image: AssetImage("assets/images/ois_logo.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFF1f4758),
                  ),
                ),
                _createDrawerItem(
                  icon: Icons.search,
                  text: S.current.explore,
                  onTap: () => widget.onItemSelected(0),
                  selected: widget.currentIndex == 0,
                ),
                _createDrawerItem(
                  icon: Icons.map,
                  text: S.current.recommendations,
                  onTap: () => widget.onItemSelected(1),
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
                            height: MediaQuery.of(context).size.height * 0.3,
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
                          ),
                        ),
                      ),
                    );
                  },
                  selected: widget.currentIndex == 2,
                ),
                _createDrawerItem(
                  icon: Icons.phone,
                  text: S.current.emergency,
                  onTap: () => widget.onItemSelected(3),
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
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.globe,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    _launchURL(Uri.parse('https://secretosturisticos.co'), false);
                  },
                ),
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.facebook,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    _launchURL(
                        Uri.parse(
                            'https://www.facebook.com/share/emvgHeys1fNWNRQW/?mibextid=LQQJ4d'),
                        false);
                  },
                ),
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.instagram,
                    color: Colors.orange,
                  ),
                  onPressed: () {
                    _launchURL(
                        Uri.parse('https://www.instagram.com/ois.stc/'), false);
                  },
                ),
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.youtube,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    _launchURL(
                        Uri.parse(
                            'https://youtube.com/@oissecretosturisticos?feature=shared'),
                        false);
                  },
                ),
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.x,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    _launchURL(
                        Uri.parse(
                            'https://x.com/oisciudad?s=21'),
                        false);
                  },
                ),
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.tiktok,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    _launchURL(
                        Uri.parse(
                            'https://www.tiktok.com/@oisapp?_t=8s1WvSPo09O&_r=1'),
                        false);
                  },
                ),
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
        color: selected ? Color(0xFF22014D) : null,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          color: selected ? Color(0xFF22014D) : null,
        ),
      ),
      onTap: onTap,
    );
  }
}
