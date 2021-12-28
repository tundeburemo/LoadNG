class RouteArgument {
  List<dynamic> argumentsList;

  RouteArgument({this.argumentsList});

  @override
  String toString() {
    return '{heroTag:${argumentsList.toString()}}';
  }
}
  