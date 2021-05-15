import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tomasfamilyapp/models/models/Image.dart';
import 'package:path/path.dart' as p;

class GalleryService {
  String familyId;

  GalleryService({this.familyId});

  Future<List<ImageModel>> loadImages() async {
    List<ImageModel> _imgs = [];
    ListResult res = await FirebaseStorage.instance.ref(familyId).listAll();
    for (var i = 0; i < res.items.length; i++) {
      final e = res.items[i];
      final dlUrl = await e.getDownloadURL();
      final img = ImageModel(e.fullPath, dlUrl);
      _imgs.add(img);
    }
    return _imgs;
  }

  Future<List<void>> loadThumbs(List<ImageModel> images) async {
    List<void> thumbs = [];
    for (var i = 0; i < images.length; i++) {
      final res = await images[i].downloadThumb();
      thumbs.add(res);
    }
    return thumbs;
  }

  Future<ImageModel> uploadImage(path, callback) async {
    Reference ref = FirebaseStorage.instance.ref(familyId);
    File file = File(path);
    String extension = p.extension(path);
    DateTime date = new DateTime.now();
    String fileName = '${date.year.toString()}${date.month.toString()}${date.day.toString()}${date.hour.toString()}${date.minute.toString()}${date.second.toString()}${extension}';
    try {
      final task = ref.child(fileName).putFile(file);
      task.whenComplete(callback);
    } on FirebaseException catch(e) {
      print(e.message);
    }
  }
}