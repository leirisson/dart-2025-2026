import 'package:ex5_sistema_arquivos_upload/FileUpload.dart';

class ImageUpload extends FileUpload {
  String resolution;
  ImageUpload(super.fileName, super.size, this.resolution);

  @override
  void upload(){
    print("Upload da imagem $fileName com resolução $resolution");
  }

}
