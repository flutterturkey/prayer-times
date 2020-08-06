import 'dart:convert';

import 'package:http/http.dart';
import 'package:prayertimes/ui/helper/AppConstants.dart';

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
        ulkeAdi: data[i]["UlkeAdi"],
        ulkeId: data[i]["UlkeID"],
      );
      country.add(_country);
    }
  } catch (e) {
    print("Country Data alınamadı. $e");
  }
  return country;
}

Future<List<City>> getCityData(String ulkeId) async {
  List<City> city = [];
  try {
    Response response = await get(cityURL + ulkeId);
    List data = jsonDecode(response.body);
    for (int i = 0; i < data.length; i++) {
      City _city = new City(
        sehirAdi: data[i]["SehirAdi"],
        sehirId: data[i]["SehirID"],
      );
      city.add(_city);
    }
    AppConstants.countryID = ulkeId;
  } catch (e) {
    print("City Data alınamadı. $e");
  }
  return city;
}

Future<List<District>> getDistrictData(String sehirId) async {
  List<District> district = [];
  try {
    Response response = await get(districtURL + sehirId);
    List data = jsonDecode(response.body);
    for (int i = 0; i < data.length; i++) {
      District _district = new District(
        ilceAdi: data[i]["IlceAdi"],
        ilceId: data[i]["IlceID"],
      );
      district.add(_district);
    }
    AppConstants.cityID = sehirId;
  } catch (e) {
    print("District Data alınamadı. $e");
  }
  return district;
}

Future<List<PrayerTime>> getPrayerTimeData(String ilceId) async {
  List<PrayerTime> prayerTime = [];
  try {
    Response response = await get(timeURL + ilceId);
    List data = jsonDecode(response.body);
    for (int i = 0; i < data.length; i++) {
      PrayerTime _prayerTime = new PrayerTime(
        imsak: data[i]["Imsak"],
        gunes: data[i]["Gunes"],
        ogle: data[i]["Ogle"],
        ikindi: data[i]["Ikindi"],
        aksam: data[i]["Aksam"],
        yatsi: data[i]["Yatsi"],
        //miladiTarihKisaIso8601: data[i]['MiladiTarihKisaIso8601'],
      );
      prayerTime.add(_prayerTime);
    }
  } catch (e) {
    print("PrayerTime Data alınamadı. $e");
  }
  return prayerTime;
}
