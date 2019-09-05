import 'package:json_annotation/json_annotation.dart';

class HomeModel {
  @JsonKey(name: '0101')
  List<Bean0101> bean0101;
  @JsonKey(name: '0102')
  List<Bean0102> bean0102;
  @JsonKey(name: '0103')
  List<Bean0103> bean0103;
  @JsonKey(name: '0104')
  List<Bean0104> bean0104;
  @JsonKey(name: '0106')
  List<Bean0106> bean0106;

  HomeModel(
      {this.bean0101,
        this.bean0102,
        this.bean0103,
        this.bean0104,
        this.bean0106,});

  HomeModel.fromJson(Map<String, dynamic> json) {
    if (json['0101'] != null) {
      bean0101 = new List<Bean0101>();
      json['0101'].forEach((v) {
        bean0101.add(new Bean0101.fromJson(v));
      });
    }
    if (json['0102'] != null) {
      bean0102 = new List<Bean0102>();
      json['0102'].forEach((v) {
        bean0102.add(new Bean0102.fromJson(v));
      });
    }
    if (json['0103'] != null) {
      bean0103 = new List<Bean0103>();
      json['0103'].forEach((v) {
        bean0103.add(new Bean0103.fromJson(v));
      });
    }
    if (json['0104'] != null) {
      bean0104 = new List<Bean0104>();
      json['0104'].forEach((v) {
        bean0104.add(new Bean0104.fromJson(v));
      });
    }
    if (json['0106'] != null) {
      bean0106 = new List<Bean0106>();
      json['0106'].forEach((v) {
        bean0106.add(new Bean0106.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bean0101 != null) {
      data['0101'] = this.bean0101.map((v) => v.toJson()).toList();
    }
    if (this.bean0102 != null) {
      data['0102'] = this.bean0102.map((v) => v.toJson()).toList();
    }
    if (this.bean0103 != null) {
      data['0103'] = this.bean0103.map((v) => v.toJson()).toList();
    }
    if (this.bean0104 != null) {
      data['0104'] = this.bean0104.map((v) => v.toJson()).toList();
    }
    if (this.bean0106 != null) {
      data['0106'] = this.bean0106.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bean0101 {
  String picture;
  String uRL;
  String iPriority;

  Bean0101({this.picture, this.uRL, this.iPriority});

  Bean0101.fromJson(Map<String, dynamic> json) {
    picture = json['Picture'];
    uRL = json['URL'];
    iPriority = json['iPriority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Picture'] = this.picture;
    data['URL'] = this.uRL;
    data['iPriority'] = this.iPriority;
    return data;
  }
}

class Bean0102 {
  String cInvCode;
  String cInvName;
  String iMarketPrice;
  String iPrice;
  String iUnitPrice;
  String cThumPicture;
  String iSoldSum;
  String iPriority;

  Bean0102(
      {this.cInvCode,
        this.cInvName,
        this.iMarketPrice,
        this.iPrice,
        this.iUnitPrice,
        this.cThumPicture,
        this.iSoldSum,
        this.iPriority});

  Bean0102.fromJson(Map<String, dynamic> json) {
    cInvCode = json['cInvCode'];
    cInvName = json['cInvName'];
    iMarketPrice = json['iMarketPrice'];
    iPrice = json['iPrice'];
    iUnitPrice = json['iUnitPrice'];
    cThumPicture = json['cThumPicture'];
    iSoldSum = json['iSoldSum'];
    iPriority = json['iPriority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cInvCode'] = this.cInvCode;
    data['cInvName'] = this.cInvName;
    data['iMarketPrice'] = this.iMarketPrice;
    data['iPrice'] = this.iPrice;
    data['iUnitPrice'] = this.iUnitPrice;
    data['cThumPicture'] = this.cThumPicture;
    data['iSoldSum'] = this.iSoldSum;
    data['iPriority'] = this.iPriority;
    return data;
  }
}

class Bean0103 {
  String cInvCode;
  String cInvName;
  String iMarketPrice;
  String iPrice;
  String iUnitPrice;
  String cThumPicture;
  String cTag;
  String iPriority;

  Bean0103(
      {this.cInvCode,
        this.cInvName,
        this.iMarketPrice,
        this.iPrice,
        this.iUnitPrice,
        this.cThumPicture,
        this.cTag,
        this.iPriority});

  Bean0103.fromJson(Map<String, dynamic> json) {
    cInvCode = json['cInvCode'];
    cInvName = json['cInvName'];
    iMarketPrice = json['iMarketPrice'];
    iPrice = json['iPrice'];
    iUnitPrice = json['iUnitPrice'];
    cThumPicture = json['cThumPicture'];
    cTag = json['cTag'];
    iPriority = json['iPriority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cInvCode'] = this.cInvCode;
    data['cInvName'] = this.cInvName;
    data['iMarketPrice'] = this.iMarketPrice;
    data['iPrice'] = this.iPrice;
    data['iUnitPrice'] = this.iUnitPrice;
    data['cThumPicture'] = this.cThumPicture;
    data['cTag'] = this.cTag;
    data['iPriority'] = this.iPriority;
    return data;
  }
}

class Bean0104 {
  String cInvCode;
  String cInvName;
  String iMarketPrice;
  String iPrice;
  String iUnitPrice;
  String cThumPicture;
  String iPriority;

  Bean0104(
      {this.cInvCode,
        this.cInvName,
        this.iMarketPrice,
        this.iPrice,
        this.iUnitPrice,
        this.cThumPicture,
        this.iPriority});

  Bean0104.fromJson(Map<String, dynamic> json) {
    cInvCode = json['cInvCode'];
    cInvName = json['cInvName'];
    iMarketPrice = json['iMarketPrice'];
    iPrice = json['iPrice'];
    iUnitPrice = json['iUnitPrice'];
    cThumPicture = json['cThumPicture'];
    iPriority = json['iPriority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cInvCode'] = this.cInvCode;
    data['cInvName'] = this.cInvName;
    data['iMarketPrice'] = this.iMarketPrice;
    data['iPrice'] = this.iPrice;
    data['iUnitPrice'] = this.iUnitPrice;
    data['cThumPicture'] = this.cThumPicture;
    data['iPriority'] = this.iPriority;
    return data;
  }
}

class Bean0106 {
  String aCID;
  String cCover;
  String cTitle;
  String iPriority;

  Bean0106({this.aCID, this.cCover, this.cTitle, this.iPriority});

  Bean0106.fromJson(Map<String, dynamic> json) {
    aCID = json['ACID'];
    cCover = json['cCover'];
    cTitle = json['cTitle'];
    iPriority = json['iPriority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ACID'] = this.aCID;
    data['cCover'] = this.cCover;
    data['cTitle'] = this.cTitle;
    data['iPriority'] = this.iPriority;
    return data;
  }
}
