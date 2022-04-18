class Client {

  late String email;
  late String password;

  Client.fromService(List<dynamic> data){
    this.email = data.first['email'];
    this.password = data.first['password'];
  }
}