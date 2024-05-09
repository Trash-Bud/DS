import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controller/provider/asn_change_notifier.dart';
import 'package:frontend/controller/provider/purchase_order_change_notifier.dart';
import 'package:frontend/model/asn_status.dart';
import 'package:frontend/model/entities/asn.dart';
import 'package:provider/provider.dart';
import 'package:frontend/model/page_state.dart';
import 'package:frontend/view/widgets/create_overlay/edit_asn_form.dart';
import 'package:frontend/view/widgets/pop_up.dart';

enum Menu { edit, cancel, book }

Future<void> _cancelASN(poID, id, context) async {
  final model = Provider.of<AsnChangeNotifier>(context, listen: false);
  await model.cancelAsn(id);

  if (poID != null) {
    final poModel =
        Provider.of<PurchaseOrderChangeNotifier>(context, listen: false);
    poModel.cancelASNPurchaseOrder(poID, id);
  }

  if (model.mainPageState == PageState.error) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(CustomSnackBarError(
        context, "Failed to cancel ASN: ${model.errorMessage}"));
  }
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackBarLoaded(context, "Successfully cancelled ASN"));
}

Future<void> _bookASN(poID, id, context) async {
  final model = Provider.of<AsnChangeNotifier>(context, listen: false);
  await model.bookAsn(id);

  if (poID != null) {
    final poModel =
        Provider.of<PurchaseOrderChangeNotifier>(context, listen: false);
    poModel.bookASNPurchaseOrder(poID, id);
  }

  if (model.mainPageState == PageState.error) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(CustomSnackBarError(
        context, "Failed to book ASN: ${model.errorMessage}"));
  }
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context)
      .showSnackBar(CustomSnackBarLoaded(context, "Successfully booked ASN"));
}

class MoreOptionsButton extends StatelessWidget {
  final Asn asn;

  const MoreOptionsButton(this.asn, {super.key});

  @override
  Widget build(BuildContext context) {
    bool bookButtonEnabled =
        (asn.status != ASNStatus.cancelled && asn.status != ASNStatus.booked);
    bool cancelButtonEnabled = (asn.status != ASNStatus.cancelled);

    editPopUp(BuildContext context) {
      return PopUp(
          title: "Edit ASN?",
          content:
              "Editing the Advance Shipping Notice ${asn.shippingReference} might change its values",
          positiveMessage: "Yes, edit the ASN",
          negativeMessage: 'No, don\'t edit the ASN',
          onPressed: onPressedEdit);
    }

    cancelPopUp(BuildContext context) {
      return PopUp(
          title: "Cancel ASN?",
          content:
              "The cancellation of the Advance Shipping Notice ${asn.shippingReference} will cancel all the associated products",
          positiveMessage: "Yes, cancel the ASN",
          negativeMessage: "No, don't cancel the ASN",
          onPressed: onPressedCancel);
    }

    bookPopUp(BuildContext context) {
      return PopUp(
          title: "Book ASN?",
          content:
              "Booking the Advance Shipping Notice ${asn.shippingReference} will change its status",
          positiveMessage: "Yes, book the ASN",
          negativeMessage: "No, don't book the ASN",
          onPressed: onPressedBook);
    }

    return PopupMenuButton<Menu>(
        icon: const Icon(Icons.more_vert),
        onSelected: (Menu item) => {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) {
                    switch (item) {
                      case (Menu.edit):
                        return editPopUp(context);
                      case (Menu.cancel):
                        return cancelPopUp(context);
                      case (Menu.book):
                        return bookPopUp(context);
                    }
                  }),
            },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
              PopupMenuItem<Menu>(
                enabled: cancelButtonEnabled,
                value: Menu.edit,
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    'Edit',
                    style: TextStyle(
                      color: cancelButtonEnabled
                          ? Colors.black
                          : Colors.black.withOpacity(0.5),
                    ),
                  ),
                ]),
              ),
              PopupMenuItem<Menu>(
                enabled: cancelButtonEnabled,
                value: Menu.cancel,
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    'Cancel ASN',
                    style: TextStyle(
                      color: (asn.status != ASNStatus.cancelled)
                          ? Colors.red
                          : Colors.red.withOpacity(0.5),
                    ),
                  ),
                ]),
              ),
              PopupMenuItem<Menu>(
                enabled: bookButtonEnabled,
                value: Menu.book,
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    'Book ASN',
                    style: TextStyle(
                      color: (asn.status != ASNStatus.cancelled &&
                              asn.status != ASNStatus.booked)
                          ? Colors.blueAccent
                          : Colors.blueAccent.withOpacity(0.5),
                    ),
                  ),
                ]),
              ),
            ]);
  }

  Future<void> onPressedCancel(context) async {
    ScaffoldMessenger.of(context).showSnackBar(CustomSnackBarLoading(context));
    Navigator.pop(context);
    _cancelASN(asn.poIdentification, asn.id, context);
  }

  Future<void> onPressedEdit(context) async {
    Navigator.pop(context);
    TitledOverlay.showTitledOverlay(
        context, "Edit ASN ${asn.shippingReference}", EditAsnForm(asn: asn));
  }

  Future<void> onPressedBook(context) async {
    ScaffoldMessenger.of(context).showSnackBar(CustomSnackBarLoading(context));
    Navigator.pop(context);
    _bookASN(asn.poIdentification, asn.id, context);
  }
}
