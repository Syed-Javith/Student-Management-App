class Mark {
  String? code;
  String? subject;
  int? mark;

  Mark({
    this.code,
    this.subject,
    this.mark,
  });

  factory Mark.fromJson(Map<String, dynamic> json) {
    return Mark(
      code: json['code'],
      subject: json['subject'],
      mark: json['mark'],
    );
  }
}

class User {
  String? email;
  String? name;
  bool? isAdmin;
  String? gender;
  int? year;
  String? department;
  int? rollNumber;
  List<Mark>? marks;

  User({
    this.email,
    this.name,
    this.isAdmin,
    this.gender,
    this.year,
    this.department,
    this.rollNumber,
    this.marks,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        email: json['email'],
        name: json['name'],
        isAdmin: json['isAdmin'],
        gender: json['gender'],
        year: json['year'],
        department: json['department'],
        rollNumber: json['rollNumber'],
        marks: (json['marks'] as List<dynamic>?)
            ?.map((markJson) => Mark.fromJson(markJson))
            .toList());
  }
}
