import 'package:ex5_sistema_arquivos_upload/FileUpload.dart';
import 'package:ex5_sistema_arquivos_upload/ImageUpload.dart';
import 'package:ex5_sistema_arquivos_upload/VideoUpload.dart';


void main() {
  List<FileUpload> files = [
    ImageUpload("foto.jpg", 25, "Full HD"),
    VideoUpload("filmagem_da_festa.mp4", 15, 21),
  ];

  for (FileUpload file in files) {
    file.upload();
  }
}
