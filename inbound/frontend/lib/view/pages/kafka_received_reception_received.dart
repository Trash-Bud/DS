import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/controller/repository/network.dart';
import 'package:frontend/model/entities/reception_created.dart';

class KafkaReceivedReceptionReceived extends StatefulWidget {
  const KafkaReceivedReceptionReceived({super.key});

  @override
  State<KafkaReceivedReceptionReceived> createState() =>
      _KafkaReceivedReceptionReceivedState();
}

class _KafkaReceivedReceptionReceivedState
    extends State<KafkaReceivedReceptionReceived> {
  List allItemsReceived = [];

  Future<List> getKafkaReceivedData() async {
    Network requestController = Network();
    final queryParams = <String, String>{};
    var body = await requestController.get("kafka/receptions-received",
        queryParams: queryParams);

    var list = jsonDecode(body);
    for (var item in list) {
      allItemsReceived.add(ReceptionCreated.fromJson(item));
    }

    return allItemsReceived;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo')),
      body: FutureBuilder(
        future: getKafkaReceivedData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(
                        'Reception Reference: ${snapshot.data![index].id}'),
                    subtitle: Row(
                      children: [
                        Title(
                            color: Colors.black,
                            child: const Text('ASN Details: ',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        const SizedBox(width: 10),
                        Text('Reference: ${snapshot.data![index].asn.id}'),
                        const SizedBox(width: 5),
                        Text('State: ${snapshot.data![index].asn.status}'),
                        const SizedBox(width: 5),
                        Text(
                            'Shipment Reference: ${snapshot.data![index].asn.shippingReference}'),
                        const SizedBox(width: 5),
                        Text(
                            'Warehouse: ${snapshot.data![index].asn.warehouse}'),
                        const SizedBox(width: 5),
                        Text(
                            'Delivery Date: ${snapshot.data![index].asn.deliveryDate}'),
                        const SizedBox(width: 5),
                        Text(
                            'PO Identification: ${snapshot.data![index].asn.poIdentification}'),
                      ],
                    ));
              },
            );
          } else if (snapshot.hasError) {
            throw 'Error Loading';
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
