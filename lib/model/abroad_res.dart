class AbroadRes {
  int recordCount;
  List<RegionList> regionList;

  AbroadRes({this.recordCount, this.regionList});

  AbroadRes.fromJson(Map<String, dynamic> json) {
    recordCount = json['recordCount'];
    if (json['regionList'] != null) {
      regionList = new List<RegionList>();
      json['regionList'].forEach((v) {
        regionList.add(new RegionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recordCount'] = this.recordCount;
    if (this.regionList != null) {
      data['regionList'] = this.regionList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RegionList {
  String regionCode;
  String regionName;
  String cover;

  RegionList({this.regionCode, this.regionName, this.cover});

  RegionList.fromJson(Map<String, dynamic> json) {
    regionCode = json['regionCode'];
    regionName = json['regionName'];
    cover = json['cover'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['regionCode'] = this.regionCode;
    data['regionName'] = this.regionName;
    data['cover'] = this.cover;
    return data;
  }
}