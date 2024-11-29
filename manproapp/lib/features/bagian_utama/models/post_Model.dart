// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
    int? id;
    int? userId;
    String? content;
    DateTime? createdAt;
    DateTime? updatedAt;
    bool? liked;
    User? user;

    PostModel({
        this.id,
        this.userId,
        this.content,
        this.createdAt,
        this.updatedAt,
        this.liked,
        this.user,
    });

    factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["id"],
        userId: json["user_id"],
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        liked: json["liked"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "content": content,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "liked": liked,
        "user": user!.toJson(),
    };
}

class User {
    int? id;
    String? namaLengkap;
    String? username;
    String? email;
    dynamic? emailVerifiedAt;
    String? kotaAsal;
    String? noTelpon;
    dynamic? profilePhoto;
    DateTime? createdAt;
    DateTime? updatedAt;

    User({
        this.id,
        this.namaLengkap,
        this.username,
        this.email,
        this.emailVerifiedAt,
        this.kotaAsal,
        this.noTelpon,
        this.profilePhoto,
        this.createdAt,
        this.updatedAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        namaLengkap: json["nama_lengkap"],
        username: json["username"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        kotaAsal: json["kota_asal"],
        noTelpon: json["no_telpon"],
        profilePhoto: json["profile_photo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_lengkap": namaLengkap,
        "username": username,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "kota_asal": kotaAsal,
        "no_telpon": noTelpon,
        "profile_photo": profilePhoto,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
    };
}
