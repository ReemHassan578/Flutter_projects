import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final String gender;
  final double result;
  final String status;
  final int age;
  const Result(
      {super.key,
      required this.gender,
      required this.result,
      required this.status,
      required this.age});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Result',
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DefaultTextStyle(
                style: Theme.of(context).textTheme.headlineMedium!,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Gender :  $gender'),
                    Text('Result :   ${result.ceilToDouble()}'),
                    Text(
                      'Healthiness : $status  ',
                      textAlign: TextAlign.center,
                    ),
                    Text('age :  $age')
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
