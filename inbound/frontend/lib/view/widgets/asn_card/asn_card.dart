import 'package:flutter/material.dart';
import 'package:frontend/view/widgets/asn_card/asn_info_section.dart';
import 'package:frontend/model/entities/asn.dart';
import 'package:frontend/model/asn_status.dart';
import 'package:frontend/view/widgets/asn_card/more_options_button_asn.dart';

class ASNCard {
  final Asn asn;

  ASNCard(this.asn);

  List<Widget> build(BuildContext context) {
    return getDataCells(context);
  }

  List<Widget> getDataCells(context) {
    return [
      ASNInfoSection(asn, context,
          key: Key("ASNInfoSection${asn.shippingReference}")),
      getWarehouseSection(context),
      (getDeliverySection(context)),
      (getCarrierSection(context)),
      (getCargoTypeSection(context)),
      (getPurchaseOrderSection(context)),
      (MoreOptionsButton(asn, key: Key("moreOptionsButton${asn.id}"))),
    ];
  }

  Widget getWarehouseSection(context) {
    return Text(
        key: Key("warehouseName${asn.shippingReference}"),
        textAlign: TextAlign.start,
        asn.warehouse == null ? "No Warehouse" : asn.warehouse!,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
            decoration: asn.status == ASNStatus.cancelled
                ? TextDecoration.lineThrough
                : TextDecoration.none));
  }

  Widget getDeliverySection(context) {
    return Text(
        key: Key("deliveryDate${asn.shippingReference}"),
        textAlign: TextAlign.start,
        asn.deliveryDate == null
            ? "No Delivery Date"
            : asn.deliveryDate.toString(),
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
            decoration: asn.status == ASNStatus.cancelled
                ? TextDecoration.lineThrough
                : TextDecoration.none));
  }

  Widget getCarrierSection(context) {
    return Text(
        key: Key("carrierName${asn.shippingReference}"),
        textAlign: TextAlign.start,
        asn.carrier == null ? "No Carrier" : asn.carrier!,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
            decoration: asn.status == ASNStatus.cancelled
                ? TextDecoration.lineThrough
                : TextDecoration.none));
  }

  Widget getCargoTypeSection(context) {
    return Text(
        key: Key("cargoType${asn.shippingReference}"),
        textAlign: TextAlign.start,
        asn.cargoType == null ? "No Cargo Type" : asn.cargoType!,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
            decoration: asn.status == ASNStatus.cancelled
                ? TextDecoration.lineThrough
                : TextDecoration.none));
  }

  Widget getPurchaseOrderSection(context) {
    return Text(
        key: Key("purchaseOrder${asn.shippingReference}"),
        textAlign: TextAlign.start,
        asn.poName ?? "No PO associated",
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
            decoration: asn.status == ASNStatus.cancelled
                ? TextDecoration.lineThrough
                : TextDecoration.none));
  }

  static TextDecoration strikethroughText(asn) {
    return (asn.status == ASNStatus.cancelled)
        ? TextDecoration.lineThrough
        : TextDecoration.none;
  }
}
