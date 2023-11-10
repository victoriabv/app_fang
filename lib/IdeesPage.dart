import 'package:fang/AppBarWidget.dart';
import 'package:fang/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'ImageMethods.dart';

class IdeesPage extends StatefulWidget {
  const IdeesPage({Key? key}) : super(key: key);

  @override
  _IdeesPageState createState() => _IdeesPageState();
}

//Color _grana = Color.fromARGB(0xFF, 0x6C, 0x1C, 0x24);

class _IdeesPageState extends State<IdeesPage> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  final CollectionReference _idees =
      FirebaseFirestore.instance.collection('idees');

  Future<void> _create() async {
    _nomController.clear();
    _descController.clear();

    await showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width, // Adjust the width as desired
            height: MediaQuery.of(context).size.height * 0.5, // Adjust the height as desired
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _nomController,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Títol',
                        hintStyle: TextStyle(fontSize: 25.0),
                      ),
                      maxLines: null,
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _descController,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Descripció',
                      ),
                      maxLines: null,
                    ),
                    const SizedBox(height: 170),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        child: const Text('Crear'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: customColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(10),
                        ),
                        onPressed: () async {
                          final String nom = _nomController.text;
                          final String desc = _descController.text;
                          if (nom.isNotEmpty) {
                            await _idees.doc().set({"nom": nom, "desc": desc});
                            _nomController.clear();
                            _descController.clear();
                            Navigator.of(context).pop();
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Container(
                                    width: 250,
                                    height: 50,
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        Icon(Icons.info,
                                            size: 40, color: Colors.red[900]),
                                        SizedBox(width: 8),
                                        Text(
                                          'Error',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.red[900]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  content: Text("Has d'introduir un id"),
                                  actions: [
                                    IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }




  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nomController.text = documentSnapshot['nom'];
      _descController.text = documentSnapshot['desc'];
    }

    await showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width, // Adjust the width as desired
            height: MediaQuery.of(context).size.height * 0.5,
            padding: EdgeInsets.all(50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nomController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Títol',
                    hintStyle: TextStyle(fontSize: 25.0),
                  ),
                  style: TextStyle(fontSize: 25.0),
                  maxLines: null,
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _descController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Descripció',
                  ),
                  maxLines: null,
                ),
                const SizedBox(height: 130),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: () async {
                        final String nom = _nomController.text;
                        final String desc = _descController.text;
                        await _idees.doc(documentSnapshot!.id).update({"nom": nom, "desc": desc});
                        _nomController.clear();
                        _descController.clear();
                        Navigator.of(context).pop();
                      },
                      backgroundColor: customColor,
                      mini: true,
                      child: const Icon(Icons.save),
                    ),
                    SizedBox(width: 0.8),
                    FloatingActionButton(
                      onPressed: () async {
                        await _delete(documentSnapshot!.id);
                        Navigator.of(context).pop();
                      },
                      backgroundColor: customColor,
                      mini: true,
                      child: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  Future<void> _delete(String id) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar'),
          content: Row(
            children: [
              Icon(
                Icons.warning,
                color: Colors.red[900],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text('Segur que vols eliminar aquest registre?'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child:
                  const Text('Cancelar', style: TextStyle(color: customColor)),
              onPressed: () {
                Navigator.of(context).pop(false); // No se eliminará
              },
            ),
            TextButton(
              child: const Text(
                'Eliminar',
                style: TextStyle(color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.of(context).pop(true); // Se eliminará
              },
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      await _idees.doc(id).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Eliminat correctament')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        backgroundColor: customColor,
        subtitle: 'Idees',
        onExit: () {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        },
      ),
      body: StreamBuilder(
        stream: _idees.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            final docs = streamSnapshot.data!.docs;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              padding: EdgeInsets.all(15),
              itemCount: docs.length + 1,
              itemBuilder: (context, index) {
                if (index == docs.length) {
                  return GestureDetector(
                    onTap: _create,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Icon(Icons.add),
                      ),
                    ),
                  );
                }
                final DocumentSnapshot documentSnapshot = docs[index];
                return GestureDetector(
                  onTap: () => _update(documentSnapshot),
                  child: Card(
                    //margin: EdgeInsets.all(5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Adjust the border radius as desired
                    ),
                    child: ListTile(
                      title: Text(documentSnapshot['nom']),
                      subtitle: Text(documentSnapshot['desc']),
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
