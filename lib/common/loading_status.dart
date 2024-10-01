enum LoadingStatus {
  none(0),
  loading(1),
  success(2),
  error(3),
  info(4);

  final int value;
  const LoadingStatus(this.value);

  bool get isLoading => this == LoadingStatus.loading;
  bool get isNotLoading => this != LoadingStatus.loading;
  bool get isSuccess => this == LoadingStatus.success;
  bool get isFailure => this == LoadingStatus.error;
  bool get isInfo => this == LoadingStatus.info;

  static LoadingStatus merge(List<LoadingStatus> statuses) {
    if (statuses.any((s) => s.isFailure)) {
      return LoadingStatus.error;
    } else if (statuses.any((s) => s.isLoading)) {
      return LoadingStatus.loading;
    } else if (statuses.any((s) => s.isInfo)) {
      return LoadingStatus.info;
    } else if (statuses.any((s) => s.isSuccess)) {
      return LoadingStatus.success;
    } else {
      return LoadingStatus.none;
    }
  }
}
