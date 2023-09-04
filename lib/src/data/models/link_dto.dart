import 'package:cm_movie/src/domain/entities/link_entity.dart';
import 'package:hive/hive.dart';
part 'link.g.dart';

@HiveType(typeId: 2)
class LinkDTO extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String url;

  @HiveField(2)
  String quality;

  @HiveField(3)
  String fileSize;

  LinkDTO({
    required this.name,
    required this.url,
    required this.quality,
    required this.fileSize,
  });

  LinkEntity toEntity() =>
      LinkEntity(name: name, url: url, quality: quality, fileSize: fileSize);

  factory LinkDTO.fromEntity(LinkEntity linkEntity) {
    return LinkDTO(
        name: linkEntity.name,
        url: linkEntity.url,
        quality: linkEntity.quality,
        fileSize: linkEntity.fileSize);
  }
}
