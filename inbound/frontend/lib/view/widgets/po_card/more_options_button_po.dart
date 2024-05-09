import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/controller/provider/purchase_order_change_notifier.dart';
import 'package:frontend/model/page_state.dart';
import 'package:frontend/model/entities/purchase_order.dart';
import 'package:frontend/model/po_status.dart';
import 'package:frontend/view/widgets/create_overlay/edit_po_form.dart';

import 'package:frontend/view/widgets/pop_up.dart';

enum Menu { edit, cancel, archive }

Future<void> _cancelPO(id, context) async {
  final model =
      Provider.of<PurchaseOrderChangeNotifier>(context, listen: false);
  await model.cancelPurchaseOrder(id);

  SnackBar snackBar =
      CustomSnackBarLoaded(context, "Successfully cancelled purchase order");

  if (model.mainPageRequestSate == PageState.error) {
    snackBar = CustomSnackBarError(
        context, "Failed to cancel purchase order: ${model.errorMessage}");
  }
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Future<void> _archivePO(id, context) async {
  var model = Provider.of<PurchaseOrderChangeNotifier>(context, listen: false);
  await model.archivePurchaseOrder(id);
  SnackBar snackBar =
      CustomSnackBarLoaded(context, "Successfully archived purchase order");

  if (model.mainPageRequestSate == PageState.error) {
    snackBar = CustomSnackBarError(
        context, "Failed to archive purchase order: ${model.errorMessage}");
  }
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

class MoreOptionsButton extends StatelessWidget {
  final PurchaseOrder po;

  const MoreOptionsButton(this.po, {super.key});

  @override
  Widget build(BuildContext context) {
    bool archivedButtonEnabled = (po.status != PoStatus.archived);
    bool cancelButtonEnabled =
        (po.status != PoStatus.cancelled && po.status != PoStatus.archived);

    return PopupMenuButton<Menu>(
        onSelected: (Menu item) => {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) {
                    switch (item) {
                      case (Menu.edit):
                        return editPopUp(context);
                      case (Menu.cancel):
                        return cancelPopUp(context);
                      case (Menu.archive):
                        return archivePopUp(context);
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
                      color: cancelButtonEnabled ? Colors.black : Colors.black.withOpacity(0.5)
                    ),
                  ),
                ]),
              ),
              PopupMenuItem<Menu>(
                enabled: archivedButtonEnabled,
                value: Menu.archive,
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    'Archive',
                    style: TextStyle(
                      color: archivedButtonEnabled
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
                    'Cancel PO',
                    style: TextStyle(
                      color: cancelButtonEnabled
                          ? Colors.red
                          : Colors.red.withOpacity(0.5),
                    ),
                  ),
                ]),
              )
            ]);
  }

  Future<void> onPressedCancelPO(context) async {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(CustomSnackBarLoading(context));
    _cancelPO(po.id, context);
  }

  Future<void> onPressedEditPO(context) async {
    Navigator.pop(context);
    TitledOverlay.showTitledOverlay(
        context,
        "Edit Purchase Order ${po.poIdentification}",
        EditPoForm(purchaseOrder: po)
    );
  }

  Future<void> onPressedArchivePO(context) async {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(CustomSnackBarLoading(context));
    _archivePO(po.id, context);
  }


  editPopUp(BuildContext context) {
    return PopUp(
        title: "Edit Purchase Order?",
        content: "Editing the Purchase Order ${po.poIdentification} might change its values",
        positiveMessage: 'Yes, edit the PO',
        negativeMessage: 'No, don\'t edit the PO',
        onPressed: onPressedEditPO);
  }

  cancelPopUp(BuildContext context) {
    return PopUp(
        title: "Cancel Purchase Order?",
        content: 'The cancellation of the Purchase Order ${po.poIdentification} will cancel all the associated products and ASNs',
        positiveMessage: 'Yes, cancel the PO',
        negativeMessage: 'No, don\'t cancel the PO',
        onPressed: onPressedCancelPO);
  }

  archivePopUp(BuildContext context) {
    return PopUp(
        title: 'Archive Purchase Order?',
        content: 'Archiving the Purchase Order ${po.poIdentification} will make the associated products and ASNs unavailable',
        positiveMessage: 'Yes, archive the PO',
        negativeMessage: 'No, don\'t archive the PO',
        onPressed: onPressedArchivePO);
  }

  // Will probably need to be extracted since it will be needed in the asn more options button

}
