part of 'file_explorer_bloc.dart';

enum FetchStatus { initial, success, failure }

class FileExplorerState {
  final FetchStatus status;
  final FolderDetailsModel folderDetails;
  final String? errorMessage;
  const FileExplorerState({
    this.status = FetchStatus.initial,
    this.errorMessage,
    this.folderDetails = const FolderDetailsModel(),
  });
  FileExplorerState copyWith(
      {FetchStatus? status,
      String? errorMessage,
      FolderDetailsModel? folderDetails}) {
    return FileExplorerState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      folderDetails: folderDetails ?? this.folderDetails,
    );
  }
}
