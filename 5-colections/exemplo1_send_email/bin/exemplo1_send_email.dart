void main(List<String> arguments) {
  List<String> listaDeEmails = ["leirisson@gmail.com", "maria@gmail.com"];


  
  for (String email in listaDeEmails) {
    sendEmail(email);
  }
}

void sendEmail(String email) {
  print("mensagem enviada para: $email");
}
