import 'package:flutter/material.dart';
import 'package:objectboxstorage/data/model/model.dart';
import 'package:objectboxstorage/data/repo/objecbox_services.dart';
import 'package:objectboxstorage/pages/favourite.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  late Future<List<UserModel>> dataList;
  List<UserModel> favouriteUsers = [];
  @override
  void initState() {
    super.initState();
    setState(() {
       dataList = ObjectBoxServices().fetchData();
          });
   
    
  }

  void refreshData() {
    setState(() {
      dataList = ObjectBoxServices()
          .fetchData(); 
    });
  }

  void toggleFavorite(UserModel user) {
    setState(() {
      user.isfavourite = !user.isfavourite;
    
      ObjectBoxServices().updateData(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Object box'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Name'),
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
              TextFormField(
                controller: numberController,
                decoration: const InputDecoration(hintText: 'Number'),
              ),
              ElevatedButton(
                  onPressed: () {
                    final user = UserModel(
                      name: nameController.text,
                      email: emailController.text,
                      number: numberController.text,
                      image: 'assets/aimage3.jpeg',
                    );
                    ObjectBoxServices().insertData(user);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('User data inserted successfully!')),
                    );
                    refreshData();
                  },
                  child: const Text("Insert")),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => FavoriteList(
                                  objectBoxServices: ObjectBoxServices(),
                                )));
                  },
                  child: const Text("Navigate")),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                  future: dataList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child:
                              CircularProgressIndicator()); // Show loading while fetching data
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text(
                              'Error: ${snapshot.error}')); // Handle errors
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('No data found')); // Handle empty data
                    } else {
                      final users = snapshot.data!;
                      return SizedBox(
                        height: 400,
                        width: 400,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              final user = users[index];
                              return ListTile(
                                leading: Image.asset(user.image ?? 'No image'),
                                title: Text(user.name ?? "NO name"),
                                subtitle: Text("${user.id}"),
                                trailing: GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        toggleFavorite(user);
                                      });
                                    },
                                    child: Icon(
                                      Icons.favorite,
                                      color: user.isfavourite
                                          ? Colors.red
                                          : Colors.black,
                                    )),
                              );
                            }),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
