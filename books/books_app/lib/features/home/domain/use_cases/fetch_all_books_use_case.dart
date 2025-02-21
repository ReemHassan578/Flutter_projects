import 'package:books_app/features/home/domain/repos/home_repo.dart';

class FetchAllBooksUseCase {
  final HomeRepo homeRepo;

  FetchAllBooksUseCase({required this.homeRepo});

  fetchAllBooks() {
    homeRepo.getAllBooks();
  }
}
