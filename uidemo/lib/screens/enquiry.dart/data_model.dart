import 'dart:convert';

GetDataPutModel getDataPutModelFromJson(String str) =>
    GetDataPutModel.fromJson(json.decode(str));

String getDataPutModelToJson(GetDataPutModel data) =>
    json.encode(data.toJson());

class GetDataPutModel {
  List<Map<String, String?>>? data;
  List<Summary>? summary;
  String? closed;
  String? closedBalance;
  String? followups;
  String? upcoming;
  String? pending;
  String? apprv;
  String? updatetdy;
  String? ystrdayupdate;
  String? tdyclosure;
  String? thisWeek;
  String? balance;
  String? balUpcoming;
  String? balPending;
  String? balAppr;
  String? balThisWeek;
  String? allEnquiryCount;
  String? totalBalance;
  String? week;
  String? month;
  String? quarter;

  GetDataPutModel({
    this.data,
    this.summary,
    this.closed,
    this.closedBalance,
    this.followups,
    this.upcoming,
    this.pending,
    this.apprv,
    this.updatetdy,
    this.ystrdayupdate,
    this.tdyclosure,
    this.thisWeek,
    this.balance,
    this.balUpcoming,
    this.balPending,
    this.balAppr,
    this.balThisWeek,
    this.allEnquiryCount,
    this.totalBalance,
    this.week,
    this.month,
    this.quarter,
  });

  factory GetDataPutModel.fromJson(Map<String, dynamic> json) =>
      GetDataPutModel(
        data: json["data"] == null
            ? []
            : List<Map<String, String?>>.from(json["data"]!.map((x) =>
                Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
        summary: json["summary"] == null
            ? []
            : List<Summary>.from(
                json["summary"]!.map((x) => Summary.fromJson(x))),
        closed: json["closed"],
        closedBalance: json["closed_balance"],
        followups: json["followups"],
        upcoming: json["upcoming"],
        pending: json["pending"],
        apprv: json["apprv"],
        updatetdy: json["updatetdy"],
        ystrdayupdate: json["ystrdayupdate"],
        tdyclosure: json["tdyclosure"],
        thisWeek: json["this_week"],
        balance: json["balance"],
        balUpcoming: json["bal_upcoming"],
        balPending: json["bal_pending"],
        balAppr: json["bal_appr"],
        balThisWeek: json["bal_this_week"],
        allEnquiryCount: json["all_enquiryCount"],
        totalBalance: json["total_balance"],
        week: json["week"],
        month: json["month"],
        quarter: json["quarter"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) =>
                Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
        "summary": summary == null
            ? []
            : List<dynamic>.from(summary!.map((x) => x.toJson())),
        "closed": closed,
        "closed_balance": closedBalance,
        "followups": followups,
        "upcoming": upcoming,
        "pending": pending,
        "apprv": apprv,
        "updatetdy": updatetdy,
        "ystrdayupdate": ystrdayupdate,
        "tdyclosure": tdyclosure,
        "this_week": thisWeek,
        "balance": balance,
        "bal_upcoming": balUpcoming,
        "bal_pending": balPending,
        "bal_appr": balAppr,
        "bal_this_week": balThisWeek,
        "all_enquiryCount": allEnquiryCount,
        "total_balance": totalBalance,
        "week": week,
        "month": month,
        "quarter": quarter,
      };
}

class Summary {
  String? total;
  String? summary;

  Summary({
    this.total,
    this.summary,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        total: json["total"],
        summary: json["summary"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "summary": summary,
      };
}
