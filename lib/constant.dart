const int modeBrowse = 0;
const int modeNew = 1;
const int modeEdit = 2;
const int modeDelete = 3;


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

  result = bulanList[idxBulan-1];
  print('bulan lahir : ' + result);
  return result;
}