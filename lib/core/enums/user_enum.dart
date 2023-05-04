// enum UserEnum {
//   id('id'),
//   name('name'),
//   email('email'),
//   token('token'),
//   type('type'),
//   collogeId('colloge_id'),
//   sectionId('section_id');

//   const UserEnum(this.type);
//   final String type;
// }
enum UserEnum {
  token('token'),
  name('name'),
  id('id'),
  collogeId('colloge_id'),
  sectionId('section_id'),
  typeUser('type'),
  img('img'),

  email('email');
  // gif('gif');

  const UserEnum(this.type);
  final String type;
}

extension ConvertMessage on String {
  UserEnum toEnum() {
    switch (this) {
      case 'name':
        return UserEnum.name;
      case 'token':
        return UserEnum.token;

      case 'id':
        return UserEnum.id;
      case 'colloge_id':
        return UserEnum.collogeId;
      case 'section_id':
        return UserEnum.sectionId;
      case 'type':
        return UserEnum.typeUser;
      case 'img':
        return UserEnum.img;
      default:
        return UserEnum.email;
    }
  }
}

// void main() {
//   print( ConvertMessage(PostEnum.video.type).toEnum());
//   print(  PostEnum.video.type );
// }
