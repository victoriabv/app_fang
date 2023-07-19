import 'package:fang/AppBarWidget.dart';
import 'package:fang/GaleriaPage.dart';
import 'package:fang/ProcesPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Color personalizado: #801c24
  Color _grana = Color.fromARGB(0xFF, 0x6C, 0x1C, 0x24);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        backgroundColor: _grana,
        subtitle: 'Inici',
        onExit: () {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        },
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/img/logo_grana.png",
                width: MediaQuery.of(context).size.width / 2,
                height: 200,
              ),
              SizedBox(height: 50),
              Container(
                width: MediaQuery.of(context).size.width *
                    0.6, // Ajusta el valor para modificar el tamaño del botón
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProcesPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Fondo blanco para el botón
                    foregroundColor: _grana, // Color del texto
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          30), // Ajusta la curvatura de las esquinas
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20), // Ajusta el tamaño del botón
                  ),
                  child: Text(
                    'En procès',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GaleriaPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Fondo blanco para el botón
                    foregroundColor: _grana, // Color del texto
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          30), // Ajusta la curvatura de las esquinas
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20), // Ajusta el tamaño del botón
                  ),
                  child: Text(
                    'Galeria',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton(
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Fondo blanco para el botón
                    foregroundColor: _grana, // Color del texto
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          30), // Ajusta la curvatura de las esquinas
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20), // Ajusta el tamaño del botón
                  ),
                  child: Text(
                    'Sortir',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
