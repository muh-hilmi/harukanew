import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AWG extends GetxController {
  var agendaItems = <AWGData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http
          .get(Uri.parse('https://haruka2022.com/api_controller/get_awg_data'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];

        agendaItems.assignAll(data.map((item) => AWGData.fromJson(item)));
        print(agendaItems[1].topik);
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
      awgInDok: List<Map<String, dynamic>>.from(json['awg_in_dok'] ?? []),
      awgHasilDok: List<Map<String, dynamic>>.from(json['awg_hasil_dok'] ?? []),
      awgRelDok: List<Map<String, dynamic>>.from(json['awg_rel_dok'] ?? []),
      awgMainHasilPertemuan: List<Map<String, dynamic>>.from(
          json['awg_main_hasil_pertemuan'] ?? []),
    );
  }
}
