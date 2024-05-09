# CHANGELOG

<!--
Refer to [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) for guidelines on how to create a good changelog.

Note that the notion of a "changelog" (or of "release notes") is a common practice for projects with well establised releases, but is harder to adopt when using continuous deployment. You may need to adapt the guidelines above if that is your case.
-->

## Inbound [v4.0](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/releases/tag/v4.0) - 15/12/2022

### Changed:
* [Improve the frontend's errors](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/111)
* [Design system integration](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/149)
* [Pagination frontend](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/112)


### Added:
* [Dependabot and CI machine](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/113)
* [Integrate kafka rc](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/122)
* [ASN edit option](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/124)
* [PO edit option](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/123)
* [Import asn from listing](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/136)
* [Asn template file](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/140)
* [Refresh asn](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/135)
* [Add codeclimate config file](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/139)
* [Add ReceptionReceived functionality](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/138)

## Catalog [v3.0](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/releases/tag/v3.0) - 24/11/2022

### Changed:
- [Refactor Brand and supplier](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/86)

### Added:
- [As a brand, I want to see a list of my product variants so that I know which products of my brand Maersk manages.](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/10)
- [As an admin I want the catalog to be paginated so that it scales with the number of variants.](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/66)
- [As an admin, I want to search in the catalog so that I can obtain products according to my information needs.](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/4)
- [As a brand, I want to search in the catalog so that I can obtain products of my brand according to my information needs.](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/6)


## Inbound [v3.0](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/releases/tag/v3.0) - 24/11/2022

### Changed:
- [Restructure some backend requests](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/46)
- [Details page fails to reload when an ASN is booked or cancelled by a user](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/83)

### Added:
- [As a user, I want to book an ASN, so that I can plan its delivery to a warehouse](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/9)
- [As a user, I want to search for ASNs based on parameters, so I can find the one I'm looking for](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/37)
- [As a user, I want to cancel ASNs on its PO page, so that I can cancel it without switching page](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/68)
- [Added coverage metrics](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/62)
- [As a user I want the buttons across micro services to be consistent, so the buttons' functions and hierarchy is easier to understand across micro services](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/design-system/issues/1)
- [As a user, I want to see loading screens, so that I can know if the app is working properly](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/66)

<!-- Sprint 2 -->
## Catalog [v2.0](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/releases/tag/v2.0) - 10/11/2022:
### Changed:
- [Refactor Variant and Product](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/44)
### Added:
- [As a brand, I want to edit my product so that I can change its information.](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/3)
- [As a brand, I want to archive a product of my catalog so that I can keep the catalog up-to-date.](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/5)
- [As a brand, I want to import a list of product variants in a .xlsx file so that I can insert variants in the catalog that are already listed in a template format.](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/8)
- [As a brand, I want to see a list of my product variants so that I know which products of my brand Maersk manages.](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/10)
- [As an admin, I want to see a product variant of the catalog and its properties so that I can see more detailed information about the product variant.](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/11)
- [As a brand, I want to see one of my products variant and its properties so that I can see more detailed information about the product.](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/12)
- [As a brand, I want to insert a new variant to an already existent product in the catalog so that it can be visible in the platform's catalog.](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/45)
- [As a brand, I want to insert a new variant to a non existent product in the catalog so that it can be visible in the platform's catalog.](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/46)

## Inbound [v2.0](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/releases/tag/v2.0) - 10/11/2022
### Changed:
- Refactor Home page to include PO and ASN list
- ASNs are now independent of POs
### Added:
- [As a user, I want to see a list of ASNs, so that I can keep track of the receptions arriving.](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/35)
- [As a user, I want a responsive interface with consistent design, so that I can use it in any device.](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/38)
- [As a user, I want to search for Purchase Orders based on parameters, so I can find the one I'm looking for.](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/36)
- [As a user, I want to be able to archive a specific PO, so that I can remove it from my active orders.](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/7)
- [ASNs can be created independently from Purchase Orders.](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/48)
- [Create a new ASN for a PO, from a CSV file.](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/4)

<!-- Sprint 1 -->
## Base App [v1.0] - 27/10/2022
- [As a User, I want to be able to toggle in between the multiple microservices, so that I may access their services when needed](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/base-app/issues/1)
- [As User, I want to be able to log in so that I have access to the rest of the base app](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/base-app/issues/2)

## Catalog [v1.0](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/releases/tag/v1.0) - 27/10/2022:
### Added:
- [As an admin, I want to see the list of products of the catalog so that I know which products are offered by the brands.](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/9)
- [As a brand, I want to insert a new product in the catalog so that it can be visible in the platform's catalog.](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/7) 

## Inbound [v1.0] - 27/10/2022
- [As a user, I want to see a list of Purchase Orders, so that I can keep track of orders I made](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/1)
- [As a user, I want to create a PO, so that I can manage my order with the supplier](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/2)
- [As a user, I want to cancel a PO, so that I can cancel an order I made](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/5)
- [As a user, I want to see the ASNs of a specific PO, so that I can analyze its status](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/3)
- [As a user, I want to see the details of a specific ASN, so that I can see its information](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/8)

