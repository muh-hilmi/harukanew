import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harukanew/app/controllers/page_index_controller.dart';
import 'package:harukanew/app/data/data_apg.dart';
import 'package:harukanew/app/modules/apg/controllers/apg_controller.dart';
import 'package:harukanew/app/routes/app_pages.dart';

class ApgView extends GetView<ApgController> {
  ApgView({super.key});
  final APG apg = Get.find<APG>();
  final pageC = Get.find<PageIndexController>();

  final List<String> dropdownItems = [
    "23-1",
    "23-2",
    "23-3",
    "23-4",
    "23-5",
    "23-6",
    "23-7",
    "23-8",
    "23-9",
  ];

  @override
  Widget build(BuildContext context) {
    String selectedDropdownValue = "23-1";
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        title: const Text('APG'),
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
                hintText: 'Cari Judul AI',
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
              //   apg.search(value);
              // }),
            ),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text(
                  "APG",
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
          Expanded(
            child: apg.isFetchingData.value
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: apg.fetchData,
                    child: Obx(
                      () {
                        if (apg.agendaItems.isEmpty) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          // Limit the number of items to 50
                          final itemCount = apg.agendaItems.length > 50
                              ? 50
                              : apg.agendaItems.length;

                          return ListView.builder(
                            itemCount: itemCount,
                            itemBuilder: (context, index) {
                              var item = apg.agendaItems[index];
                              String limitedText = item.judulAi!.length > 150
                                  ? "${item.judulAi!.substring(0, 150)}..."
                                  : item.judulAi!;
                              return ListTile(
                                title: Text('APG: ${item.apg}'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Agenda Item: ${item.agendaItem}'),
                                    Text('Judul AI: $limitedText'),
                                  ],
                                ),
                                onTap: () => Get.toNamed(
                                  Routes.APG_DETAIL,
                                  arguments: item,
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
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
