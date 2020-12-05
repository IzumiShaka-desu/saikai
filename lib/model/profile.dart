
import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
    Profile({
        this.idUser,
        this.nama,
        this.phone,
        this.pekerjaan,
    });

    String idUser;
    String nama;
    String phone;
    String pekerjaan;

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        idUser: json["id_user"],
        nama: json["nama"],
        phone: json["phone"],
        pekerjaan: json["pekerjaan"],
    );

    Map<String, String> toJson() => {
        "id_user": idUser,
        "nama": nama,
        "phone": phone,
        "pekerjaan": pekerjaan,
    };
}
