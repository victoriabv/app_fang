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
  //Color _grana = Color.fromARGB(0xFF, 0x6C, 0x1C, 0x24);
  Color _customColor = Colors.teal;
  String fontFamily = 'Victor_Mono';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/img/logo_teal.png",
                width: 50, // Ajusta el valor para modificar el ancho de la imagen
                height: 50, // Ajusta el valor para modificar la altura de la imagen
              ),
              SizedBox(height: 20), // Espacio entre la imagen y el título
              Text(
                'FANG', // Aquí puedes colocar el título deseado
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: _customColor, // Color del título
                ),
              ),
              SizedBox(height: 200),
              Container(
                width: MediaQuery.of(context).size.width * 0.7, // Ajusta el valor para modificar el tamaño del botón
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProcesPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _customColor, // Fondo blanco para el botón
                    foregroundColor: Colors.white, // Color del texto
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ), // Ajusta la curvatura de las esquinas
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ), // Ajusta el tamaño del botón
                  ),
                  child: SingleChildScrollView( // Utilizamos SingleChildScrollView para que el contenido se desplace si es necesario
                    scrollDirection: Axis.horizontal, // Desplazamiento horizontal para el Row
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.construction, // Aquí puedes cambiar el icono por el que desees
                          size: 30,
                        ),
                        SizedBox(width: 10), // Espacio entre el icono y el texto
                        Text(
                          'Taller',
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.7, // Ajusta el valor para modificar el tamaño del botón
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GaleriaPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _customColor, // Fondo blanco para el botón
                    foregroundColor: Colors.white, // Color del texto
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ), // Ajusta la curvatura de las esquinas
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 30,
                    ), // Ajusta el tamaño del botón
                  ),
                  child: SingleChildScrollView( // Utilizamos SingleChildScrollView para que el contenido se desplace si es necesario
                    scrollDirection: Axis.horizontal, // Desplazamiento horizontal para el Row
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.photo_library, // Aquí puedes cambiar el icono por el que desees
                          size: 30,
                        ),
                        SizedBox(width: 10), // Espacio entre el icono y el texto
                        Text(
                          'Galeria',
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

}
