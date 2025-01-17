// Mocks generated by Mockito 5.3.2 from annotations
// in frontend/test/po_list_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:frontend/controller/repository/asn_repository.dart' as _i5;
import 'package:frontend/controller/repository/purchase_order_repository.dart'
    as _i2;
import 'package:frontend/model/entities/purchase_order.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [PurchaseOrderRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockPurchaseOrderRepository extends _i1.Mock
    implements _i2.PurchaseOrderRepository {
  MockPurchaseOrderRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<Map<String, Object>> getPurchaseOrders({
    String? textQuery = r'',
    String? poState = r'',
    int? offset = -1,
    int? limit = -1,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPurchaseOrders,
          [],
          {
            #textQuery: textQuery,
            #poState: poState,
            #offset: offset,
            #limit: limit,
          },
        ),
        returnValue: _i3.Future<Map<String, Object>>.value(<String, Object>{}),
      ) as _i3.Future<Map<String, Object>>);
  @override
  _i3.Future<_i4.PurchaseOrder?> getPurchaseOrderById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPurchaseOrderById,
          [id],
        ),
        returnValue: _i3.Future<_i4.PurchaseOrder?>.value(),
      ) as _i3.Future<_i4.PurchaseOrder?>);
  @override
  _i3.Future<void> cancelPurchaseOrder(int? id) => (super.noSuchMethod(
        Invocation.method(
          #cancelPurchaseOrder,
          [id],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> archivePurchaseOrder(int? id) => (super.noSuchMethod(
        Invocation.method(
          #archivePurchaseOrder,
          [id],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> downloadPurchaseOrderFile(int? id) => (super.noSuchMethod(
        Invocation.method(
          #downloadPurchaseOrderFile,
          [id],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> createPurchaseOrder(
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #createPurchaseOrder,
          [
            body,
            headers,
          ],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}

/// A class which mocks [AsnRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAsnRepository extends _i1.Mock implements _i5.AsnRepository {
  MockAsnRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<Map<String, Object>> getAsns({
    String? textQuery = r'',
    String? asnState = r'',
    int? offset = -1,
    int? limit = -1,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAsns,
          [],
          {
            #textQuery: textQuery,
            #asnState: asnState,
            #offset: offset,
            #limit: limit,
          },
        ),
        returnValue: _i3.Future<Map<String, Object>>.value(<String, Object>{}),
      ) as _i3.Future<Map<String, Object>>);
  @override
  _i3.Future<void> uploadAsnFile(
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    List<int>? file,
    Map<String, dynamic>? queryParameters,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #uploadAsnFile,
          [
            body,
            headers,
            file,
            queryParameters,
          ],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> downloadAsnFile(int? id) => (super.noSuchMethod(
        Invocation.method(
          #downloadAsnFile,
          [id],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> cancelAsn(int? id) => (super.noSuchMethod(
        Invocation.method(
          #cancelAsn,
          [id],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> bookAsn(int? id) => (super.noSuchMethod(
        Invocation.method(
          #bookAsn,
          [id],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
