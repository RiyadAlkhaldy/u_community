enum PostEnum {
  text('text'),
  image('image'),
  // audio('audio'),
  video('video');
  // gif('gif');

  const PostEnum(this.type);
  final String type;
}

// Using an extension
// Enhanced enums

extension ConvertMessage on String {
  PostEnum toEnum() {
    switch (this) {
      // case 'audio':
      //   return MessageEnum.audio;
      // case 'image':
      //   return MessageEnum.image;
      case 'text':
        return PostEnum.text;
      // case 'gif':
      //   return MessageEnum.gif;
      case 'video':
        return PostEnum.video;
      default:
        return PostEnum.image;
    }
  }
}

// void main() {
//   print( ConvertMessage(PostEnum.video.type).toEnum());
//   print(  PostEnum.video.type );
// }
