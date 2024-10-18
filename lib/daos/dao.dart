abstract class Dao<PK, T> {
  Future<List<T>> all();
  Future<T> getById(PK id);
  void delete(T toRemove);
  void update(PK id, T toUpdate);
  void add(T toAdd);
}