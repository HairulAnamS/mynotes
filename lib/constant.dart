import 'dart:ui';
import 'package:intl/intl.dart';

const int modeBrowse = 0;
const int modeNew = 1;
const int modeEdit = 2;
const int modeDelete = 3;
const Color warna = const Color.fromARGB(255, 0, 0, 80);
final formatter = new NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: 'Rp.');

String getBulan(DateTime aDate){
  List bulanList = [
    "Januari",
    "Februari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember"
  ];
  String result;
  int idxBulan = aDate.month;

  result = bulanList[idxBulan-1] + ' ' + DateFormat('yyyy').format(aDate);
  print('bulan lahir : ' + result);
  return result;
}