import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APG extends GetxController {
  var agendaItems = <APGData>[].obs;
  RxBool isFetchingData = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http
          .get(Uri.parse('https://haruka2022.com/api_controller/get_apg_data'));
      isFetchingData.value = true;

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];

        // print(agendaItems[0].alokasi);
        if (agendaItems.isEmpty) {
          agendaItems.assignAll(data.map((item) => APGData.fromJson(item)));
          isFetchingData.value = false;
        } else {
          // Data sebelumnya sudah ada, bandingkan dengan data yang baru
          final List<APGData> newAgendaItems =
              data.map((json) => APGData.fromJson(json)).toList();

          if (!listEquals(agendaItems, newAgendaItems)) {
            // Ada pembaruan data
            agendaItems.value = newAgendaItems;
            isFetchingData.value = false;
          }
        }
      } else {
        isFetchingData.value = false;
        throw Exception('Gagal mengambil data dari API');
      }
    } catch (error) {
      print('Error: $error');
      isFetchingData.value = false;
    }
  }
}

class APGData {
  final String? id;
  final String? apg;
  final String? cpm;
  final String? cpmChapter;
  final String? agendaItem;
  final String? judulAi;
  final String? alokasi;
  final String? posisiIndonesia;
  final String? organisasiInternasional;
  final String? picStakeholder;
  final String? picKominfo;
  final String? cpmPicStakeholder;
  final String? cpmPicKominfo;
  final List<Map<String, dynamic>>? apgInDok;

  APGData({
    required this.id,
    required this.apg,
    required this.cpm,
    required this.cpmChapter,
    required this.agendaItem,
    required this.judulAi,
    required this.alokasi,
    required this.posisiIndonesia,
    required this.organisasiInternasional,
    required this.picStakeholder,
    required this.picKominfo,
    required this.cpmPicStakeholder,
    required this.cpmPicKominfo,
    required this.apgInDok,
  });

  factory APGData.fromJson(Map<String, dynamic> json) {
    return APGData(
      id: json['id_agenda_items_new'],
      apg: json['apg'],
      cpm: json['cpm'],
      cpmChapter: json['cpm_chapter'],
      agendaItem: json['agenda_item'],
      judulAi: json['judul_ai'],
      alokasi: json['alokasi'],
      posisiIndonesia: json['posisi_indonesia'],
      organisasiInternasional: json['organisasi_internasional'],
      picStakeholder: json['pic_stakeholder'],
      picKominfo: json['pic_kominfo'],
      cpmPicStakeholder: json['cpm_pic_stakeholder'],
      cpmPicKominfo: json['cpm_pic_kominfo'],
      apgInDok: (json['apg_ai_in_dok'] as List<dynamic>?)
              ?.map((item) => (item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class APGAiInDokData {
  final String? id;
  final String? agendaItemsNewId;
  final String? title;
  final String? link;
  final String? source;
  final String? tanggal;
  final String? resume;

  APGAiInDokData({
    this.id,
    this.agendaItemsNewId,
    this.title,
    this.link,
    this.source,
    this.tanggal,
    this.resume,
  });

  factory APGAiInDokData.fromJson(Map<String, dynamic> json) {
    return APGAiInDokData(
      id: json['id_apg_ai_new_in_dok'],
      agendaItemsNewId: json['id_agenda_items_new'],
      title: json['apg_ai_new_in_dok_title'],
      link: json['apg_ai_new_in_dok_link'],
      source: json['apg_ai_new_in_dok_source'],
      tanggal: json['apg_ai_new_in_dok_tanggal'],
      resume: json['apg_ai_new_in_dok_resume'],
    );
  }
}

List<APGAiInDokData> convertToAPGAiInDokDataList(
    List<Map<String, dynamic>> data) {
  return data.map((item) => APGAiInDokData.fromJson(item)).toList();
}
