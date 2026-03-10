

class Log {
  String message;
  String timestamp;

  Log(this.message, this.timestamp);

  void write(){
    print("[$timestamp] $message");
  }
}
