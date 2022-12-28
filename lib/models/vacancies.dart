// To parse this JSON data, do
//
//     final jobs = jobsFromJson(jsonString);

import 'dart:convert';

Jobs jobsFromJson(String str) => Jobs.fromJson(json.decode(str));

String jobsToJson(Jobs data) => json.encode(data.toJson());

class Jobs {
    Jobs({
       required this.result,
    });

    List<Job> result;

    factory Jobs.fromJson(Map<String, dynamic> json) => Jobs(
        result: List<Job>.from(json["result"].map((x) => Job.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
    };
}

class Job {
    Job({
        required this.id,
        required this.companyId,
        required this.title,
        required this.description,
        required this.city,
    });

    int id;
    int companyId;
    String title;
    String description;
    String city;

    factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["id"],
        companyId: json["companyId"],
        title: json["title"],
        description: json["description"],
        city: json["city"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "companyId": companyId,
        "title": title,
        "description": description,
        "city": city,
    };
}
