import 'package:hive/hive.dart';
part 'link.g.dart';

@HiveType(typeId: 2)
class LinkModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String url;

  @HiveField(2)
  String quality;

  @HiveField(3)
  String fileSize;

  LinkModel({
    required this.name,
    required this.url,
    required this.quality,
    required this.fileSize,
  });
}
