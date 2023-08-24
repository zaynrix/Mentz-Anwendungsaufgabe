class LocationsModel {
  List<SystemMessages>? systemMessages;
  List<Locations>? locations;

  LocationsModel({this.systemMessages, this.locations});

  LocationsModel.fromJson(Map<String, dynamic> json) {
    if (json['systemMessages'] != null) {
      systemMessages = <SystemMessages>[];
      json['systemMessages'].forEach((v) {
        systemMessages!.add(SystemMessages.fromJson(v));
      });
    }
    if (json['locations'] != null) {
      locations = <Locations>[];
      json['locations'].forEach((v) {
        locations!.add(Locations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (systemMessages != null) {
      data['systemMessages'] = systemMessages!.map((v) => v.toJson()).toList();
    }
    if (locations != null) {
      data['locations'] = locations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SystemMessages {
  String? type;
  String? module;
  int? code;
  String? text;

  SystemMessages({this.type, this.module, this.code, this.text});

  SystemMessages.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    module = json['module'];
    code = json['code'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['module'] = module;
    data['code'] = code;
    data['text'] = text;
    return data;
  }
}

class Locations {
  String? id;
  bool? isGlobalId;
  String? name;
  String? disassembledName;
  List<int>? coord;
  String? type;
  int? matchQuality;
  bool? isBest;
  List<dynamic>? productClasses;
  Parent? parent;
  Properties? properties;

  Locations({
    this.id,
    this.isGlobalId,
    this.name,
    this.disassembledName,
    this.coord,
    this.type,
    this.matchQuality,
    this.isBest,
    this.productClasses,
    this.parent,
    this.properties,
  });

  Locations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isGlobalId = (json['isGlobalId'] ?? false);
    name = json['name'];
    disassembledName = json['disassembledName'];
    coord = json['coord']?.cast<int>();
    type = json['type'];
    matchQuality = json['matchQuality'];
    isBest = json['isBest'];
    productClasses = json['productClasses']?.cast<dynamic>();
    parent = json['parent'] != null ? Parent.fromJson(json['parent']) : null;
    properties = json['properties'] != null
        ? Properties.fromJson(json['properties'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['isGlobalId'] = isGlobalId;
    data['name'] = name;
    data['disassembledName'] = disassembledName;
    data['coord'] = coord;
    data['type'] = type;
    data['matchQuality'] = matchQuality;
    data['isBest'] = isBest;
    data['productClasses'] = productClasses;
    if (parent != null) {
      data['parent'] = parent!.toJson();
    }
    if (properties != null) {
      data['properties'] = properties!.toJson();
    }
    return data;
  }
}

class Parent {
  String? id;
  String? name;
  String? type;

  Parent({this.id, this.name, this.type});

  Parent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    return data;
  }
}

class Properties {
  String? stopId;

  Properties({this.stopId});

  Properties.fromJson(Map<String, dynamic> json) {
    stopId = (json['stopId'] ?? "No Stop ID");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stopId'] = stopId;
    return data;
  }
}
