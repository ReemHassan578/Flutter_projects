import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseStorage _fireStorage = FirebaseStorage.instance;

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

final FirebaseFirestore _firebaseStore = FirebaseFirestore.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoading = false;

  addUser() async {
    try {
      if (!formKey.currentState!.validate() || (image == null && !isLogin)) {
        return;
      } else {
        setState(() {
          isLoading = true;
        });
        formKey.currentState!.save();
        if (!isLogin) {
          final UserCredential cred =
              await _firebaseAuth.createUserWithEmailAndPassword(
                  email: email!, password: password!);
          final Reference refStorage = _fireStorage.ref();
          final Reference refImage =
              refStorage.child('user_images').child('${cred.user!.uid}.jpg');
          await refImage.putFile(image!);
          final String url = await refImage.getDownloadURL();
          await _firebaseStore.collection('users').doc(cred.user!.uid).set({
            'email': email,
            'imageUrl': url,
            'username': userName,
          });
        } else {
          final UserCredential cred = await _firebaseAuth
              .signInWithEmailAndPassword(email: email!, password: password!);
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() {
      isLoading = false;
    });
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLogin = true;
  String? email;
  String? password;
  File? image;
  String? userName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  padding: const EdgeInsets.all(8),
                  child: Image.asset('lib/assets/chat.png'),
                ),
                Card(
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Form(
                          key: formKey,
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (!isLogin)
                                ImageProfile((newImage) {
                                  image = newImage;
                                }),
                              TextFormField(
                                validator: (String? value) {
                                  if (value == null ||
                                      value.trim().isEmpty ||
                                      !value.contains('@')) {
                                    return 'Invalid Email';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (newValue) {
                                  email = newValue;
                                },
                                textCapitalization: TextCapitalization.none,
                                autocorrect: false,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  label: Text('Email Address'),
                                ),
                              ),
                              if (!isLogin)
                                TextFormField(
                                  validator: (String? value) {
                                    if (value == null ||
                                        value.trim().length < 3) {
                                      return 'Invalid User Name';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (newValue) {
                                    userName = newValue;
                                  },
                                  decoration: const InputDecoration(
                                    label: Text('User Name'),
                                  ),
                                ),
                              TextFormField(
                                validator: (String? value) {
                                  if (value == null ||
                                      value.trim().length < 3) {
                                    return 'Invalid Password';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (newValue) {
                                  password = newValue;
                                },
                                obscureText: true,
                                decoration: const InputDecoration(
                                  label: Text('Password'),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                  ),
                                  onPressed: isLoading ? null : addUser,
                                  child: isLoading
                                      ? const CircularProgressIndicator()
                                      : Text(isLogin ? 'Login' : 'Sign Up')),
                              const SizedBox(
                                height: 8,
                              ),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isLogin = !isLogin;
                                    });
                                  },
                                  child: Text(isLogin
                                      ? 'Create an Account'
                                      : 'I already have an account')),
                            ],
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
