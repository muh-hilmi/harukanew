import 'package:flutter/material.dart';
import 'package:harukanew/app/data/data_apg.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ApgDetailView extends GetView {
  const ApgDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uid = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail APG'),
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            dataPerItem("Alokasi", uid.alokasi),
            dataPerItem("Agenda Item", uid.agendaItem),
            dataPerItem("Judul AI", uid.judulAi),
            dataPerItem('PIC Kominfo', uid.picKominfo),
            dataPerItem('PIC Stakeholder', uid.picStakeholder),
            dataPerItem('Posisi Indonesia', uid.posisiIndonesia),
            dataPerItem(
                'Organisasi Internasional', uid.organisasiInternasional),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Input Dokumen',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                // Di dalam kelas ApgDetailView
                SfDataGrid(
                  gridLinesVisibility: GridLinesVisibility.both,
                  headerGridLinesVisibility: GridLinesVisibility.both,
                  source: DokumenDataSource(
                      dokumenData: convertToAPGAiInDokDataList(uid.apgInDok)),
                  shrinkWrapRows: true,
                  columns: <GridColumn>[
                    GridColumn(
                      columnWidthMode: ColumnWidthMode.fitByColumnName,
                      columnName: 'title',
                      label: Container(
                        alignment: Alignment.center,
                        child: const Text('Title'),
                      ),
                    ),
                    GridColumn(
                      columnWidthMode: ColumnWidthMode.fitByColumnName,
                      columnName: 'source',
                      label: Container(
                        alignment: Alignment.center,
                        child: const Text('Negara'),
                      ),
                    ),
                    GridColumn(
                      columnWidthMode: ColumnWidthMode.fill,
                      columnName: 'resume',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.centerLeft,
                        child: const Text('Tanggal'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget dataPerItem(String title, String content) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          content.isEmpty ? '-' : content,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 10),
      ],
    ),
  );
}

class DokumenDataSource extends DataGridSource {
  DokumenDataSource({required List<APGAiInDokData> dokumenData}) {
    _dokumenData = dokumenData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'title', value: e.title),
              DataGridCell<String>(columnName: 'link', value: e.link),
              DataGridCell<String>(columnName: 'source', value: e.source),
              DataGridCell<String>(columnName: 'resume', value: e.resume),
            ]))
        .toList();
  }

  List<DataGridRow> _dokumenData = [];

  APGAiInDokData getDataAtRow(int rowIndex) {
    if (rowIndex >= 0 && rowIndex < _dokumenData.length) {
      return APGAiInDokData(
        title: _dokumenData[rowIndex].getCells()[0].value.toString(),
        link: _dokumenData[rowIndex].getCells()[1].value.toString(),
        source: _dokumenData[rowIndex].getCells()[2].value.toString(),
        resume: _dokumenData[rowIndex].getCells()[3].value.toString(),
      );
    } else {
      return APGAiInDokData(); // Atau throw Exception sesuai kebutuhan
    }
  }

  @override
  List<DataGridRow> get rows => _dokumenData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final url = row.getCells()[1].value.toString();
    return DataGridRowAdapter(cells: [
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            launchUrl(Uri.parse(url));
            debugPrint(url);
          },
          child: Text(
            row.getCells()[0].value.toString(),
            style: const TextStyle(decoration: TextDecoration.underline),
          ),
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(row.getCells()[2].value.toString()),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[3].value.toString(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ]);
  }
}
