class Subscription {
  bool status;
  String message;
  List<Detail> data;

  Subscription({this.status, this.message, this.data});

  Subscription.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] = null) {
      data = <Detail>[];
      json['data'].forEach((v) {
        data.add(Detail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data = null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Detail {
  int id;
  String name;
  String amount;
  String duration;
  String type;
  String createdAt;
  String updatedAt;

  Detail(
      {this.id,
      this.name,
      this.amount,
      this.duration,
      this.type,
      this.createdAt,
      this.updatedAt});

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amount = json['amount'];
    duration = json['duration'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['amount'] = amount;
    data['duration'] = duration;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
