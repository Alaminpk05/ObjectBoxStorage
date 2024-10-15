import 'package:objectbox/objectbox.dart';

@Entity()
class UserModel {
  @Id()
  int id = 0;

  String? name;
  String? email;
  String? number;
  String? image;

  bool isfavourite=false;
  UserModel({
    
    required this.name,
    required this.email,
    required this.number,
    required this.image,
    this.isfavourite=false,
  });
}
