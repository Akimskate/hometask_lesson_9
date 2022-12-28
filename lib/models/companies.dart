// To parse this JSON data, do
//
//     final companies = companiesFromJson(jsonString);

import 'dart:convert';

Companies companiesFromJson(String str) => Companies.fromJson(json.decode(str));

String companiesToJson(Companies data) => json.encode(data.toJson());

class Companies {
    Companies({
        required this.result,
    });

    List<Company> result;

    factory Companies.fromJson(Map<String, dynamic> json) => Companies(
        result: List<Company>.from(json["result"].map((x) => Company.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
    };
}

class Company {
    Company({
        required this.id,
        required this.name,
        required this.description,
        required this.industry,
    });

    int id;
    String name;
    String description;
    String industry;

    factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        industry: json["industry"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "industry": industry,
    };
}
