

void main(List<String> args) {
  List<String> names = ['Aashman', 'Ronaldo', 'Messi'];

  update(names);

  print(names);

}

void update(List<String> names){
  // for(int i = 0; i < names.length; i++){
  //   String name = names[i];
  //   if(name == 'Messi'){
  //     name = 'Lionel Messi';
  //   }
  // }

  // for(var name in names){
  //   if(name == 'Messi'){
  //     name = 'Lionel Messi';
  //   }
  // }

  for(int i = 0; i < names.length; i++){
   names[i];
    if(names[i] == 'Messi'){
      names[i] = 'Lionel Messi';

    }
  }


}
