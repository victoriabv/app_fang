import 'package:fang/AppBarWidget.dart';
import 'package:fang/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'ImageMethods.dart';

class ProcesPage extends StatefulWidget {
  const ProcesPage({Key? key}) : super(key: key);

  @override
  _ProcesPageState createState() => _ProcesPageState();
}

//Color _grana = Color.fromARGB(0xFF, 0x6C, 0x1C, 0x24);

class _ProcesPageState extends State<ProcesPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  bool _fregar = false; // Valor inicial para el campo "fregar"
  final TextEditingController _fregarController = TextEditingController();
  bool _coure1 = false;
  final TextEditingController _coure1Controller = TextEditingController();
  bool _esmaltar = false;
  final TextEditingController _esmaltarController = TextEditingController();
  bool _coure2 = false;
  final TextEditingController _coure2Controller = TextEditingController();
  final TextEditingController _fangController = TextEditingController();
  final TextEditingController _esmaltsController = TextEditingController();
  final TextEditingController _observacionsController = TextEditingController();

  final CollectionReference _proces =
      FirebaseFirestore.instance.collection('proces');

  final CollectionReference _galeria =
      FirebaseFirestore.instance.collection('galeria');

  Future<void> _create() async {
    _idController.clear();
    _nomController.clear();
    _fregar = false;
    _fregarController.text = _fregar.toString();
    _coure1 = false;
    _coure1Controller.text = _coure1.toString();
    _esmaltar = false;
    _esmaltarController.text = _coure1.toString();
    _coure2 = false;
    _coure2Controller.text = _coure2.toString();
    _fangController.clear();
    _esmaltsController.clear();
    _observacionsController.clear();

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
                          fontSize: 22, // Tamaño de fuente deseado
                          fontWeight: FontWeight.bold, // Peso de fuente deseado
                          color: customColor, // Color de fuente deseado
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  customColor), // Cambia el color de resaltado a gris
                        ),
                      ),
                    ),
                    TextField(
                      controller: _nomController,
                      decoration: InputDecoration(
                        labelText: 'Nom',
                        labelStyle: TextStyle(
                          fontSize: 22, // Tamaño de fuente deseado
                          fontWeight: FontWeight.bold, // Peso de fuente deseado
                          color: customColor, // Color de fuente deseado
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  customColor), // Cambia el color de resaltado a gris
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Fregar',
                          style: TextStyle(
                            fontSize: 18, // Tamaño de fuente deseado
                            fontWeight:
                                FontWeight.bold, // Peso de fuente deseado
                            color: customColor, // Color de fuente deseado
                          ),
                        ),
                        Switch(
                          value: _fregar,
                          onChanged: (value) {
                            setState(() {
                              _fregar = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Coure 1',
                          style: TextStyle(
                            fontSize: 18, // Tamaño de fuente deseado
                            fontWeight:
                                FontWeight.bold, // Peso de fuente deseado
                            color: customColor, // Color de fuente deseado
                          ),
                        ),
                        Switch(
                          value: _coure1,
                          onChanged: (value) {
                            setState(() {
                              _coure1 = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Esmaltar',
                          style: TextStyle(
                            fontSize: 18, // Tamaño de fuente deseado
                            fontWeight:
                                FontWeight.bold, // Peso de fuente deseado
                            color: customColor, // Color de fuente deseado
                          ),
                        ),
                        Switch(
                          value: _esmaltar,
                          onChanged: (value) {
                            setState(() {
                              _esmaltar = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Coure 2',
                          style: TextStyle(
                            fontSize: 18, // Tamaño de fuente deseado
                            fontWeight:
                                FontWeight.bold, // Peso de fuente deseado
                            color: customColor, // Color de fuente deseado
                          ),
                        ),
                        Switch(
                          value: _coure2,
                          onChanged: (value) {
                            setState(() {
                              _coure2 = value;
                            });
                          },
                        ),
                      ],
                    ),
                    DropdownButtonFormField<String>(
                      value: _fangController.text.isEmpty
                          ? null
                          : _fangController.text,
                      decoration: InputDecoration(
                        labelText: 'Fang',
                        labelStyle: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: customColor,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: customColor),
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
                          fontSize: 22, // Tamaño de fuente deseado
                          fontWeight: FontWeight.bold, // Peso de fuente deseado
                          color: customColor, // Color de fuente deseado
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  customColor), // Cambia el color de resaltado a gris
                        ),
                      ),
                    ),
                    TextField(
                      controller: _observacionsController,
                      decoration: InputDecoration(
                        labelText: 'Observacions',
                        labelStyle: TextStyle(
                          fontSize: 22, // Tamaño de fuente deseado
                          fontWeight: FontWeight.bold, // Peso de fuente deseado
                          color: customColor, // Color de fuente deseado
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  customColor), // Cambia el color de resaltado a gris
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      child: const Text('Crear'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: customColor, // background (button) color
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(10)),
                      onPressed: () async {
                        final String id = _idController.text;
                        final String nom = _nomController.text;
                        final bool fregar = _fregar;
                        final bool coure1 = _coure1;
                        final bool esmaltar = _esmaltar;
                        final bool coure2 = _coure2;
                        final String fang = _fangController.text;
                        final String esmalts = _esmaltsController.text;
                        final String observacions =
                            _observacionsController.text;
                        if (id.isNotEmpty) {
                          await _proces.doc().set({
                            "id": id,
                            "nom": nom,
                            "fregar": fregar,
                            "coure_1": coure1,
                            "esmaltar": esmaltar,
                            "coure_2": coure2,
                            "fang": fang,
                            "esmalts": esmalts,
                            "observacions": observacions
                          });
                          _idController.clear();
                          _nomController.clear();
                          _fregar = false;
                          _fregarController.text = _fregar.toString();
                          _coure1 = false;
                          _coure1Controller.text = _coure1.toString();
                          _esmaltar = false;
                          _esmaltarController.text = _coure1.toString();
                          _coure2 = false;
                          _coure2Controller.text = _coure1.toString();
                          _fangController.clear();
                          _esmaltsController.clear();
                          _observacionsController.clear();
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
                    )
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
      _fregar = documentSnapshot['fregar'];
      _fregarController.text = _fregar.toString();
      _coure1 = documentSnapshot['coure_1'];
      _coure1Controller.text = _coure1.toString();
      _esmaltar = documentSnapshot['esmaltar'];
      _esmaltarController.text = _esmaltar.toString();
      _coure2 = documentSnapshot['coure_2'];
      _coure2Controller.text = _coure2.toString();
      _fangController.text = documentSnapshot['fang'];
      _esmaltsController.text = documentSnapshot['esmalts'];
      _observacionsController.text = documentSnapshot['observacions'];
    }

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return SingleChildScrollView(
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              bool showUploadButton =
                  _fregar && _coure1 && _esmaltar && _coure2;

              return Padding(
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
                          fontSize: 22, // Tamaño de fuente deseado
                          fontWeight: FontWeight.bold, // Peso de fuente deseado
                          color: customColor, // Color de fuente deseado
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                              customColor), // Cambia el color de resaltado a gris
                        ),
                      ),
                    ),
                    TextField(
                      controller: _nomController,
                      decoration: InputDecoration(
                        labelText: 'Nom',
                        labelStyle: TextStyle(
                          fontSize: 22, // Tamaño de fuente deseado
                          fontWeight: FontWeight.bold, // Peso de fuente deseado
                          color: customColor, // Color de fuente deseado
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                              customColor), // Cambia el color de resaltado a gris
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Fregar',
                          style: TextStyle(
                            fontSize: 18, // Tamaño de fuente deseado
                            fontWeight:
                            FontWeight.bold, // Peso de fuente deseado
                            color: customColor, // Color de fuente deseado
                          ),
                        ),
                        Switch(
                          value: _fregar,
                          onChanged: (value) {
                            setState(() {
                              _fregar = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Coure 1',
                          style: TextStyle(
                            fontSize: 18, // Tamaño de fuente deseado
                            fontWeight:
                            FontWeight.bold, // Peso de fuente deseado
                            color: customColor, // Color de fuente deseado
                          ),
                        ),
                        Switch(
                          value: _coure1,
                          onChanged: (value) {
                            setState(() {
                              _coure1 = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Esmaltar',
                          style: TextStyle(
                            fontSize: 18, // Tamaño de fuente deseado
                            fontWeight:
                            FontWeight.bold, // Peso de fuente deseado
                            color: customColor, // Color de fuente deseado
                          ),
                        ),
                        Switch(
                          value: _esmaltar,
                          onChanged: (value) {
                            setState(() {
                              _esmaltar = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Coure 2',
                          style: TextStyle(
                            fontSize: 18, // Tamaño de fuente deseado
                            fontWeight:
                            FontWeight.bold, // Peso de fuente deseado
                            color: customColor, // Color de fuente deseado
                          ),
                        ),
                        Switch(
                          value: _coure2,
                          onChanged: (value) {
                            setState(() {
                              _coure2 = value;
                            });
                          },
                        ),
                      ],
                    ),
                    DropdownButtonFormField<String>(
                      value: _fangController.text.isEmpty
                          ? null
                          : _fangController.text,
                      decoration: InputDecoration(
                        labelText: 'Fang',
                        labelStyle: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: customColor,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: customColor),
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
                          fontSize: 22, // Tamaño de fuente deseado
                          fontWeight: FontWeight.bold, // Peso de fuente deseado
                          color: customColor, // Color de fuente deseado
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                              customColor), // Cambia el color de resaltado a gris
                        ),
                      ),
                    ),
                    TextField(
                      controller: _observacionsController,
                      decoration: InputDecoration(
                        labelText: 'Observacions',
                        labelStyle: TextStyle(
                          fontSize: 22, // Tamaño de fuente deseado
                          fontWeight: FontWeight.bold, // Peso de fuente deseado
                          color: customColor, // Color de fuente deseado
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                              customColor), // Cambia el color de resaltado a gris
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.save), // Icono de guardado
                                const SizedBox(width: 5), // Espacio entre el icono y el texto
                                const Text('Guardar'), // Texto del botón
                              ],
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(customColor),
                            ),
                            onPressed: () async {
                              final String id = _idController.text;
                              final String nom = _nomController.text;
                              final bool fregar = _fregar;
                              final bool coure1 = _coure1;
                              final bool esmaltar = _esmaltar;
                              final bool coure2 = _coure2;
                              final String fang = _fangController.text;
                              final String esmalts = _esmaltsController.text;
                              final String observacions =
                                  _observacionsController.text;
                                await _proces.doc(documentSnapshot!.id).update({
                                  "id": id,
                                  "nom": nom,
                                  "fregar": fregar,
                                  "coure_1": coure1,
                                  "esmaltar": esmaltar,
                                  "coure_2": coure2,
                                  "fang": fang,
                                  "esmalts": esmalts,
                                  "observacions": observacions
                                });
                                _idController.clear();
                                _nomController.clear();
                                _fregar = false;
                                _fregarController.text = _fregar.toString();
                                _coure1 = false;
                                _coure1Controller.text = _coure1.toString();
                                _esmaltar = false;
                                _esmaltarController.text = _coure1.toString();
                                _coure2 = false;
                                _coure2Controller.text = _coure1.toString();
                                _fangController.clear();
                                _esmaltsController.clear();
                                _observacionsController.clear();
                                Navigator.of(context).pop();
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        if (showUploadButton)
                          Expanded(
                            child: ElevatedButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.upload), // Icono de subida
                                  const SizedBox(width: 5), // Espacio entre el icono y el texto
                                  const Text('Pujar'), // Texto del botón
                                ],
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(customColor),
                              ),
                              onPressed: () async {
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
                                            ImageMethods imageMetods =
                                                ImageMethods();
                                            String imageUrl = await imageMetods
                                                .imageGallery();
                                            final String id =
                                                _idController.text;
                                            final String nom =
                                                _nomController.text;
                                            final String fang =
                                                _fangController.text;
                                            final String esmalts =
                                                _esmaltsController.text;
                                            final String observacions =
                                                _observacionsController.text;
                                              await _galeria.add({
                                                "id": id,
                                                "nom": nom,
                                                "fang": fang,
                                                "esmalts": esmalts,
                                                "observacions": observacions,
                                                "imageUrl": imageUrl,
                                              });
                                              Navigator.of(context).pop();
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.camera_alt),
                                          title: Text('Càmera'),
                                          onTap: () async {
                                            ImageMethods imageMetods =
                                                ImageMethods();
                                            String imageUrl =
                                                await imageMetods.imageCamera();
                                            final String id =
                                                _idController.text;
                                            final String nom =
                                                _nomController.text;
                                            final String fang =
                                                _fangController.text;
                                            final String esmalts =
                                                _esmaltsController.text;
                                            final String observacions =
                                                _observacionsController.text;
                                              await _galeria.add({
                                                "id": id,
                                                "nom": nom,
                                                "fang": fang,
                                                "esmalts": esmalts,
                                                "observacions": observacions,
                                                "imageUrl": imageUrl,
                                              });
                                              Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            },
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
              child: const Text('Cancelar', style: TextStyle(color: customColor)),
              onPressed: () {
                Navigator.of(context).pop(false); // No se eliminará
              },
            ),
            TextButton(
              child: const Text('Eliminar', style: TextStyle(color: Colors.redAccent),),
              onPressed: () {
                Navigator.of(context).pop(true); // Se eliminará
              },
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      await _proces.doc(id).delete();
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
        subtitle: 'Taller',
        onExit: () {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        },
      ),
      body: StreamBuilder(
        stream: _proces.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            final docs = streamSnapshot.data!.docs;
            //si ho volem ordernar per id, substituim tot el docs.sort per aquesta docs.sort((a, b) => (a['id'] as String).compareTo(b['id'] as String));
            // Ordena los documentos según la cantidad de parámetros true (fregar, coure_1, esmaltar, coure_2)
            docs.sort((a, b) {
              int aTrueCount = 0;
              if (a['fregar'] == true) aTrueCount++;
              if (a['coure_1'] == true) aTrueCount++;
              if (a['esmaltar'] == true) aTrueCount++;
              if (a['coure_2'] == true) aTrueCount++;

              int bTrueCount = 0;
              if (b['fregar'] == true) bTrueCount++;
              if (b['coure_1'] == true) bTrueCount++;
              if (b['esmaltar'] == true) bTrueCount++;
              if (b['coure_2'] == true) bTrueCount++;
              // Ordena en orden descendente por cantidad de parámetros true
              return bTrueCount.compareTo(aTrueCount);
            });

            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot = docs[index];
                final bool allFieldsFilled =
                    documentSnapshot['fregar'] == true &&
                        documentSnapshot['coure_1'] == true &&
                        documentSnapshot['esmaltar'] == true &&
                        documentSnapshot['coure_2'] == true;

                return GestureDetector(
                  onTap: () => _update(documentSnapshot),
                  child: Card(
                    margin: const EdgeInsets.all(10),
                    color: allFieldsFilled ? Colors.teal.shade100 : null,
                    child: ListTile(
                      title: Text(documentSnapshot['nom']),
                      subtitle: Text(documentSnapshot['id']),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (allFieldsFilled)
                              IconButton(
                                icon: const Icon(Icons.upload),
                                onPressed: () => _update(documentSnapshot),
                              ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _delete(documentSnapshot.id),
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

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: Transform.scale(
        scale: 1.3, // Ajusta el valor según el tamaño deseado (1.0 es el tamaño original)
        child: FloatingActionButton(
          onPressed: () => _create(),
          child: const Icon(Icons.add),
          backgroundColor: customColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }


}
