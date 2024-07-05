import 'package:dartz/dartz.dart';
import 'package:oracle_rm/core/domain/usecases/usecase.dart';
import 'package:oracle_rm/core/error/error.dart';

import '../../../../core/characters/domain/entities/entities.dart';
import '../../../../core/characters/domain/repositories/repositories.dart';

enum FilterType {
  name,
  species,
}

class Filter {
  final FilterType filterType;
  final String searchText;

  Filter({required this.filterType, required this.searchText});
}

class GetCharactersParams {
  final int pageNumber;
  final Filter? filter;

  const GetCharactersParams({required this.pageNumber, this.filter});
}

class GetAllCharacters
    extends UseCase<FavoriteCharactersResponse, GetCharactersParams> {
  final CharactersRepository charactersRepository;

  GetAllCharacters({required this.charactersRepository});

  @override
  Future<Either<AppError, FavoriteCharactersResponse>> call(
      GetCharactersParams params) async {
    return await charactersRepository.getAllCharacters(
        pageNumber: params.pageNumber, filter: params.filter);
  }
}
