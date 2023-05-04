 class AutoGenerate {
  AutoGenerate({
    required this.status,
    required this.message,
    required this.posts,
  });
  late final String status;
  late final String message;
  late final Posts posts;
  
  AutoGenerate.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    posts = Posts.fromJson(json['posts']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['posts'] = posts.toJson();
    return _data;
  }
}

class Posts {
  Posts({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
     this.prevPageUrl,
    required this.to,
  });
  late final int currentPage;
  late final List<Data> data;
  late final String firstPageUrl;
  late final int from;
  late final String nextPageUrl;
  late final String path;
  late final int perPage;
  late final Null prevPageUrl;
  late final int to;
  
  Posts.fromJson(Map<String, dynamic> json){
    currentPage = json['current_page'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = null;
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['current_page'] = currentPage;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['first_page_url'] = firstPageUrl;
    _data['from'] = from;
    _data['next_page_url'] = nextPageUrl;
    _data['path'] = path;
    _data['per_page'] = perPage;
    _data['prev_page_url'] = prevPageUrl;
    _data['to'] = to;
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.content,
    required this.type,
     this.url,
    required this.userId,
     this.sectionId,
    required this.collogeId,
    required this.createdAt,
    required this.updatedAt,
    required this.commentCount,
    required this.likeCount,
    required this.colloge,
     this.section,
    required this.user,
  });
  late final int id;
  late final String content;
  late final int type;
  late final String? url;
  late final int userId;
  late final Null sectionId;
  late final int collogeId;
  late final String createdAt;
  late final String updatedAt;
  late final int commentCount;
  late final int likeCount;
  late final Colloge colloge;
  late final Null section;
  late final User user;
  
  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    content = json['content'];
    type = json['type'];
    url = null;
    userId = json['user_id'];
    sectionId = null;
    collogeId = json['colloge_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    commentCount = json['comment_count'];
    likeCount = json['like_count'];
    colloge = Colloge.fromJson(json['colloge']);
    section = null;
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['content'] = content;
    _data['type'] = type;
    _data['url'] = url;
    _data['user_id'] = userId;
    _data['section_id'] = sectionId;
    _data['colloge_id'] = collogeId;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['comment_count'] = commentCount;
    _data['like_count'] = likeCount;
    _data['colloge'] = colloge.toJson();
    _data['section'] = section;
    _data['user'] = user.toJson();
    return _data;
  }
}

class Colloge {
  Colloge({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;
  
  Colloge.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.name,
    required this.img,
  });
  late final int id;
  late final String name;
  late final String img;
  
  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['img'] = img;
    return _data;
  }
}