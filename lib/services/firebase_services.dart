
  //upload image

  Future<String> uploadVehicleInfo(
      Map<String, dynamic> data, File localFile, BuildContext context) async {
    if (localFile != null) {
      print('uploading img file');

      var fileExtension = path.extension(localFile.path);
      print(fileExtension);

      var uuid = Uuid().v4();

      final Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('images/$uuid$fileExtension');

      UploadTask task = firebaseStorageRef.putFile(localFile);

      TaskSnapshot taskSnapshot = await task;

      String url = await taskSnapshot.ref.getDownloadURL();
      print('dw url $url');
      if (url != null) {
        print(url);
        try {
          data['vehicleImg'] = url;
          print(data['vehicleImg']);
        } catch (e) {
          print(e);
        }
      }
    }
