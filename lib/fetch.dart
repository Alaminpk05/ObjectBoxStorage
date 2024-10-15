import 'package:flutter/material.dart';
import 'package:objectboxstorage/data/model/model.dart';
import 'package:objectboxstorage/data/repo/objecbox_services.dart';

class FetchData extends StatefulWidget {
  const FetchData({super.key});

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  late Future<List<UserModel>> dataList;
  @override
  void initState() {
    super.initState();
    dataList = ObjectBoxServices().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Fetch'),
        ),
        body: FutureBuilder(
            future: dataList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child:
                        CircularProgressIndicator()); // Show loading while fetching data
              } else if (snapshot.hasError) {
                return Center(
                    child: Text('Error: ${snapshot.error}')); // Handle errors
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                    child: Text('No data found')); // Handle empty data
              } else {
                final users = snapshot.data!;
                return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return ListTile(
                        title: Text(user.name ?? "NO name"),
                        subtitle: Text("${user.id}"),
                        trailing: GestureDetector(
                            onTap: () {
                              setState(() {
                                ObjectBoxServices().deleteData(user.id);
                                
                              });
                            },
                            child: const Icon(Icons.delete)),
                      );
                    });
              }
            }));
  }
}
