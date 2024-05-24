import 'package:http/http.dart' as http;
import 'package:emschool_dashboard/core/utlis/api_constatns.dart';
import 'package:file_picker/file_picker.dart';

abstract class ApiServiceRepo {
  Future<dynamic> uploadImage();
}

class ApiApiService extends ApiServiceRepo {
  @override
  Future uploadImage() async {
    var picked = await FilePicker.platform.pickFiles(
      withReadStream:
          true, // this will return PlatformFile object with read stream
    );

    if (picked != null) {
   
        // print(picked.files.first.name);
        final request = http.MultipartRequest(
          "POST",
          Uri.parse(ApiConstants.uploadImagesPath),
        );
        //-----add selected file with request
        request.files.add(http.MultipartFile(
            "file", picked.files.single.readStream!, picked.files.single.size,
            filename: picked.files.single.name));
        var response = await request.send();

        print(response.statusCode);

        return response;
      
    }
  }
}
