import 'package:firebase_auth/firebase_auth.dart'; //firebase doğrulama sistemi
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart'; //google ile giriş


class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final String _email = 'beratpaban@gmail.com';

  final String _password = 'password';

  late FirebaseAuth auth;

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;

    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        debugPrint('User oturumu kapalı!');
      } else {
        debugPrint(
            'User oturum açık ${user.email} ve email durumu ${user.emailVerified}!');
      }
    });
  }

//elevated buttonlar başka sayfalara yönlendirilebilir.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                createUserEmailAndPassword();
              },
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: const Text('Email/Şifre Kayıt'),
            ),
            ElevatedButton(
              onPressed: () {
                loginUserEmailAndPassword();
              },
              style: ElevatedButton.styleFrom(primary: Colors.blue),
              child: const Text('Email/Şifre Giriş'),
            ),
            ElevatedButton(
              onPressed: () {
                signOutUser();
              },
              style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
              child: const Text('Oturumu Kapat'),
            ),
            ElevatedButton(
              onPressed: () {
                deleteUser();
              },
              style: ElevatedButton.styleFrom(primary: Colors.teal),
              child: const Text('Hesabı Sil'),
            ),
            ElevatedButton(
              onPressed: () {
                changePassword();
              },
              style: ElevatedButton.styleFrom(primary: Colors.black),
              child: const Text('Parolayı Değiştir'),
            ),
            ElevatedButton(
              onPressed: () {
                changeEmail();
              },
              style: ElevatedButton.styleFrom(primary: Colors.pink),
              child: const Text('Email Değiştir'),
            ),
            ElevatedButton(
              onPressed: () {
                googleIleGiris();
              },
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: const Text('Gmail ile giriş yap'),
            ),
          ],
        ),
      ),
    );
  }

  //kayıt methodu
  void createUserEmailAndPassword() async {
    try {
      var userCredential = await auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      var _myUser = userCredential.user;

      if (!_myUser!.emailVerified != true) {
        await _myUser.sendEmailVerification();
      } else {
        debugPrint('Kullanıcının maili onaylanmış, ilgili sayfaya gidebilir.');
      }

      debugPrint(userCredential.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //login methodu
  void loginUserEmailAndPassword() async {
    try {
      var _userCredential = await auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      debugPrint(_userCredential.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //oturumu kapatma methodu
  void signOutUser() async {
    var _user = GoogleSignIn().currentUser;
    if (_user != null) {
      await GoogleSignIn().signOut();
    }
    await auth.signOut();
  }

  //oturumu silme methodu
  void deleteUser() async {
    if (auth.currentUser != null) {
      await auth.currentUser!.delete();
    } else {
      debugPrint('Kullanıcı oturum açmadığı için silinemez');
    }
  }

  //parola değiştirme methodu
  void changePassword() async {
    try {
      await auth.currentUser!.updatePassword('password');
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        debugPrint('Reauthenticate oluncak');
        var credential =
            EmailAuthProvider.credential(email: _email, password: _password);
        await auth.currentUser!.reauthenticateWithCredential(credential);
        await auth.currentUser!.updatePassword('password');
        debugPrint('Şifre Güncellendi');
        await auth.signOut();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //email değiştirme methodu
  void changeEmail() async {
    try {
      await auth.currentUser!.updateEmail('berat@berat.com');
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        debugPrint('Reauthenticate oluncak');
        var credential =
            EmailAuthProvider.credential(email: _email, password: _password);
        await auth.currentUser!.reauthenticateWithCredential(credential);

        await auth.currentUser!.updateEmail('beratpaban@gmail.com');
        await auth.signOut();
        debugPrint('Email Güncellendi');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //google ile giriş methodu
  void googleIleGiris() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //facebook ile giriş methodu
  
}
