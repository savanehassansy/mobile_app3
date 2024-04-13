class Pass {
  int? catId;
  String? catLabel;
  String? catDescription;
  List<Bundle> subscriptions = [];

  Pass({catId, catLabel, catDescription, subscriptions});

  Pass.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    catLabel = json['cat_label'];
    catDescription = json['cat_description'];
    if (json['passItems'] != null) {
      subscriptions = [];
      json['passItems'].forEach((v) {
        subscriptions.add(Bundle.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cat_id'] = catId;
    data['cat_label'] = catLabel;
    data['cat_description'] = catDescription;
    data['passItems'] = subscriptions.map((v) => v.toJson()).toList();
    return data;
  }

  @override
  String toString() {
    return 'Pass{catId: $catId, catLabel: $catLabel, catDescription: $catDescription, subscriptions: $subscriptions}';
  }
}

class Bundle {
  int? id;
  String? label;
  int? time;
  int? amount;

  Bundle({id, label, time, amount});

  Bundle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    time = json['time'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['time'] = time;
    data['amount'] = amount;
    return data;
  }

  @override
  String toString() {
    return 'Bundle{id: $id, label: $label, time: $time, amount: $amount}';
  }
}
