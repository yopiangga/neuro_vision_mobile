part of '../screens.dart';

class DetailHistoryPromise extends StatelessWidget {
  DetailHistoryPromise({super.key, required this.promise});

  Promise promise;

  @override
  Widget build(BuildContext context) {
    double paddingTop = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: paddingTop + 10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              padding: EdgeInsets.only(left: 20),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            OutputStroke(promise: promise),
            Divider(),
            DownloadOutput(),
            Divider(),
            NotePromise(data: promise),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: LergeButton(content: "Back"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotePromise extends StatelessWidget {
  NotePromise({
    super.key,
    required this.data,
  });

  Promise data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Doctor"),
              Text(data.doctor.fullname),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Place"),
              Text(data.hospital.name),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Patient"),
              Text(data.patient.fullname),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Time"),
              Text(
                  "${DateFormat('MMMM dd, yyyy').format(DateTime.parse(data.time))} | ${DateFormat('hh:mm a').format(DateTime.parse(data.time))}"),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Note"),
              Text(
                data.note,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DownloadOutput extends StatelessWidget {
  const DownloadOutput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          InkWell(
            onTap: () {},
            child: Text(
              "Download",
              style: TextStyle(
                color: CustomColor.main,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(width: 5),
          Text(
            "image CT Scan result",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class OutputStroke extends StatefulWidget {
  OutputStroke({
    required this.promise,
    super.key,
  });

  Promise promise;

  @override
  State<OutputStroke> createState() => _OutputStrokeState();
}

class _OutputStrokeState extends State<OutputStroke> {
  FirebaseAuth auth = FirebaseAuth.instance;
  PromiseService promiseService = PromiseService();
  String stroke = "";
  String note = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stroke = widget.promise.diagnose['doctor'];
  }

  @override
  Widget build(BuildContext context) {
    print(widget.promise.diagnose);
    return FutureBuilder(
        future: _userRole(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Result CT Scan",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  widget.promise.diagnose['ai'],
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "AI Prediction",
                  style: TextStyle(
                    fontSize: 15,
                    color: CustomColor.grey,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.promise.diagnose['doctor'],
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Diagnosis by Doctor",
                          style: TextStyle(
                            fontSize: 15,
                            color: CustomColor.grey,
                          ),
                        ),
                      ],
                    ),
                    if (snapshot.data == 'doctor')
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Edit Diagnosis"),
                                  content: StatefulBuilder(
                                      builder: (context, setState) {
                                    return Container(
                                      height: 200,
                                      child: Column(
                                        children: [
                                          //buat dropdown
                                          DropdownButton(
                                            hint: Text("Diagnosis"),
                                            //ketika memilih isi maka input langsung berubah
                                            value: stroke == "" ? null : stroke,
                                            items: [
                                              DropdownMenuItem(
                                                child: Text("Normal"),
                                                value: "Normal",
                                              ),
                                              DropdownMenuItem(
                                                child: Text("Stroke Ischemic"),
                                                value: "Stroke Ischemic",
                                              ),
                                              DropdownMenuItem(
                                                child:
                                                    Text("Stroke Hemorrhagic"),
                                                value: "Stroke Hemorrhagic",
                                              ),
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                stroke = value.toString();
                                              });
                                            },
                                          ),
                                          SizedBox(height: 20),
                                          //buat textfield area
                                          TextField(
                                            maxLines: 4,
                                            decoration: InputDecoration(
                                              hintText: "Note",
                                              border: OutlineInputBorder(),
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                note = value;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        promiseService.updatePromise(
                                            stroke, note, widget.promise);
                                        // back dengan refresh halaman
                                        Navigator.pushReplacementNamed(
                                            context, '/main');
                                      },
                                      child: Text("Save"),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50 / 2),
                            border:
                                Border.all(color: CustomColor.main, width: 1),
                          ),
                          child: Center(
                            child: Text(
                              "Edit",
                              style: TextStyle(color: CustomColor.main),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        });
  }

  Future _userRole() async {
    var user = await auth.currentUser;
    var role = await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get();
    return role.data()!['role'];
  }
}
