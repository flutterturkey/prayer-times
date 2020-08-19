import 'dart:convert';

import 'package:http/http.dart';

import 'city.dart';
import 'country.dart';
import 'district.dart';
import 'prayer_time.dart';

final String baseUrl = 'https://ezanvakti.herokuapp.com/';
final String countryURL = baseUrl + 'ulkeler';
final String cityURL = baseUrl + 'sehirler?ulke=';
final String districtURL = baseUrl + 'ilceler?sehir=';
final String timeURL = baseUrl + 'vakitler?ilce=';

Future<List<Country>> getCountryData() async {
  List<Country> country = [];
  try {
    Response response = await get(countryURL);
    List data = jsonDecode(response.body);
    for (int i = 0; i < data.length; i++) {
      Country _country = new Country(
        countryName: data[i]["UlkeAdi"],
        countryID: data[i]["UlkeID"],
      );
      country.add(_country);
    }
  } catch (e) {
    print("Country Data alınamadı. $e");
  }
  return country;
}

Future<List<City>> getCityData(String countryID) async {
  List<City> city = [];
  try {
    Response response = await get(cityURL + countryID);
    List data = jsonDecode(response.body);
    for (int i = 0; i < data.length; i++) {
      City _city = new City(
        cityName: data[i]["SehirAdi"],
        cityID: data[i]["SehirID"],
      );
      city.add(_city);
    }
  } catch (e) {
    print("City Data alınamadı. $e");
  }
  return city;
}

Future<List<District>> getDistrictData(String cityID) async {
  List<District> district = [];
  try {
    Response response = await get(districtURL + cityID);
    List data = jsonDecode(response.body);
    for (int i = 0; i < data.length; i++) {
      District _district = new District(
        districtName: data[i]["IlceAdi"],
        districtID: data[i]["IlceID"],
      );
      district.add(_district);
    }
  } catch (e) {
    print("District Data alınamadı. $e");
  }
  return district;
}

Future<List<PrayerTime>> getPrayerTimeData(String districtID) async {
  List<PrayerTime> prayerTime = [];
  try {
    Response response = await get(timeURL + districtID);
    List data = jsonDecode(response.body);
    for (int i = 0; i < data.length; i++) {
      PrayerTime _prayerTime = new PrayerTime(
        imsak: data[i]["Imsak"],
        sun: data[i]["Gunes"],
        noon: data[i]["Ogle"],
        afternoon: data[i]["Ikindi"],
        evening: data[i]["Aksam"],
        moon: data[i]["Yatsi"],
      );
      prayerTime.add(_prayerTime);
    }
  } catch (e) {
    print("PrayerTime Data alınamadı. $e");
  }
  return prayerTime;
}
