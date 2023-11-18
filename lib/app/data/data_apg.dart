import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APG extends GetxController {
  var agendaItems = <AgendaItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http
          .get(Uri.parse('https://haruka2022.com/api_controller/get_apg_data'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];

        agendaItems.assignAll(data.map((item) => AgendaItem.fromJson(item)));
        // print(agendaItems[0].alokasi);
      } else {
        throw Exception('Gagal mengambil data dari API');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}

class AgendaItem {
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
  final String? createdAt;
  final String? updatedAt;

  AgendaItem({
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
    required this.createdAt,
    required this.updatedAt,
  });

  factory AgendaItem.fromJson(Map<String, dynamic> json) {
    return AgendaItem(
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
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
