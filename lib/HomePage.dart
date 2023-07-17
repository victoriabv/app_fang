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
// 801c24
Color _grana = Color.fromARGB(0xFF, 0x6C, 0x1C, 0x24);

class _HomePageState extends State<HomePage> {
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
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Image.asset(
                    "assets/img/logo_grana.png",
                    width: MediaQuery.of(context).size.width / 2,
                    height: 200,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4, // Ajusta el valor para modificar el tamaño del botón
                  child: ElevatedButton(
                    child: const Text('En procès'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProcesPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: _grana, // background color
                      onPrimary: Colors.white, // foreground color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Ajusta el valor para modificar la curvatura de las esquinas
                      ),
                      padding: const EdgeInsets.all(16), // Ajusta el valor para modificar el tamaño interno del botón
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4, // Ajusta el valor para modificar el tamaño del botón
                  child: ElevatedButton(
                    child: const Text('Galeria'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GaleriaPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: _grana, // background color
                      onPrimary: Colors.white, // foreground color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Ajusta el valor para modificar la curvatura de las esquinas
                      ),
                      padding: const EdgeInsets.all(16), // Ajusta el valor para modificar el tamaño interno del botón
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4, // Ajusta el valor para modificar el tamaño del botón
                  child: ElevatedButton(
                    child: const Text('Sortir'),
                    onPressed: () {
                      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: _grana, // background color
                      onPrimary: Colors.white, // foreground color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Ajusta el valor para modificar la curvatura de las esquinas
                      ),
                      padding: const EdgeInsets.all(16), // Ajusta el valor para modificar el tamaño interno del botón
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
