class Payload {
  //variáveis que se encontram no token
  int? id;
  String? email;
  int? iat;
  int? exp;
  //referencia as variáveis
  Payload({this.id, this.email, this.iat, this.exp});
  //associar variáveis com o json
  Payload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    iat = json['iat'];
    exp = json['exp'];
  }
  //dividir as variáveis num mapa
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['email'] = email;
    data['iat'] = iat;
    data['exp'] = exp;
    return data;
  }
}