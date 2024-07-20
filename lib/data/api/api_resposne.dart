class ApiResponse<T> {
  final bool status;
  final String title;
  final String message;

  final T? data;

  ApiResponse({
    required this.status,
    this.title = '',
    this.message = '',
    this.data,
  });
}
