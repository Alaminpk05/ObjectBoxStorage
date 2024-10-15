import 'package:objectboxstorage/data/model.dart';

abstract class ObjboxAbstractRepo {
  Future<void>insertData(UserModel user);
  Future<List<UserModel>>fetchData();
}
