
import '../model/entities/purchase_order.dart';
import '../model/po_status.dart';

List<PurchaseOrder> mockPOs() {
  return [
    PurchaseOrder(
        id: 8,
        poIdentification: "PO#2020-6136",
        name: "AW1819_Arzella_1",
        supplier: "Arzelland Vintage Store",
        receivedItems: 0,
        totalItems: 300,
        status: PoStatus.open,
        asns: []),
    PurchaseOrder(
        id: 7,
        poIdentification: "PO#2020-6080",
        name: "AW1819_Arzella_1",
        supplier: "Arzelland Vintage Store",
        receivedItems: 0,
        totalItems: 523,
        status: PoStatus.open,
        asns: []),
    PurchaseOrder(
        id: 6,
        poIdentification: "PO#2020-6068",
        name: "AW1819_Arzella_1",
        supplier: "Arzelland Vintage Store",
        receivedItems: 800,
        totalItems: 3100,
        status: PoStatus.inProgress,
        asns: []),
    PurchaseOrder(
        id: 5,
        poIdentification: "PO#2020-5615",
        name: "AW1819_Sorribebe_items",
        supplier: "Arzelland Vintage Store",
        receivedItems: 800,
        totalItems: 1200,
        status: PoStatus.inProgress,
        asns: []),
    PurchaseOrder(
        id: 4,
        poIdentification: "PO#2019-4624",
        name: "AW1819_Elmate_1",
        supplier: "Arzelland Vintage Store",
        receivedItems: 0,
        totalItems: 300,
        status: PoStatus.inProgress,
        asns: []),
    PurchaseOrder(
        id: 3,
        poIdentification: "PO#2019-4818",
        name: "PO_AGILITY_9SET_NZ",
        supplier: "Arzelland Vintage Store",
        receivedItems: 400,
        totalItems: 1200,
        status: PoStatus.inProgress,
        asns: []),
    PurchaseOrder(
        id: 12,
        poIdentification: "PO#2019-4818",
        name: "PO_AGILITY_9SET_NZ",
        supplier: "Arzelland Vintage Store",
        receivedItems: 400,
        totalItems: 1200,
        status: PoStatus.inProgress,
        asns: []),
    PurchaseOrder(
        id: 11,
        poIdentification: "PO#2019-4818",
        name: "PO_AGILITY_9SET_NZ",
        supplier: "Arzelland Vintage Store",
        receivedItems: 400,
        totalItems: 1200,
        status: PoStatus.inProgress,
        asns: []),
  ];
}
