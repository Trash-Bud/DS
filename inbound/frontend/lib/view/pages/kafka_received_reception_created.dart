import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/controller/repository/network.dart';
import 'package:frontend/model/entities/reception_created.dart';

class KafkaReceivedReceptionCreated extends StatefulWidget {
  const KafkaReceivedReceptionCreated({super.key});

  @override
  State<KafkaReceivedReceptionCreated> createState() =>
      _KafkaReceivedReceptionCreatedState();
}

class _KafkaReceivedReceptionCreatedState
    extends State<KafkaReceivedReceptionCreated> {
  List allItemsCreated = [];

  Future<List> getKafkaCreatedData() async {
    Network requestController = Network();
    final queryParams = <String, String>{};
    var body = await requestController.get("kafka/receptions-created",
        queryParams: queryParams);

    var list = jsonDecode(body);
    for (var item in list) {
      allItemsCreated.add(ReceptionCreated.fromJson(item));
    }

    return allItemsCreated;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo')),
      body: FutureBuilder(
        future: getKafkaCreatedData(),
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
