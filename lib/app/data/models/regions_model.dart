class Regions {
  String? provinsi;
  List<String>? kota;

  Regions({this.provinsi, this.kota});

  Regions.fromJson(Map<String, dynamic> json) {
    provinsi = json['provinsi'];
    kota = json['kota'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['provinsi'] = provinsi;
    data['kota'] = kota;
    return data;
  }
}
