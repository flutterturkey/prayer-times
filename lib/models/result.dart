import 'dart:convert';

import 'package:http/http.dart';

final String baseUrl = 'https://ezanvakti.herokuapp.com/';
final String cityURL = baseUrl + 'sehirler?ulke=2';
final String district = baseUrl + 'ilceler?sehir=539';
final String time = baseUrl + 'vakitler?ilce=9335';

class City {
  String sehirAdi;
  String sehirId;

  City({
    this.sehirAdi,
    this.sehirId,
  });
}

class District {
  String ilceAdi;
  String ilceId;

  District({
    this.ilceAdi,
    this.ilceId,
  });
}

class PrayerTime {
  String imsak;
  String gunes;
  String ogle;
  String ikindi;
  String aksam;
  String yatsi;

  PrayerTime({
    this.imsak,
    this.gunes,
    this.ogle,
    this.ikindi,
    this.aksam,
    this.yatsi,
  });
}

Future<List<City>> getCityData() async {
  List<City> city = [];
  try {
    Response response = await get(cityURL);
    List data = jsonDecode(response.body);
    for (int i = 0; i < data.length; i++) {
      City _city = new City(
        sehirAdi: data[i]["SehirAdi"],
        sehirId: data[i]["SehirID"],
      );
      city.add(_city);
    }
  } catch (e) {
    print("Data alınamadı. getAllData() $e");
  }
  return city;
}

Future<List<District>> getDistrictData(String sehirId) async {
  List<District> district = [];
  try {
    Response response = await get(baseUrl + "ilceler?sehir=$sehirId");
    List data = jsonDecode(response.body);
    for (int i = 0; i < data.length; i++) {
      District _district = new District(
        ilceAdi: data[i]["IlceAdi"],
        ilceId: data[i]["IlceID"],
      );
      district.add(_district);
    }
  } catch (e) {
    print("Data alınamadı. getAllData() $e");
  }
  print(sehirId);
  return district;
}

Future<List<PrayerTime>> getPrayerTimeData(String ilceId) async {
  List<PrayerTime> prayerTime = [];
  try {
    Response response = await get(baseUrl + "vakitler?ilce=$ilceId");
    List data = jsonDecode(response.body);
    for (int i = 0; i < data.length; i++) {
      PrayerTime _prayerTime = new PrayerTime(
        imsak: data[i]["Imsak"],
        gunes: data[i]["Gunes"],
        ogle: data[i]["Ogle"],
        ikindi: data[i]["Ikindi"],
        aksam: data[i]["Aksam"],
        yatsi: data[i]["Yatsi"],
      );
      prayerTime.add(_prayerTime);
    }
  } catch (e) {
    print("Data alınamadı. getAllData() $e");
  }
  return prayerTime;
}
