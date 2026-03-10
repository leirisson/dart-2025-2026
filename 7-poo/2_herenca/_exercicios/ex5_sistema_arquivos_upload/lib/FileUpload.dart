
class FileUpload {
  String fileName;
  double size;

  FileUpload(this.fileName, this.size);

  void upload(){
    print("Iniciando upload do arquivo $fileName com tamanho $size MB");
  }
}
