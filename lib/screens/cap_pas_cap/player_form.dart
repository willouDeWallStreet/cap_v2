import 'package:flutter/material.dart';

class PlayerFormPageCore extends StatefulWidget {
  const PlayerFormPageCore({Key? key, required this.title}) : super(key: key);

  static const routeName = '/PlayerFormPageCore';
  final String title;
  
  @override
  PlayerFormPage createState()  => new PlayerFormPage();
}

class PlayerFormPage extends State<PlayerFormPageCore> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int nbPlayer = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: nbPlayer,
                  itemBuilder: (context, index) {
                      return _row(index);
                  },
                ),
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    nbPlayer++;
                  });
                },
                child: const Text('Ajouter un joueur'),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text('Commencer la partie'),
              ),
            ],
          ),
        )
      )
    );
  }

  
  _row(int index) {
    return Row(
      children: [
        Text('Joueur $index'),
        SizedBox(width: 30),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Nom du joueur',
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            setState(() {
              nbPlayer--;
            });
          },
        ),
        /*validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Veuillez entrer un nom';
          }
          return null;
        },*/
      ],
   );
  }
}
