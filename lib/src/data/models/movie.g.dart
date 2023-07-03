// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieAdapter extends TypeAdapter<MovieDTO> {
  @override
  final int typeId = 1;

  @override
  MovieDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieDTO(
      title: fields[0] as String,
      imgUrl: fields[1] as String,
      url: fields[2] as String,
      rating: fields[3] as String,
      links: (fields[4] as List?)?.cast<LinkDTO>(),
      descriptions: (fields[5] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, MovieDTO obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.imgUrl)
      ..writeByte(2)
      ..write(obj.url)
      ..writeByte(3)
      ..write(obj.rating)
      ..writeByte(4)
      ..write(obj.links)
      ..writeByte(5)
      ..write(obj.descriptions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
