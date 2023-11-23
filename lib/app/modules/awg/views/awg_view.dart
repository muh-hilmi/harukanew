import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harukanew/app/controllers/page_index_controller.dart';
import 'package:harukanew/app/data/data_awg.dart';
import 'package:harukanew/app/modules/awg/controllers/awg_controller.dart';
import 'package:harukanew/app/routes/app_pages.dart';

class AwgView extends GetView<AwgController> {
  AwgView({Key? key}) : super(key: key);
  final AWG awgController = Get.find<AWG>();
  final pageC = Get.find<PageIndexController>();

  final List<String> dropdownItems = [
    "31",
    "32",
    "33",
    "34",
    "35",
    "36",
    "38",
    "39",
    "40",
  ];

  @override
  Widget build(BuildContext context) {
    String selectedDropdownValue = "31";
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        title: const Text('AWG'),
      ),
      body: Column(
        children: [
          Container(
            height: 70,
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: 'Cari Topik',
                hintStyle: const TextStyle(fontSize: 18, color: Colors.grey),
                filled: true,
                fillColor: Colors.blue[50],
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 18,
                ),
              ),
              // onFieldSubmitted: ((value) {
              //   debugPrint(value);
              //   apgController.search(value);
              // }),
            ),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text(
                  "AWG",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 5),
                DropdownButton<String>(
                  value: selectedDropdownValue,
                  underline: Container(),
                  iconSize: 20,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  ),
                  onChanged: (value) {
                    selectedDropdownValue = value!;
                  },
                  items: dropdownItems.map((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          // Text('APG: ${awgController.agendaItems[3].awg}'),
          Expanded(
            child: Obx(
              () {
                if (awgController.agendaItems.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  // Limit the number of items to 50
                  final itemCount = awgController.agendaItems.length > 50
                      ? 50
                      : awgController.agendaItems.length;

                  return ListView.builder(
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      var item = awgController.agendaItems[index];
                      String limitedText = item.topik!.length > 150
                          ? "${item.topik!.substring(0, 150)}..."
                          : item.topik!;
                      return ListTile(
                        title: Text('AWG: ${item.awg}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('WG: ${item.wg}'),
                            Text('Topik: $limitedText'),
                          ],
                        ),
                        onTap: () => Get.toNamed(
                          Routes.AWG_DETAIL,
                          arguments: item,
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: FloatingNavbar(
        backgroundColor: Colors.blueAccent,
        items: [
          FloatingNavbarItem(icon: Icons.assignment, title: "APG"),
          FloatingNavbarItem(icon: Icons.library_books_rounded, title: "AWG"),
        ],
        currentIndex: pageC.pageIndex.value,
        onTap: (int i) => pageC.changePage(i),
      ),
    );
  }
}
