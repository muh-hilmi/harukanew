import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AWG extends GetxController {
  var agendaItems = <AWGData>[].obs;
  RxBool isFetchingData = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http
          .get(Uri.parse('https://haruka2022.com/api_controller/get_awg_data'));
      isFetchingData.value = true;

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];

        agendaItems.assignAll(data.map((item) => AWGData.fromJson(item)));
        // print(agendaItems[1].topik);
        if (agendaItems.isEmpty) {
          agendaItems.assignAll(data.map((item) => AWGData.fromJson(item)));
          isFetchingData.value = false;
        } else {
          // Data sebelumnya sudah ada, bandingkan dengan data yang baru
          final List<AWGData> newAgendaItems =
              data.map((json) => AWGData.fromJson(json)).toList();

          if (!listEquals(agendaItems, newAgendaItems)) {
            // Ada pembaruan data
            agendaItems.value = newAgendaItems;
            isFetchingData.value = false;
          }
        }
      } else {
        throw Exception('Gagal mengambil data dari API');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}

class AWGData {
  final String? id;
  final String? wg;
  final String? swgTg;
  final String? topik;
  final String? expectedDeliverable;
  final String? awg;
  final String? completionTarget;
  final String? picKominfo;
  final String? picStakeholder;
  final String? posisiIndonesia;
  final String? status;
  final String? hasilPertemuan;
  final String? catatan;
  final String? createdAt;
  final String? updatedAt;
  final List<Map<String, dynamic>> awgInDok;
  final List<Map<String, dynamic>> awgHasilDok;
  final List<Map<String, dynamic>> awgRelDok;
  final List<Map<String, dynamic>> awgMainHasilPertemuan;

  AWGData({
    required this.id,
    required this.wg,
    required this.swgTg,
    required this.topik,
    required this.expectedDeliverable,
    required this.awg,
    required this.completionTarget,
    required this.picKominfo,
    required this.picStakeholder,
    required this.posisiIndonesia,
    required this.status,
    required this.hasilPertemuan,
    required this.catatan,
    required this.createdAt,
    required this.updatedAt,
    required this.awgInDok,
    required this.awgHasilDok,
    required this.awgRelDok,
    required this.awgMainHasilPertemuan,
  });

  factory AWGData.fromJson(Map<String, dynamic> json) {
    return AWGData(
      id: json['id'],
      wg: json['wg'],
      swgTg: json['swg_tg'],
      topik: json['topik'],
      expectedDeliverable: json['expected_deliverable'],
      awg: json['awg'],
      completionTarget: json['completion_target'],
      picKominfo: json['pic_kominfo'],
      picStakeholder: json['pic_stakeholder'],
      posisiIndonesia: json['posisi_indonesia'],
      status: json['status'],
      hasilPertemuan: json['hasil_pertemuan'],
      catatan: json['catatan'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      awgInDok: (json['awg_in_dok'] as List<dynamic>?)
              ?.map((item) => (item as Map<String, dynamic>))
              .toList() ??
          [],
      awgHasilDok: (json['awg_hasil_dok'] as List<dynamic>?)
              ?.map((item) => (item as Map<String, dynamic>))
              .toList() ??
          [],
      awgRelDok: (json['awg_rel_dok'] as List<dynamic>?)
              ?.map((item) => (item as Map<String, dynamic>))
              .toList() ??
          [],
      awgMainHasilPertemuan:
          (json['awg_main_hasil_pertemuan'] as List<dynamic>?)
                  ?.map((item) => (item as Map<String, dynamic>))
                  .toList() ??
              [],
    );
  }
}

class AWGInDokData {
  final String? idInput;
  final String? idMain;
  final String? input;
  final String? link;
  final String? source;
  final String? resume;

  AWGInDokData({
    this.idInput,
    this.idMain,
    this.input,
    this.link,
    this.source,
    this.resume,
  });

  factory AWGInDokData.fromJson(Map<String, dynamic> json) {
    return AWGInDokData(
      idInput: json['id_input'],
      idMain: json['id_main'],
      input: json['dok_input'],
      link: json['link_dok'],
      source: json['sumber_dok'],
      resume: json['resume_posisi'],
    );
  }
}

List<AWGInDokData> convertToAWGInDokDataList(List<Map<String, dynamic>> data) {
  return data.map((item) => AWGInDokData.fromJson(item)).toList();
}
