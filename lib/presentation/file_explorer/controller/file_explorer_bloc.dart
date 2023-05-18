import 'package:code_nexus/core/model/folder_details_model.dart';
import 'package:code_nexus/core/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'file_explorer_event.dart';
part 'file_explorer_state.dart';

class FileExplorerBloc extends Bloc<FileExplorerEvent, FileExplorerState> {
  final String next;
  final String self;
  final String name;
  final UserRepository userRepository;

  FileExplorerBloc({
    required this.self,
    required this.next,
    required this.name,
    required this.userRepository,
  }) : super(const FileExplorerState()) {
    on<FetchFolderDetails>(onFetchFolderDetail);
  }

  void onFetchFolderDetail(
      FetchFolderDetails event, Emitter<FileExplorerState> emit) async {
    try {
      final folderDetails = await userRepository.getFolderDetails(next);

      emit(state.copyWith(
          status: FetchStatus.success, folderDetails: folderDetails));
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
