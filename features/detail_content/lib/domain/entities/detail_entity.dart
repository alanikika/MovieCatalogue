class DetailEntity {
  DetailEntity({
    this.id,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  DetailEntity.fromJson(dynamic json) {
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
    this.content,
    this.createdAt,
    this.id,
    this.updatedAt,
    this.url,
  });

  Results.fromJson(dynamic json) {
    author = json['author'];

    content = json['content'];
    createdAt = json['created_at'];
    id = json['id'];
    updatedAt = json['updated_at'];
    url = json['url'];
  }
  String? author;
  String? content;
  String? createdAt;
  String? id;
  String? updatedAt;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['author'] = author;
    map['content'] = content;
    map['created_at'] = createdAt;
    map['id'] = id;
    map['updated_at'] = updatedAt;
    map['url'] = url;
    return map;
  }
}

