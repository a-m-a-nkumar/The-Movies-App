class user_model{
  String? uid;
  String? email;
  String? firstname;

  user_model({this.uid,this.firstname,this.email});

  factory user_model.fromMap(map)
  {
    return user_model(

      uid: map['uid'],
      email: map['email'],
      firstname: map['firstname'],

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstname': firstname,

    };
  }



}