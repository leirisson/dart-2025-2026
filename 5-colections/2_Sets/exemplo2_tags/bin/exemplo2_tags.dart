void main() {
  Set<String> tags = {'backend', 'api'};

  tags.add('backend'); // não repete
  tags.add('dart');


  print(tags);
}
