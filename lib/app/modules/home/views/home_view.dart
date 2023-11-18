import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harukanew/app/data/data_apg.dart';

class HomeView extends StatelessWidget {
  final APG apgController = Get.find<APG>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AWG'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: 'Cari Judul AI',
                hintStyle: const TextStyle(fontSize: 18, color: Colors.grey),
                filled: true,
                fillColor: Colors.blue[50],
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(50),
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
          Expanded(
            child: Obx(
              () {
                if (apgController.agendaItems.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  // Limit the number of items to 50
                  final itemCount = apgController.agendaItems.length > 50
                      ? 50
                      : apgController.agendaItems.length;

                  return ListView.builder(
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      var item = apgController.agendaItems[index];
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
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
