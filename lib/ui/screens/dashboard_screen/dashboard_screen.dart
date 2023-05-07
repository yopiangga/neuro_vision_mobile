part of '../screens.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double paddingTop = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: paddingTop),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TopBarWidget(),
              Divider(),
              _buildButtonQuery(),

              //================================================================ Banner =================================================================
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return DetailScreen(data: hospitals[3]);
                      },
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 180,
                        color: Colors.grey[200],
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Siloam hospitals Bogor",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Raya Pajajaran Street, Number 27, Tegallega, Center Bogor, Bogor City, West Java 14140, Indonesia",
                        style: TextStyle(
                          color: CustomColor.grey,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "24 hours | 0251-8303911 (Emergency Call)",
                        style: TextStyle(
                          fontSize: 13,
                          color: CustomColor.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //================================================================ end of Banner =================================================================

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: hospitals.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
                    width: double.infinity,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailScreen(
                                data: hospitals[index],
                              );
                            },
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            color: Colors.grey[200],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  hospitals[index].name,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  // overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  hospitals[index].address,
                                  style: TextStyle(
                                    color: CustomColor.grey,
                                    fontSize: 13,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  hospitals[index].biaya,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: CustomColor.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonQuery() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
            child: ButtonQuery(
              index: 0,
              selectedIndex: _selectedIndex,
              title: "Nearest",
            ),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
            child: ButtonQuery(
              index: 1,
              selectedIndex: _selectedIndex,
              title: "Surabaya",
            ),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              setState(() {
                _selectedIndex = 2;
              });
            },
            child: ButtonQuery(
              index: 2,
              selectedIndex: _selectedIndex,
              title: "Sidoarjo",
            ),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              setState(() {
                _selectedIndex = 3;
              });
            },
            child: ButtonQuery(
              index: 3,
              selectedIndex: _selectedIndex,
              title: "Gresik",
            ),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              setState(() {
                _selectedIndex = 4;
              });
            },
            child: ButtonQuery(
              index: 4,
              selectedIndex: _selectedIndex,
              title: "Mojokerto",
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}

class ButtonQuery extends StatelessWidget {
  ButtonQuery({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.title,
  });

  int index;
  int selectedIndex;
  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      decoration: BoxDecoration(
        color: selectedIndex == index
            ? Color.fromARGB(34, 108, 78, 255)
            : Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: selectedIndex == index ? CustomColor.main : Colors.black,
          ),
        ),
      ),
    );
  }
}

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good morning",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text("Monday, April 24, 2023"),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.sunny,
                color: Colors.amber,
              ),
              SizedBox(height: 5),
              Text(
                "Surabaya",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
