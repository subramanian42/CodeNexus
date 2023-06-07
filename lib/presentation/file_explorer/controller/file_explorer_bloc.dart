import 'package:code_nexus/core/model/folder_details_model.dart';
import 'package:code_nexus/core/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'file_explorer_event.dart';
part 'file_explorer_state.dart';

class FileExplorerParams {
  const FileExplorerParams({
    required this.name,
    required this.self,
    required this.next,
  });

  final String name;
  final String self;
  final String next;

  factory FileExplorerParams.fromMap(Map<String, String> map) {
    return FileExplorerParams(
      name: map['name'] as String,
      self: map['self'] as String,
      next: map['next'] as String,
    );
  }

  Map<String, String> toMap() {
    return {
      'name': name,
      'self': self,
      'next': next,
    };
  }
}

class FileExplorerBloc extends Bloc<FileExplorerEvent, FileExplorerState> {
  final FileExplorerParams params;
  final UserRepository userRepository;

  FileExplorerBloc({
    required this.params,
    required this.userRepository,
  }) : super(const FileExplorerState()) {
    on<FetchFolderDetails>(onFetchFolderDetail);
  }

  void onFetchFolderDetail(FetchFolderDetails event, Emitter<FileExplorerState> emit) async {
    try {
      final folderDetails = await userRepository.getFolderDetails(params.next);

      emit(state.copyWith(status: FetchStatus.success, folderDetails: folderDetails));
    } catch (e) {
      emit(
        state.copyWith(
          status: FetchStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
