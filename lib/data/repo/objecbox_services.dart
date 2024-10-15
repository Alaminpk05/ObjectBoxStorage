import 'package:objectboxstorage/main.dart';
import 'package:objectboxstorage/data/model/model.dart';




class ObjectBoxServices {
  final userbox = objectbox.store.box<UserModel>();

  Future<void> insertData(UserModel user) async {
    await userbox.putAsync(user);
    
  }

  Future<List<UserModel>> fetchData() async {
    List<UserModel> userList = await userbox.getAllAsync();

    return userList;
  }

  Future<void> deleteData(int id) async {
   await  userbox.removeAsync(id);
  }
  Future<void> updateData(UserModel user) async {
    await userbox.putAsync(user); // Update user data in ObjectBox
    
  }
}
