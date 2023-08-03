
class DataState<T> {
  T? data;
  Exception? error;

  DataState({
    this.data,
    this.error,
  }) : assert(data != null || error != null);

  DataState<T> copyWith({
    T? data,
    Exception? error,
  }) {
    return DataState<T>(
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  String toString() =>
      'RemoteData<${data.runtimeType}>(data: $data, error: $error)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DataState<T> && other.data == data && other.error == error;
  }

  @override
  int get hashCode => data.hashCode ^ error.hashCode;
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess(T data) : super(data: data);
}

class DataError<T> extends DataState<T> {
  DataError(Exception error) : super(error: error);
}
