class Course {
  int _id;
  String _name, _content;
  int _hours;

  //constructor
  Course(dynamic obj) {
    _id = obj['id'];
    _name = obj['name'];
    _content = obj['content'];
    _hours = obj['hours'];
  }

  //named constructor
  Course.fromMap(Map<String, dynamic> data) {
    _id = data['id'];
    _name = data['name'];
    _content = data['content'];
    _hours = data['hours'];
  }

  //map data from obj to map
  Map<String, dynamic> toMap() =>
      {'id': _id, 'name': _name, 'content': _content, 'hours': _hours};

  //incapsulation getters
  int get id => _id;
  String get name => _name;
  String get content => _content;
  int get hours => _hours;
}
