import 'package:flutter/material.dart';
import 'package:objectboxstorage/data/model/model.dart';
import 'package:objectboxstorage/data/repo/objecbox_services.dart';

class FavoriteList extends StatefulWidget {
  final ObjectBoxServices objectBoxServices;

  const FavoriteList({super.key, required this.objectBoxServices});

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Items'),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: widget.objectBoxServices.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No favorite items found'));
          } else {
            final users = snapshot.data!.where((user) => user.isfavourite).toList(); // Filter favorites
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  leading: Image.asset(user.image ?? 'assets/default_image.png'),
                  title: Text(user.name ?? "No Name"),
                  subtitle: Text(user.email ?? "No Email"),
                  trailing: GestureDetector(
                    onTap: () {

                      setState(() {
                         user.isfavourite = false; // Remove from favorites
                      widget.objectBoxServices.updateData(user); 
                      });
                     
                      //updated
                    },
                    child: const Icon(Icons.favorite, color: Colors.red), // Always red in the favorites list
                  ),
                );
              },


            );
          }
        },
      ),
    );
  }
}





/// added line 1 in pk
/// added line 2 in pk
/// added line 3 in pk
/// added line 4 in pk
