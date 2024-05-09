import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:frontend/controller/provider/purchase_order_change_notifier.dart';
import 'package:frontend/model/entities/asn.dart';
import 'package:frontend/model/entities/purchase_order.dart';


navigateToDetails(BuildContext context, Asn asn) async {
  final poModel =
  Provider.of<PurchaseOrderChangeNotifier>(context, listen: false);
  if (asn.poIdentification == null) {
    _navigate(context,asn);
    return;
  }
  final searchPo =
  poModel.purchaseOrders.where((po) => po.id == asn.poIdentification);
  if (searchPo.isNotEmpty) {
    _navigate(context,asn,po: searchPo.first);
    return;
  }else{
    await poModel.getPurchaseOrderById(asn.poIdentification!).then( (po) {
      _navigate(context,asn,po: po);
      return;
    }
    );
  }
}

_navigate(BuildContext context,Asn asn, {PurchaseOrder? po}){
  if (po == null){
    Navigator.pushNamed(context, "/asn", arguments: asn);
  }else{
    var index = po.getAsns().indexWhere((foundAsn) => foundAsn == asn);
    Navigator.pushNamed(context, "/purchase-order",
        arguments: [po, index]);
  }
}