class AppUser {
  final String nickname;

  const AppUser(this.nickname);

  @override
  String toString() {
    return '$AppUser(nickname: $nickname)';
  }

  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
    };
  }
}
