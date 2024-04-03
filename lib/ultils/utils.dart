import 'package:mime/mime.dart';

class Utils {
  static bool isImageFile(String url) {
    String? mimeStr = lookupMimeType(url);
    final fileType = <String>[];
    fileType.addAll(mimeStr?.split('/') ?? []);
    if (fileType.isNotEmpty && fileType[0] == 'image') {
      return true;
    }
    return false;
  }
}
