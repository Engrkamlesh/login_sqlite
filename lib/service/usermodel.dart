class UserModel{
final int? id;
final String email;
// final int mobile;
// final int age;
final String address;

UserModel({this.id, required this.email, required this.address});

factory UserModel.fromMap(Map<String, dynamic> res)=>UserModel(
  id: res['id'],
  email: res['email'],
   address: res['address']
   );

Map<String, dynamic> toMap(){
  return {
    'id' : id,
    'email':email,
    'address':address,
  };
}
}




