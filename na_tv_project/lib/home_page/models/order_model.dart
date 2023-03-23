class OrderModel {
  List<Channels>? channels;
  String? clientEmail;
  String? clientFIO;
  String? clientPhone;
  String? status;
  String? text;
  int? totalPrice;

  OrderModel(
      {this.channels,
      this.clientEmail,
      this.clientFIO,
      this.clientPhone,
      this.status,
      this.text,
      this.totalPrice});

  OrderModel.fromJson(Map<String, dynamic> json) {
    if (json['channels'] != null) {
      channels = <Channels>[];
      json['channels'].forEach((v) {
        channels!.add(new Channels.fromJson(v));
      });
    }
    clientEmail = json['clientEmail'];
    clientFIO = json['clientFIO'];
    clientPhone = json['clientPhone'];
    status = json['status'];
    text = json['text'];
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.channels != null) {
      data['channels'] = this.channels!.map((v) => v.toJson()).toList();
    }
    data['clientEmail'] = this.clientEmail;
    data['clientFIO'] = this.clientFIO;
    data['clientPhone'] = this.clientPhone;
    data['status'] = this.status;
    data['text'] = this.text;
    data['totalPrice'] = this.totalPrice;
    return data;
  }
}

class Channels {
  int? channelId;
  List<int>? days;
  int? price;
  int? priceWithDiscount;

  Channels({this.channelId, this.days, this.price, this.priceWithDiscount});

  Channels.fromJson(Map<String, dynamic> json) {
    channelId = json['channelId'];
    days = json['days'].cast<int>();
    price = json['price'];
    priceWithDiscount = json['priceWithDiscount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['channelId'] = this.channelId;
    data['days'] = this.days;
    data['price'] = this.price;
    data['priceWithDiscount'] = this.priceWithDiscount;
    return data;
  }
}
