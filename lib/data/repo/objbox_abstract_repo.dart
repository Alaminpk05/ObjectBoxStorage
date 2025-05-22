import 'package:objectboxstorage/data/model/model.dart';

abstract class ObjboxAbstractRepo {
  Future<void>insertData(UserModel user);
  Future<List<UserModel>>fetchData();
}
