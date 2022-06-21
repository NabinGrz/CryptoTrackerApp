import 'package:cryptotrackerapp/pages/favourites.dart';
import 'package:cryptotrackerapp/pages/market-page.dart';
import 'package:cryptotrackerapp/provider/market-provider.dart';
import 'package:cryptotrackerapp/provider/theme-provider.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    print("BUILD WIDEGTS");
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
              child: GestureDetector(
                onTap: () {},
                child: const Text(
                  "Welcome",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Text(
                    "Crypto Tracker",
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
                        print("THEME MODE: $themeMode");
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
            TabBar(controller: tabController, tabs: [
              Text(
                "Market",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                "Favourites",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ]),
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
