part of '../screens.dart';

class HistoryUserScreen extends StatefulWidget {
  const HistoryUserScreen({super.key});

  @override
  State<HistoryUserScreen> createState() => _HistoryUserScreenState();
}

class _HistoryUserScreenState extends State<HistoryUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("My Promise", style: darkTextFont),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      // body: EmptyHistory(),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: promise.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailHistoryPromise(
                    data: promise[index],
                  ),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey[200],
                  ),
                  Text(
                    promise[index].date + " | " + promise[index].time,
                    style: TextStyle(
                      color: CustomColor.main,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          promise[index].hospitals.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Icon(Icons.arrow_outward_rounded),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    promise[index].hospitals.address,
                    style: TextStyle(
                      color: CustomColor.grey,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(34, 108, 78, 255),
                      borderRadius: BorderRadius.circular(50 / 2),
                    ),
                    child: Text(
                      promise[index].status,
                      style: TextStyle(color: CustomColor.main),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class EmptyHistory extends StatelessWidget {
  const EmptyHistory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EmptySection(
            title: "No saved promise",
            content:
                "Make an appointment with the doctor at the hospital, and I'll keep it here",
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {},
            child: Container(
              width: 170,
              height: 50,
              decoration: BoxDecoration(
                color: CustomColor.main,
                borderRadius: BorderRadius.circular(50 / 2),
              ),
              child: Center(
                child: Text("Create New", style: whiteTextFont),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
