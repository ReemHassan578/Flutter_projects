import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:places/models/place.dart';
import 'package:sqflite/sqflite.dart' as sql;

Future<sql.Database> getDB() async {
  final String databasesPath = await sql.getDatabasesPath();

  sql.Database dataBase = await sql.openDatabase(
    version: 1,
    path.join(databasesPath, 'places.db'),
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE place (id TEXT PRIMARY KEY, name TEXT, image TEXT, lat REAL , long REAL,address TEXT)');
    },
  );

  return dataBase;
}

class ListNotifier extends StateNotifier<List<Place>> {
  ListNotifier() : super([]);

  Future<void> loadPlace() async {
    final sql.Database dataBase = await getDB();
    final List<Map<String, Object?>> data = await dataBase.query('place');
    final loadedPlaces = data.map(
      (e) {
        return Place(
            id: e['id'] as String,
            name: e['name'] as String,
            image: File(e['image'] as String),
            placeLocation: PlaceLocation(
                address: e['address'] as String,
                lng: e['long'] as double,
                lat: e['lat'] as double));
      },
    );
    state = [...loadedPlaces];
  }

  void addPlace(Place place) async {
    final sql.Database dataBase = await getDB();
    dataBase.insert('place', {
      'id': place.id,
      'name': place.name,
      'image': place.image.path,
      'lat': place.placeLocation.lat,
      'long': place.placeLocation.lng,
      'address': place.placeLocation.address
    });

    state = [place, ...state];
  }
}

final listProvider = StateNotifierProvider<ListNotifier, List<Place>>(
  (ref) {
    return ListNotifier();
  },
);
