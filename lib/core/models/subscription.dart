class Subscription {
  String? id;
  String? passCategory;
  String? pass;
  String? status;
  int? time;
  int? amount;
  String? startAt;
  String? endAt;

  Subscription({
    this.id,
    this.passCategory,
    this.pass,
    this.status,
    this.time,
    this.amount,
    this.startAt,
    this.endAt,
  });

  Subscription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    passCategory = json['pass_category'];
    pass = json['pass'];
    status = json['status'];
    time = json['time'];
    amount = json['amount'];
    startAt = json['start_at'];
    endAt = json['end_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pass_category'] = passCategory;
    data['pass'] = pass;
    data['status'] = status;
    data['time'] = time;
    data['amount'] = amount;
    data['start_at'] = startAt;
    data['end_at'] = endAt;
    return data;
  }

  @override
  String toString() {
    return 'Subscription{id: $id, passCategory: $passCategory, pass: $pass, status: $status, time: $time, amount: $amount, startAt: $startAt, endAt: $endAt}';
  }
}
