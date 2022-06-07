class DetailResponse {
  DetailResponse({
    this.id,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  DetailResponse.fromJson(dynamic json) {
    id = json['id'];
    page = json['page'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
  int? id;
  int? page;
  List<Results>? results;
  int? totalPages;
  int? totalResults;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['page'] = page;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    map['total_pages'] = totalPages;
    map['total_results'] = totalResults;
    return map;
  }
}

class Results {
  Results({
    this.author,
    this.authorDetails,
    this.content,
    this.createdAt,
    this.id,
    this.updatedAt,
    this.url,
  });

  Results.fromJson(dynamic json) {
    author = json['author'];
    authorDetails = json['author_details'] != null
        ? AuthorDetails.fromJson(json['author_details'])
        : null;
    content = json['content'];
    createdAt = json['created_at'];
    id = json['id'];
    updatedAt = json['updated_at'];
    url = json['url'];
  }
  String? author;
  AuthorDetails? authorDetails;
  String? content;
  String? createdAt;
  String? id;
  String? updatedAt;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['author'] = author;
    if (authorDetails != null) {
      map['author_details'] = authorDetails?.toJson();
    }
    map['content'] = content;
    map['created_at'] = createdAt;
    map['id'] = id;
    map['updated_at'] = updatedAt;
    map['url'] = url;
    return map;
  }
}

class AuthorDetails {
  AuthorDetails({
    this.name,
    this.username,
    this.avatarPath,
    this.rating,
  });

  AuthorDetails.fromJson(dynamic json) {
    name = json['name'];
    username = json['username'];
    avatarPath = json['avatar_path'];
    rating = json['rating'];
  }
  String? name;
  String? username;
  String? avatarPath;
  dynamic rating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['username'] = username;
    map['avatar_path'] = avatarPath;
    map['rating'] = rating;
    return map;
  }
}
