import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class InfoModel {
  final Info info;
  InfoModel({
    required this.info,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'info': info.toMap(),
    };
  }

  factory InfoModel.fromMap(Map<String, dynamic> map) {
    return InfoModel(
      info: Info.fromMap(map['info'] as Map<String,dynamic>),
    );
  }

  factory InfoModel.fromJson(String source) => InfoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Info {
  final String seed;
  final int results;
  final int page;
  final String version;
  Info({
    required this.seed,
    required this.results,
    required this.page,
    required this.version,
  });
 

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'seed': seed,
      'results': results,
      'page': page,
      'version': version,
    };
  }

  factory Info.fromMap(Map<String, dynamic> map) {
    return Info(
      seed: (map['seed'] ?? '') as String,
      results: (map['results'] ?? 0) as int,
      page: (map['page'] ?? 0) as int,
      version: (map['version'] ?? '') as String,
    );
  }

  factory Info.fromJson(String source) => Info.fromMap(json.decode(source) as Map<String, dynamic>);
}
