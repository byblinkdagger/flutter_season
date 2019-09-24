class GoodsRes {
  String cPDCode;
  String cPDName;
  String cPDCCode;
  String cPDCName;
  String cPDBrand;
  String cPDUnit;
  String cPDStd;
  double cPDPackage;
  String cPDPackageStd;
//  double cPDPackageLength;
//  double cPDPackageWidth;
//  double cPDPackageHeight;
//  double cPDPackageWeight;
  String validity;
  String cCountry;
  String cCName;
  String cDescription;
  List<String> cAttrs;
  List<String> Pictures;
  List<String> lstDetail;
  String iMaxMarketPrice;
  String iMinMarketPrice;
  String iMaxPrice;
  String iMinPrice;
  String iMaxUnitPrice;
  String iMinUnitPrice;
  String iSumStock;
  String iSumSold;
  String collected;

  GoodsRes(
      {this.cPDCode,
        this.cPDName,
        this.cPDCCode,
        this.cPDCName,
        this.cPDBrand,
        this.cPDUnit,
        this.cPDStd,
        this.cPDPackage,
        this.cPDPackageStd,
//        this.cPDPackageLength,
//        this.cPDPackageWidth,
//        this.cPDPackageHeight,
//        this.cPDPackageWeight,
        this.validity,
        this.cCountry,
        this.cCName,
        this.cDescription,
        this.cAttrs,
        this.Pictures,
        this.lstDetail,
        this.iMaxMarketPrice,
        this.iMinMarketPrice,
        this.iMaxPrice,
        this.iMinPrice,
        this.iMaxUnitPrice,
        this.iMinUnitPrice,
        this.iSumStock,
        this.iSumSold,
        this.collected});

  GoodsRes.fromJson(Map<String, dynamic> json) {
    cPDCode = json['cPDCode'];
    cPDName = json['cPDName'];
    cPDCCode = json['cPDCCode'];
    cPDCName = json['cPDCName'];
    cPDBrand = json['cPDBrand'];
    cPDUnit = json['cPDUnit'];
    cPDStd = json['cPDStd'];
    cPDPackage = json['cPDPackage'];
    cPDPackageStd = json['cPDPackageStd'];
//    cPDPackageLength = json['cPDPackageLength'];
//    cPDPackageWidth = json['cPDPackageWidth'];
//    cPDPackageHeight = json['cPDPackageHeight'];
//    cPDPackageWeight = json['cPDPackageWeight'];
    validity = json['validity'];
    cCountry = json['cCountry'];
    cCName = json['cCName'];
    cDescription = json['cDescription'];
    cAttrs = json['cAttrs'].cast<String>();
    Pictures = json['Pictures'].cast<String>();
    lstDetail = json['lstDetail'].cast<String>();
    iMaxMarketPrice = json['iMaxMarketPrice'];
    iMinMarketPrice = json['iMinMarketPrice'];
    iMaxPrice = json['iMaxPrice'];
    iMinPrice = json['iMinPrice'];
    iMaxUnitPrice = json['iMaxUnitPrice'];
    iMinUnitPrice = json['iMinUnitPrice'];
    iSumStock = json['iSumStock'];
    iSumSold = json['iSumSold'];
    collected = json['collected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cPDCode'] = this.cPDCode;
    data['cPDName'] = this.cPDName;
    data['cPDCCode'] = this.cPDCCode;
    data['cPDCName'] = this.cPDCName;
    data['cPDBrand'] = this.cPDBrand;
    data['cPDUnit'] = this.cPDUnit;
    data['cPDStd'] = this.cPDStd;
    data['cPDPackage'] = this.cPDPackage;
    data['cPDPackageStd'] = this.cPDPackageStd;
//    data['cPDPackageLength'] = this.cPDPackageLength;
//    data['cPDPackageWidth'] = this.cPDPackageWidth;
//    data['cPDPackageHeight'] = this.cPDPackageHeight;
//    data['cPDPackageWeight'] = this.cPDPackageWeight;
    data['validity'] = this.validity;
    data['cCountry'] = this.cCountry;
    data['cCName'] = this.cCName;
    data['cDescription'] = this.cDescription;
    data['cAttrs'] = this.cAttrs;
    data['Pictures'] = this.Pictures;
    data['lstDetail'] = this.lstDetail;
    data['iMaxMarketPrice'] = this.iMaxMarketPrice;
    data['iMinMarketPrice'] = this.iMinMarketPrice;
    data['iMaxPrice'] = this.iMaxPrice;
    data['iMinPrice'] = this.iMinPrice;
    data['iMaxUnitPrice'] = this.iMaxUnitPrice;
    data['iMinUnitPrice'] = this.iMinUnitPrice;
    data['iSumStock'] = this.iSumStock;
    data['iSumSold'] = this.iSumSold;
    data['collected'] = this.collected;
    return data;
  }
}
