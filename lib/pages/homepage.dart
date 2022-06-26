import 'package:cryptotrackerapp/apiservices/api.dart';
import 'package:cryptotrackerapp/pages/favourites.dart';
import 'package:cryptotrackerapp/pages/login.dart';
import 'package:cryptotrackerapp/pages/market-page.dart';
import 'package:cryptotrackerapp/provider/market-provider.dart';
import 'package:cryptotrackerapp/provider/theme-provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(context, CupertinoPageRoute(
      builder: (context) {
        return const MyLogin();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    print("BUILD WIDEGTS");
    ThemeProvider themeProv =
        Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                logOut();
              },
              icon: const Icon(Iconsax.logout))
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
              child: GestureDetector(
                onTap: () async {
                  await API.getTrendingCrypto();
                },
                child: const Text(
                  "Welcome",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Text(
                    "Cryptos",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Consumer<MarketProvider>(
                  builder: (context, marketProv, child) {
                    var themeMode =
                        Provider.of<ThemeProvider>(context, listen: false)
                            .themeMode;
                    return Switch(
                      onChanged: (val) {
                        marketProv.checkTheme(val);
                        Provider.of<ThemeProvider>(context, listen: false)
                            .changeTheme();
                      },
                      value: marketProv.isDark,
                      activeColor: const Color.fromARGB(255, 255, 255, 255),
                      activeTrackColor: const Color.fromARGB(255, 14, 142, 247),
                      inactiveThumbColor:
                          const Color.fromARGB(255, 247, 65, 14),
                      inactiveTrackColor: const Color.fromARGB(255, 67, 66, 66),
                    );
                  },
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 45,
              decoration: BoxDecoration(
                  color: (themeProv.themeMode == ThemeMode.light)
                      ? const Color.fromARGB(255, 219, 219, 219)
                      : const Color.fromARGB(255, 131, 129, 129),
                  borderRadius: BorderRadius.circular(25.0)),
              child: TabBar(
                  controller: tabController,
                  indicator: BoxDecoration(
                      color: const Color.fromARGB(255, 45, 45, 237),
                      borderRadius: BorderRadius.circular(25.0)),
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Text(
                      "Market",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      "Favourites",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ]),
            ),
            Expanded(
              child: TabBarView(
                  controller: tabController,
                  children: const [MarketPage(), FavouritesPage()]),
            ),
          ],
        ),
      ),
    );
  }
}
