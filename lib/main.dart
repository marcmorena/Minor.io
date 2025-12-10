import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:minor_io/adapters/gravedad.adapter.dart';
import 'package:minor_io/models/actividad.dart';
import 'package:minor_io/models/educador_login.dart';
import 'package:minor_io/models/incidencia.dart';
import 'package:minor_io/models/nota_diaria.dart';
import 'package:minor_io/models/user_model.dart';
import 'package:minor_io/providers/educator_provider.dart';
import 'package:minor_io/providers/users_menores_provider.dart';
import 'package:minor_io/providers/users_adolescentes_provider.dart';
import 'package:minor_io/providers/users_adultos_provider.dart';
import 'package:minor_io/providers/theme_provider.dart';
import 'package:minor_io/theme/theme.dart';
import 'package:minor_io/screens/auth/login_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);

  Hive.registerAdapter(EducadorLoginAdapter());
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(NotaDiariaAdapter());
  Hive.registerAdapter(IncidenciaAdapter());
  Hive.registerAdapter(GravedadAdapter());
  Hive.registerAdapter(ActividadAdapter());

  await Hive.openBox<EducadorLogin>('educadores_login');
  await Hive.openBox<UserModel>('usuarios');
  await Hive.openBox<NotaDiaria>('notas');
  await Hive.openBox<Incidencia>('incidencias');
  await Hive.openBox<Actividad>('actividades');

  final prefs = await SharedPreferences.getInstance();
  final username = prefs.getString('username');
  final nombreReal = prefs.getString('nombreReal');

  runApp(MyApp(username: username, nombreReal: nombreReal));
}

class MyApp extends StatelessWidget {
  final String? username;
  final String? nombreReal;

  const MyApp({super.key, this.username, this.nombreReal});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => EducatorsProvider()),
        ChangeNotifierProvider(create: (_) => UsersMenoresProvider()),
        ChangeNotifierProvider(create: (_) => UsersAdolescentesProvider()),
        ChangeNotifierProvider(create: (_) => UsersAdultosProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Gestor de Usuarios',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: LoginScreen(),
          );
        },
      ),
    );
  }
}
