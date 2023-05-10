// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../models/post_model.dart';

class ResponsePostsPagentaion {
  final String status;
  final String message;
  final Data data;
  ResponsePostsPagentaion({
    required this.status,
    required this.message,
    required this.data,
  });
  

  ResponsePostsPagentaion copyWith({
    String? status,
    String? message,
    Data? data,
  }) {
    return ResponsePostsPagentaion(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'message': message,
      'posts': data.toMap(),
    };
  }

  factory ResponsePostsPagentaion.fromMap(Map<String, dynamic> map) {
    return ResponsePostsPagentaion(
      status: map['status'] as String,
      message: map['message'] as String,
      data: Data.fromMap(map['posts'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponsePostsPagentaion.fromJson(String source) => ResponsePostsPagentaion.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ResponsePostsPagentaion(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(covariant ResponsePostsPagentaion other) {
    if (identical(this, other)) return true;
  
    return 
      other.status == status &&
      other.message == message &&
      other.data == data;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}

class Data {
  //  "first_page_url": "http://localhost:8000/api/posts/get-all-posts-page?page=1",
  //       "from": 1,
  //       "last_page": 2,
  //       "last_page_url": "http://localhost:8000/api/posts/get-all-posts-page?page=2",
  // "next_page_url": null,
  // "path": "http://localhost:8000/api/posts/get-all-posts-page",
  // "per_page": 2,
  // "prev_page_url": "http://localhost:8000/api/posts/get-all-posts-page?page=1",
  // "to": 4,
  // "total": 4

  final int? currentPage;
  final List<Posts> posts;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Links>? links;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final String? prevPageUrl;
  final int? to;
  final int? total;
  Data({
    this.currentPage,
    required this.posts,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  Data copyWith({
    int? currentPage,
    List<Posts>? posts,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<Links>? links,
    String? nextPageUrl,
    String? path,
    int? perPage,
    String? prevPageUrl,
    int? to,
    int? total,
  }) {
    return Data(
      currentPage: currentPage ?? this.currentPage,
      posts: posts ?? this.posts,
      firstPageUrl: firstPageUrl ?? this.firstPageUrl,
      from: from ?? this.from,
      lastPage: lastPage ?? this.lastPage,
      lastPageUrl: lastPageUrl ?? this.lastPageUrl,
      links: links ?? this.links,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      path: path ?? this.path,
      perPage: perPage ?? this.perPage,
      prevPageUrl: prevPageUrl ?? this.prevPageUrl,
      to: to ?? this.to,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'current_page': currentPage,
      'data': posts.map((x) => x.toMap()).toList(),
      'first_page_url': firstPageUrl,
      'from': from,
      'last_page': lastPage,
      'last_page_url': lastPageUrl,
      'links': links!.map((x) => x.toMap()).toList(),
      'next_page_url': nextPageUrl,
      'path': path,
      'per_page': perPage,
      'prev_page_url': prevPageUrl,
      'to': to,
      'total': total,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      currentPage:
          map['current_page'] != null ? map['current_page'] as int : null,
      posts: List<Posts>.from(
        (map['data']).map<Posts>(
          (x) => Posts.fromMap(x as Map<String, dynamic>),
        ),
      ),
      firstPageUrl: map['first_page_url'] != null
          ? map['first_page_url'] as String
          : null,
      from: map['from'] != null ? map['from'] as int : null,
      lastPage: map['last_page'] != null ? map['last_page'] as int : null,
      lastPageUrl:
          map['last_page_url'] != null ? map['last_page_url'] as String : null,
      links: map['links'] != null
          ? List<Links>.from(
              (map['links']).map<Links?>(
                (x) => Links.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      nextPageUrl:
          map['next_page_url'] != null ? map['next_page_url'] as String : null,
      path: map['path'] != null ? map['path'] as String : null,
      perPage: map['per_page'] != null ? map['per_page'] as int : null,
      prevPageUrl:
          map['prev_page_url'] != null ? map['prev_page_url'] as String : null,
      to: map['to'] != null ? map['to'] as int : null,
      total: map['total'] != null ? map['total'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) =>
      Data.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Posts(currentPage: $currentPage, data: $posts, firstPageUrl: $firstPageUrl, from: $from, lastPage: $lastPage, lastPageUrl: $lastPageUrl, links: $links, nextPageUrl: $nextPageUrl, path: $path, perPage: $perPage, prevPageUrl: $prevPageUrl, to: $to, total: $total)';
  }

  @override
  bool operator ==(covariant Data other) {
    if (identical(this, other)) return true;

    return other.currentPage == currentPage &&
        listEquals(other.posts, posts) &&
        other.firstPageUrl == firstPageUrl &&
        other.from == from &&
        other.lastPage == lastPage &&
        other.lastPageUrl == lastPageUrl &&
        listEquals(other.links, links) &&
        other.nextPageUrl == nextPageUrl &&
        other.path == path &&
        other.perPage == perPage &&
        other.prevPageUrl == prevPageUrl &&
        other.to == to &&
        other.total == total;
  }

  @override
  int get hashCode {
    return currentPage.hashCode ^
        posts.hashCode ^
        firstPageUrl.hashCode ^
        from.hashCode ^
        lastPage.hashCode ^
        lastPageUrl.hashCode ^
        links.hashCode ^
        nextPageUrl.hashCode ^
        path.hashCode ^
        perPage.hashCode ^
        prevPageUrl.hashCode ^
        to.hashCode ^
        total.hashCode;
  }
}

class Links {
  final String? url;
  final String? label;
  final bool active;
  Links({
    this.url,
    this.label,
    required this.active,
  });

  Links copyWith({
    String? url,
    String? label,
    bool? active,
  }) {
    return Links(
      url: url ?? this.url,
      label: label ?? this.label,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
      'label': label,
      'active': active,
    };
  }

  factory Links.fromMap(Map<String, dynamic> map) {
    return Links(
      url: map['url'] != null ? map['url'] as String : null,
      label: map['label'] != null ? map['label'] as String : null,
      active: map['active'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Links.fromJson(String source) =>
      Links.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Links(url: $url, label: $label, active: $active)';

  @override
  bool operator ==(covariant Links other) {
    if (identical(this, other)) return true;

    return other.url == url && other.label == label && other.active == active;
  }

  @override
  int get hashCode => url.hashCode ^ label.hashCode ^ active.hashCode;
}
 

class Colloge {
  final int id;
  final String name;
  Colloge({
    required this.id,
    required this.name,
  });

  Colloge copyWith({
    int? id,
    String? name,
  }) {
    return Colloge(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Colloge.fromMap(Map<String, dynamic> map) {
    return Colloge(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Colloge.fromJson(String source) =>
      Colloge.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Colloge(id: $id, name: $name)';

  @override
  bool operator ==(covariant Colloge other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class Section {
  final int id;
  final String name;
  Section({
    required this.id,
    required this.name,
  });

  Section copyWith({
    int? id,
    String? name,
  }) {
    return Section(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Section.fromMap(Map<String, dynamic> map) {
    return Section(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Section.fromJson(String source) =>
      Section.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Section(id: $id, name: $name)';

  @override
  bool operator ==(covariant Section other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class User {
  final int id;
  final String name;
  String? img;
  User({
    required this.id,
    required this.name,
    this.img,
  });

  User copyWith({
    int? id,
    String? name,
    String? img,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      img: img ?? this.img,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'img': img,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      name: map['name'] as String,
      img: map['img'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(id: $id, name: $name, img: $img)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.img == img;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ img.hashCode;
}

// class Post {
//   String authorName;
//   String authorImageUrl;
//   String timeAgo;
//   String imageUrl;
//   String videoUrl;
//   int type;

//   Post({
//     required this.authorName,
//     required this.authorImageUrl,
//     required this.timeAgo,
//     required this.imageUrl,
//     required this.videoUrl,
//     required this.type,
//   });
// }

// final List<Post> postss = [
//   Post(
//     authorName: 'Sam Martin',
//     authorImageUrl: 'assets/images/user0.png',
//     timeAgo: '5 min',
//     imageUrl: 'assets/images/post0.jpg',
//     type: 1,
//     videoUrl:
//         'https://player.vimeo.com/external/201962441.hd.mp4?s=d5e09fbd67593c9796cfba4d273bfca4d8a828f9&profile_id=174&oauth2_token_id=57447761',
//   ),
//   Post(
//     authorName: 'Sam Martin',
//     authorImageUrl: 'assets/images/user0.png',
//     timeAgo: '10 min',
//     imageUrl: 'assets/images/post1.jpg',
//     type: 1,
//     videoUrl:
//         'https://player.vimeo.com/external/201962441.hd.mp4?s=d5e09fbd67593c9796cfba4d273bfca4d8a828f9&profile_id=174&oauth2_token_id=57447761',
//   ),
//   Post(
//     authorName: 'Sam Martin',
//     authorImageUrl: 'assets/images/user0.png',
//     timeAgo: '10 min',
//     imageUrl: 'assets/images/post1.jpg',
//     type: 0,
//     videoUrl:
//         'https://player.vimeo.com/external/201962441.hd.mp4?s=d5e09fbd67593c9796cfba4d273bfca4d8a828f9&profile_id=174&oauth2_token_id=57447761',
//   ),
//   Post(
//     authorName: 'Sam Martin',
//     authorImageUrl: 'assets/images/user0.png',
//     timeAgo: '10 min',
//     imageUrl: 'assets/images/post1.jpg',
//     type: 0,
//     videoUrl:
//         'https://player.vimeo.com/external/201962441.hd.mp4?s=d5e09fbd67593c9796cfba4d273bfca4d8a828f9&profile_id=174&oauth2_token_id=57447761',
//   ),
// ];

final List<String> stories = [
  'assets/images/user1.png',
  'assets/images/user1.png',
  'assets/images/user3.png',
  'assets/images/user4.png',
  'assets/images/user0.png',
  'assets/images/user1.png',
  'assets/images/user2.png',
  'assets/images/user3.png',
];
// final posts = FutureProvider<List<Post>>((ref) async {
//   return postss;
// });



/////
// class Requsetes {
// final url = "https://facebookgraphapiserg-osipchukv1.p.rapidapi.com/getProfile";
// final headers = {
//        "content-type": "application/x-www-form-urlencoded",
// 	"X-RapidAPI-Key": "8fe4651a6dmsh17e6a305bb289a1p1620d5jsnd9cc6d38692c",
// 	"X-RapidAPI-Host": "FacebookGraphAPIserg-osipchukV1.p.rapidapi.com"
//       };
//   getpost() async {
//    var resposne = await http.post(
//       Uri.parse(url),
//       headers: headers,
//     );
//   }
// }



// payload = "profile_id=%3CREQUIRED%3E&access_token=%3CREQUIRED%3E"
 

// response = requests.request("POST", url, data=payload, headers=headers)

