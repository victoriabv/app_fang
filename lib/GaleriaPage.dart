import 'package:fang/AppBarWidget.dart';
import 'package:fang/ImageMethods.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';


class GaleriaPage extends StatefulWidget {
  const GaleriaPage({Key? key}) : super(key: key);

  @override
  _GaleriaPageState createState() => _GaleriaPageState();
}

Color _grana = Color.fromARGB(0xFF, 0x6C, 0x1C, 0x24);

class _GaleriaPageState extends State<GaleriaPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _fangController = TextEditingController();
  final TextEditingController _esmaltsController = TextEditingController();
  final TextEditingController _observacionsController = TextEditingController();
  String? _imageUrl;

  final CollectionReference _galeria =
      FirebaseFirestore.instance.collection('galeria');


  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    _idController.clear();
    _nomController.clear();
    _fangController.clear();
    _esmaltsController.clear();
    _observacionsController.clear();

    String? _imageUrl;
    bool imageSelected = false;

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _idController,
                      decoration: InputDecoration(
                        labelText: 'Id',
                        labelStyle: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: _grana,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: _grana),
                        ),
                      ),
                    ),
                    TextField(
                      controller: _nomController,
                      decoration: InputDecoration(
                        labelText: 'Nom',
                        labelStyle: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: _grana,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: _grana),
                        ),
                      ),
                    ),
                    DropdownButtonFormField<String>(
                      value: _fangController.text.isEmpty ? null : _fangController.text,
                      decoration: InputDecoration(
                        labelText: 'Fang',
                        labelStyle: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: _grana,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: _grana),
                        ),
                      ),
                      items: ['Fang marró', 'Fang vermell', 'Gres', 'Fake gres']
                          .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _fangController.text = newValue ?? '';
                        });
                      },
                    ),
                    TextField(
                      controller: _esmaltsController,
                      decoration: InputDecoration(
                        labelText: 'Esmalts',
                        labelStyle: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: _grana,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: _grana),
                        ),
                      ),
                    ),
                    TextField(
                      controller: _observacionsController,
                      decoration: InputDecoration(
                        labelText: 'Observacions',
                        labelStyle: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: _grana,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: _grana),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(
                              title: Text('Afegeix una imatge'),
                              children: [
                                ListTile(
                                  leading: Icon(Icons.photo),
                                  title: Text('Galeria'),
                                  onTap: () async {
                                    ImageMethods imageMetods = ImageMethods();
                                    String imageUrl =
                                    await imageMetods.imageGallery();
                                    setState(() {
                                      _imageUrl = imageUrl;
                                      imageSelected = true;
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.camera_alt),
                                  title: Text('Càmera'),
                                  onTap: () async {
                                    ImageMethods imageMetods = ImageMethods();
                                    String imageUrl =
                                    await imageMetods.imageCamera();
                                    setState(() {
                                      _imageUrl = imageUrl;
                                      imageSelected = true;
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.grey[300],
                        ),
                        child: _imageUrl != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            _imageUrl!,
                            fit: BoxFit.cover,
                          ),
                        )
                            : Icon(Icons.image_search, size: 24.0),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          child: const Text('Cancelar'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          child: const Text('Aceptar'),
                          style: ElevatedButton.styleFrom(
                            primary: _grana,
                          ),
                          onPressed: () async {
                            final String id = _idController.text;
                            final String nom = _nomController.text;
                            final String fang = _fangController.text;
                            final String esmalts = _esmaltsController.text;
                            final String observacions =
                                _observacionsController.text;
                            if (imageSelected && id.isNotEmpty) {
                              await _galeria.add({
                                "id": id,
                                "nom": nom,
                                "fang": fang,
                                "esmalts": esmalts,
                                "observacions": observacions,
                                "imageUrl": _imageUrl,
                              });
                              _idController.text = '';
                              _nomController.text = '';
                              _fangController.text = '';
                              _esmaltsController.text = '';
                              _observacionsController.text = '';
                              setState(() {
                                imageSelected = false;
                              });
                              Navigator.of(context).pop();
                            } else if (!imageSelected && id.isEmpty) {
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
                                    content: Text(
                                        "Has d'introduir un id i seleccionar una imatge"),
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
                            } else if (!imageSelected) {
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
                                    content:
                                    Text("Has de seleccionar una imatge"),
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
                            } else if (id.isEmpty) {
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
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }



  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _idController.text = documentSnapshot['id'];
      _nomController.text = documentSnapshot['nom'];
      _fangController.text = documentSnapshot['fang'];
      _esmaltsController.text = documentSnapshot['esmalts'];
      _observacionsController.text = documentSnapshot['observacions'];
      _imageUrl = documentSnapshot['imageUrl'];
    }

    bool imageSelected = false;

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              // Agregar SingleChildScrollView aquí
              child: Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IgnorePointer(
                      ignoring: true,
                      child: TextField(
                        controller: _idController,
                        decoration: InputDecoration(
                          labelText: 'Id',
                          labelStyle: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: _grana,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: _grana),
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      controller: _nomController,
                      decoration: InputDecoration(
                        labelText: 'Nom',
                        labelStyle: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: _grana,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: _grana),
                        ),
                      ),
                    ),
                    DropdownButtonFormField<String>(
                      value: _fangController.text.isEmpty ? null : _fangController.text,
                      decoration: InputDecoration(
                        labelText: 'Fang',
                        labelStyle: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: _grana,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: _grana),
                        ),
                      ),
                      items: ['Fang marró', 'Fang vermell', 'Gres', 'Fake gres']
                          .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _fangController.text = newValue ?? '';
                        });
                      },
                    ),
                    TextField(
                      controller: _esmaltsController,
                      decoration: InputDecoration(
                        labelText: 'Esmalts',
                        labelStyle: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: _grana,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: _grana),
                        ),
                      ),
                    ),
                    TextField(
                      controller: _observacionsController,
                      decoration: InputDecoration(
                        labelText: 'Observacions',
                        labelStyle: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: _grana,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: _grana),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(
                              title: Text('Afegeix una imatge'),
                              children: [
                                ListTile(
                                  leading: Icon(Icons.photo),
                                  title: Text('Galeria'),
                                  onTap: () async {
                                    ImageMethods imageMetods = ImageMethods();
                                    String imageUrl =
                                    await imageMetods.imageGallery();
                                    setState(() {
                                      _imageUrl = imageUrl;
                                      imageSelected = true;
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.camera_alt),
                                  title: Text('Càmera'),
                                  onTap: () async {
                                    ImageMethods imageMetods = ImageMethods();
                                    String imageUrl =
                                    await imageMetods.imageCamera();
                                    setState(() {
                                      _imageUrl = imageUrl;
                                      imageSelected = true;
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.grey[300],
                        ),
                        child: _imageUrl != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            _imageUrl!,
                            fit: BoxFit.cover,
                          ),
                        )
                            : SizedBox(), // Dejar en blanco si no hay imagen seleccionada
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          child: const Text('Cancelar'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          child: const Text('Aceptar'),
                          style: ElevatedButton.styleFrom(
                            primary: _grana,
                          ),
                          onPressed: () async {
                            final String id = _idController.text;
                            final String nom = _nomController.text;
                            final String fang = _fangController.text;
                            final String esmalts = _esmaltsController.text;
                            final String observacions =
                                _observacionsController.text;
                            await _galeria.doc(documentSnapshot!.id).update({
                              "id": id,
                              "nom": nom,
                              "fang": fang,
                              "esmalts": esmalts,
                              "observacions": observacions,
                              "imageUrl": imageSelected
                                  ? _imageUrl
                                  : documentSnapshot['imageUrl'],
                            }).then((_) {
                              _idController.text = '';
                              _nomController.text = '';
                              _fangController.text = '';
                              _esmaltsController.text = '';
                              _observacionsController.text = '';
                              Navigator.of(context).pop();
                              _showDetails(documentSnapshot);
                            }).catchError((error) =>
                                print("Error updating document: $error"));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
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
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(false); // No se eliminará
              },
            ),
            TextButton(
              child: const Text('Eliminar'),
              onPressed: () {
                Navigator.of(context).pop(true); // Se eliminará
              },
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      await _galeria.doc(id).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Eliminat correctament')),
      );
    }
  }



  Future<void> _showDetails(DocumentSnapshot documentSnapshot) async {
    List<DocumentSnapshot> galleryData = []; // Contendrá los datos de todas las imágenes en la galería
    QuerySnapshot snapshot = await _galeria.orderBy('id').get();
    galleryData = snapshot.docs;

    int currentIndex = galleryData.indexWhere((element) => element.id == documentSnapshot.id);

    await showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return Dialog(
          insetPadding: EdgeInsets.all(0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 100,
              maxHeight: MediaQuery.of(ctx).size.height * 0.8, // Ajusta la altura máxima según tus necesidades
            ),
            child: PageView.builder(
              controller: PageController(initialPage: currentIndex),
              itemCount: galleryData.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot currentSnapshot = galleryData[index];
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(50.0), // Ajustar el padding inferior a 0
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(ctx).push(
                              MaterialPageRoute<void>(
                                fullscreenDialog: true,
                                builder: (BuildContext ctx) {
                                  return Scaffold(
                                    backgroundColor: Colors.black,
                                    body: GestureDetector(
                                      child: Center(
                                        child: Hero(
                                          tag: "customTag",
                                          child: Image.network(
                                            currentSnapshot['imageUrl'],
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(
                              currentSnapshot['imageUrl'],
                              width: 250,
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text(
                                'Id: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: _grana,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Text(
                                '${currentSnapshot['id']}',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text(
                                'Fang: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: _grana,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Text(
                                '${currentSnapshot['fang']}',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text(
                                'Esmalts: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: _grana,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 2,
                              child: Text(
                                '${currentSnapshot['esmalts']}',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Flexible(
                              flex: 2,
                              child: Text(
                                'Observacions: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: _grana,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 2,
                              child: Text(
                                '${currentSnapshot['observacions']}',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.of(ctx).pop();
                                _update(currentSnapshot);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                Navigator.of(ctx).pop();
                                _delete(currentSnapshot.id);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        backgroundColor: _grana,
        subtitle: 'Galeria',
        onExit: () {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        },
      ),
      body: StreamBuilder(
        stream: _galeria.orderBy('id').snapshots(), // Ordenar por 'id'
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                streamSnapshot.data!.docs[index];
                return GestureDetector(
                  onTap: () => _showDetails(documentSnapshot),
                  child: Card(
                    margin: const EdgeInsets.all(10),
                    child: Image.network(
                      documentSnapshot['imageUrl'],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        child: const Icon(Icons.add),
        backgroundColor: _grana,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
