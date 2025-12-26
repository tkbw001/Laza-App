class UserModel {
  final String uId;
  final String username;
  final String email;
  final String? image;

  // Constructor
  UserModel({
    required this.uId,
    required this.username,
    required this.email,
    this.image,
  });

  // دالة لإنشاء يوزر مؤقت (Guest) لو احتجناها
  factory UserModel.guest() {
    return UserModel(
      uId: 'guest',
      username: 'Guest User',
      email: 'guest@laza.com',
      image: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100',
    );
  }

  // دالة لتحويل البيانات لـ Map (هنحتاجها قدام في Firestore)
  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'username': username,
      'email': email,
      'image': image,
    };
  }

  // دالة لاستقبال البيانات من Map (هنحتاجها قدام في Firestore)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uId: map['uId'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      image: map['image'],
    );
  }
}