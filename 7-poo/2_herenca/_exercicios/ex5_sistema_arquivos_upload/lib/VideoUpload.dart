


import 'package:ex5_sistema_arquivos_upload/FileUpload.dart';

class VideoUpload extends FileUpload{
  double duration;
  VideoUpload(super.fileName, super.size, this.duration);

  @override
  void upload(){
    print("Upload do vídeo $fileName com duração $duration minutos");
  }
}