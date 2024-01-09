import 'dart:convert';
// Работа с геолокацией на устройстве
// Плагин для преобразования координат в понятное человеку местоположение
import 'package:geocoding/geocoding.dart';
// Плагин с API для получения текущего местоположения
import 'package:geolocator/geolocator.dart';

// Класс отвечает за получение текущего местоположения пользователя
// и определение названия города по координатам
class LocationService {
  Position? position;
  // ---------Получение текущего местоположения пользователя-------------

  /// Когда службы геолокации отключены или разрешения отклонены,
  Future<void> _checkPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Проверяем, включены ли службы геолокации на устройстве.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Службы геолокации отключены, поэтому не продолжаем
      // получение местоположения и запрашиваем у пользователей
      // включить службы геолокации в приложении.
      return Future.error('Location services are disabled.');
    }
    // Проверяем разрешения на использование геолокации.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Запрос разрешения на использование геолокации, если они не предоставлены
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Разрешения отклонены, в следующий раз вы можете попробовать
        // запросить разрешения снова (здесь также Android может вернуть true
        // для shouldShowRequestPermissionRationale. Согласно рекомендациям Android,
        // ваше приложение должно показать пояснительный интерфейс).
        return Future.error('Location permissions are denied');
      }
    }
    // Разрешения на местоположение отклонены навсегда
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  /// Запрос текущего местоположения с использованием Geolocator.getCurrentPosition.
  Future<Position?> getCurrentPosition() async {
    // Ожидание завершения проверки разрешений перед запросом местоположения.
    await _checkPermissions();

    // Возвращает объект типа Position, который содержит информацию
    // о текущем местоположении, такую как широта, долгота и высота,
    // или null, если доступ к местоположению отсутствует.
    return await Geolocator.getCurrentPosition(
        // Указание желаемой точности местоположения (LocationAccuracy.best).
        desiredAccuracy: LocationAccuracy.best);
  }

// ---------Получение информации о местоположении-------------
// -----------(названия города) по координатам.---------------

  ///
  Future<Placemark> getPlace(Position position) async {
    // Вызов метода placemarkFromCoordinates для получения информации
    // о местоположении по заданным широте и долготе.
    final possiblePlaces = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    // Вывод информации о местоположении в формате JSON.
    print(jsonEncode(possiblePlaces));
    // Возвращение первого элемента из полученного списка местоположений.
    // Это делается с предположением, что самое релевантное местоположение находится
    // в начале списка. Если список пуст, будет возвращено значение null.
    return possiblePlaces[0];
  }
}
