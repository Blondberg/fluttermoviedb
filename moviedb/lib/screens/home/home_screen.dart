import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviedb/components/my_navigation_bar.dart';
import 'package:moviedb/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  PageController controller = PageController();

  TextEditingController textController = TextEditingController();

  List<List<dynamic>> _data = [];

  List<List<dynamic>> items = [];

  bool filterFormat = true;
  bool filterYear = true;
  bool filterTitle = true;

  String _query = "";

  @override
  Widget build(BuildContext context) {
    void loadCSV() async {
      final rawData = await rootBundle.loadString("assets/csv/movies.csv");

      List<List<dynamic>> listData =
          const CsvToListConverter().convert(rawData);
      setState(() {
        _data = listData;
      });

      items.addAll(_data);
    }

    void filterSearchData(String query) {
      _query = query;
      List<List<dynamic>> dummySearchList = [];
      dummySearchList.addAll(_data);

      if (query.isNotEmpty) {
        List<List<dynamic>> dummyListData = [];
        for (var item in dummySearchList) {
          if (filterTitle &&
              item.toString().toLowerCase().contains(query.toLowerCase())) {
            dummyListData.add(item);
          }
        }

        setState(() {
          items.clear();
          items.addAll(dummyListData);
        });
        return;
      } else {
        setState(() {
          items.clear();
          items.addAll(_data);
        });
      }
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kDefaultBackground,
        title: Text(
          "Movie list",
          style: GoogleFonts.roboto(),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: kDefaultBackground,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: CheckboxListTile(
              title: Text("Title"),
              value: filterTitle,
              onChanged: (value) => setState(() {
                filterTitle = value!;
                filterSearchData(_query);
              }),
            ),
          ),
          Container(
            height: 50,
            child: TextField(
              onChanged: (value) {
                filterSearchData(value);
              },
              controller: textController,
              decoration: const InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          Expanded(
            child: PageView(
              controller: controller,
              scrollDirection: Axis.horizontal,
              children: [
                Center(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Text(
                            items[index][0].toString(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Center(
                    child: Text(
                  "Profile",
                  style: TextStyle(color: Colors.white),
                )),
              ],
            ),
          ),
          MyNavigationBar(
            size: MediaQuery.of(context).size,
            selectedIndex: _currentIndex,
            onItemSelected: (index) => setState(() {
              controller.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
              );
              loadCSV();
              _currentIndex = index;
            }),
            iconHeight: 30,
          ),
          MyNavigationBar(
            size: MediaQuery.of(context).size,
            selectedIndex: _currentIndex,
            onItemSelected: (index) => setState(() {
              controller.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
              );
              loadCSV();
              _currentIndex = index;
            }),
            iconHeight: 30,
          ),
        ],
      ),
    );
  }
}
