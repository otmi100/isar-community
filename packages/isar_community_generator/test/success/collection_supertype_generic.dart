import 'package:isar_community/isar.dart';

abstract class IMyInterface<T> {
  @ignore
  T get object;
}

@collection
class Model<T> extends IMyInterface<T> {
  @override
  Id? id;

  @override
  @ignore
  T get object => 'example' as T;
}
