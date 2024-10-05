import 'dart:math';
import 'package:bmi/screens/result.dart';
import 'package:flutter/material.dart';

import '../widgets/gender_container.dart';
import '../widgets/plusminus_container.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String gender = 'Male';
  double height = 150;
  int weight = 50;
  int age = 20;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Body Mass Index'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: GenderContainer(
                        icon: Icons.male,
                        type: 'Male',
                        gender: gender,
                        onPress: () {
                          setState(() {
                            gender = 'Male';
                          });
                        }),
                  ),
                  Expanded(
                    child: GenderContainer(
                        gender: gender,
                        icon: Icons.female,
                        type: 'Female',
                        onPress: () {
                          setState(() {
                            gender = 'Female';
                          });
                        }),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                  color: Theme.of(context).colorScheme.secondary,
                  child: Column(
                    children: [
                      Text(
                        'Height',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${height.ceilToDouble()}',
                              style: const TextStyle(fontSize: 50)),
                          Text(
                            ' cm',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                      Slider(
                        max: 200,
                        min: 0,
                        value: height,
                        onChanged: (value) {
                          setState(() {
                            height = value;
                          });
                        },
                      )
                    ],
                  )),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: PlusMinusContainer(
                    text: 'Weight',
                    value: weight,
                    add: () {
                      setState(() {
                        weight++;
                      });
                    },
                    subtract: () {
                      if (weight - 1 < 0) return;
                      setState(() {
                        weight--;
                      });
                    },
                  )),
                  Expanded(
                      child: PlusMinusContainer(
                          text: 'Age',
                          value: age,
                          add: () {
                            setState(() {
                              age++;
                            });
                          },
                          subtract: () {
                            if (age - 1 < 0) return;
                            setState(() {
                              age--;
                            });
                          })),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    calculate();
                  },
                  style: ElevatedButton.styleFrom(),
                  child: const Text(
                    'Calculate',
                    style: TextStyle(fontSize: 20),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  calculate() {
    final bmi = weight / pow(height / 100, 2);
    String status = 'Normal';
    if (bmi < 18.5) {
      status = 'Underweight';
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      status = 'Normal';
    } else if (bmi >= 25 && bmi <= 29.9) {
      status = 'Overweight';
    } else {
      status = 'Obese';
    }

    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) {
        return Result(gender: gender, result: bmi, status: status, age: age);
      },
    ));
  }
}
