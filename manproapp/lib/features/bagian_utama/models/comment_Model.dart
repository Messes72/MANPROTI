// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

CommentModel commentModelFromJson(String str) => CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
    int? id;
    int? userId;
    int? feedId;
    String? body;
    DateTime? createdAt;
    DateTime? updatedAt;
    Feed? feed;
    User? user;

  var content;

    CommentModel({
        this.id,
        this.userId,
        this.feedId,
        this.body,
        this.createdAt,
        this.updatedAt,
        this.feed,
        this.user,
    });

    factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json["id"],
        userId: json["user_id"],
        feedId: json["feed_id"],
        body: json["body"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        feed: Feed.fromJson(json["feed"]),
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "feed_id": feedId,
        "body": body,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "feed": feed!.toJson(),
        "user": user!.toJson(),
    };
}

class Feed {
    int? id;
    int? userId;
    String? content;
    DateTime? createdAt;
    DateTime? updatedAt;
    bool? liked;

    Feed({
        this.id,
        this.userId,
        this.content,
        this.createdAt,
        this.updatedAt,
        this.liked,
    });

    factory Feed.fromJson(Map<String, dynamic> json) => Feed(
        id: json["id"],
        userId: json["user_id"],
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        liked: json["liked"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "content": content,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "liked": liked,
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
