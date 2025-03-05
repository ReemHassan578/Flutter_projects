import 'package:books_app/features/home/data/models/books_fetch_response_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/networking/api_end_points.dart';

part 'home_remote_data_source.g.dart';

@RestApi(baseUrl:ApiEndPoints.baseUrl)
abstract class HomeRemoteDataSource {

  factory HomeRemoteDataSource(Dio dio, {String baseUrl}) = _HomeRemoteDataSource;

 @GET(ApiEndPoints.allBooks)
  Future<BooksFetchResponse> getAllBooks(@Query("startIndex") int currentPage);


}