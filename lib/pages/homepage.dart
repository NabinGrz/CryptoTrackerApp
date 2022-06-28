import 'package:cryptotrackerapp/model/pricechartmodel.dart';
import 'package:cryptotrackerapp/pages/favourites.dart';
import 'package:cryptotrackerapp/pages/login.dart';
import 'package:cryptotrackerapp/pages/market-page.dart';
import 'package:cryptotrackerapp/provider/market-provider.dart';
import 'package:cryptotrackerapp/provider/theme-provider.dart';
import 'package:cryptotrackerapp/utils/utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;
  PriceChartModel? priceData;
  late MarketProvider marketProv;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    marketProv = Provider.of<MarketProvider>(context, listen: false);
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
    MarketProvider marketProv =
        Provider.of<MarketProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           logOut();
      //         },
      //         icon: const Icon(Iconsax.logout))
      //   ],
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: getDeviceHeight(context) * 0.08,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Welcome",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Crypto Tracker",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                  ],
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
                    inactiveThumbColor: const Color.fromARGB(255, 247, 65, 14),
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
            width: getDeviceWidth(context) * 0.99,
            decoration: BoxDecoration(
                color: (themeProv.themeMode == ThemeMode.light)
                    ? const Color.fromARGB(255, 219, 219, 219)
                    : const Color.fromARGB(255, 131, 129, 129),
                borderRadius: BorderRadius.circular(10.0)),
            child: TabBar(
                controller: tabController,
                indicator: BoxDecoration(
                    color: const Color.fromARGB(255, 45, 45, 237),
                    borderRadius: BorderRadius.circular(10.0)),
                unselectedLabelColor: Colors.black,
                tabs: [
                  const Text(
                    "Market",
                    style: TextStyle(
                      fontSize: 22,
                    ),
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
    );
  }
}
