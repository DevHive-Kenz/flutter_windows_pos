
import '../screens/login_screen/intro.dart';
import '../screens/login_screen/login_screen.dart';
import '../screens/main_sceen.dart';


const String mainRoute = "/mainRoute";
const String introRoute = "/introRoute";
const String loginRoute = "/loginRoute";






final routes = {
  mainRoute: (context) => const MainScreen(),
  introRoute: (context) => const SplashScreen(),
  loginRoute: (context) => const LoginScreen(),


};
