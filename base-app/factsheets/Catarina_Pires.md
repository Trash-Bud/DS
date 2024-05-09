# Factsheet for Catarina Pires

## Sprint 0

Along with the rest of team 2, I helped create the user stories for the catalog portion of the project. \
Contributed to the creation of the common template repository and wrote Product Vision. \
Also created the mockups for the base app (mockup with sidebar according to MAERSK examples) with the help of other members on figma.

### The two user stories that I am most proud of

Made acceptance tests and created mockups for the following user stories:

 * [#9](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/9) - As an admin, I want to see the list of products of the catalog so that I know which products are offered by the brands.
 * [#10](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/10) - As a brand, I want to see a list of my products so that I know which products of my brand Maersk manages.

### The two pull requests that I am most proud of

None were made during this sprint.

### Two other contributions that I am especially proud of

Participation in PO's meeting and designed the [domain model](../docs/images/DomainModel.png).

## Sprint 1

Alongside the rest of team 2, I helped to refine and clarify the user stories of the catalog micro-service, with the new information that came from the PO in the meantime.
Along with Bruno Mendes, Diogo Costa and Victor Nunes, I helped implement the produtcs listing (user story [#9](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/9)), mainly the backend (Product model and controller). \
Also updated [Domain Model](../docs/images/DomainModel.png) and contributed in the overall retrospective.   
Regarding the documentation, added 'Security concerns' and 'How to contribute'.

### The two user stories that I am most proud of

 * [#9](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/9) - As an admin, I want to see the list of products of the catalog so that I know which products are offered by the brands.
    - Done
 * [#46](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/46) - As a brand, I want to insert a new variant to a non existent product in the catalog so that it can be visible in the platform's catalog.
    - Added mockups
    - Added acceptance tests

### The two pull requests that I am most proud of

 * [#24](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/24) - Feature/api product
    - Add product model
    - Add product controller (Get products)
    - Add route to get products (`/products`)
 * [#31](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/31) - Fix automatic erased product fields
    - Helped in fixing issue
    - Reviews PR

### Two other contributions that I am especially proud of

- Participated in demo with the PO.
- Helped fixing a frontend bug in the 'Add product' form.

## Sprint 2

Updated frontend text as part of the refactor of variants and products requested by the PO and updated tests accordingly.
Sorted the Variants list by product name in backend as requested by the PO. 
Fully implemented user story [#5](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/5), both frontend and backend.
Helped fixing some bugs both in frontend and backend, alonside with [Henrique](./Henrique_Nunes.md) and [Diogo](./Diogo_Costa.md).
Also updated [Domain Model](../docs/images/DomainModel.png)

### The two user stories that I am most proud of

 * [#5](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/5) - As a brand, I want to archive a variant of my catalog so that I can keep the catalog up-to-date.
 * [#45](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/45) - As a brand, I want to insert a new variant to an already existent product in the catalog so that it can be visible in the platform's catalog. 
   - Improved frontend design

### The two pull requests that I am most proud of

 * [#75](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/75) - Feature/archive variant
   - Added archive button in each variant row
   - Added routes to archive variant
   - Updated API documentation
 * [#83](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/83) - Fix/excel dropdowns
   - Helped in fixing dropdowns (frontend)
   - Fix variant attribute (PrePackedItem) property (backend)

### Two other contributions that I am especially proud of

- Participated in demo with the PO. 
- Became SPO of team 2 due to [Flavio](./Flavio_Vaz.md) incompatibility.
- Improved overall design of the catalog.
- Helped my colleague [Rui Alves](../factsheets/Rui_Alves.md) to join our team's work.
- Reviewed a lot of my peers' code.

## Sprint 3

In Sprint 3, I contributed to the implementation of the search ([#4](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/4) and [#6](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/6)) alonside with [Flávio](Flavio_Vaz.md), especially the integration with the then current version, allowing pagination in the search too. 
Furthermore, contributed to the implementation of the US [#10](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/10) alongside with [Victor](./Victor_Nunes.md), allowing different views on the catalog according to a Brand dropdown (simulating a login). My contribution focused on the backend.


### The two user stories that I am most proud of

 * [#117](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/117) - As a brand, I want to have access only to my variants/products so that my items are not accessed by other brands.
 * [#9](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/design-system/issues/9) - As a user I want the Data Tables across micro services to be consistent, so that the design is easier to understand.
   - Refined with mockups


### The two pull requests that I am most proud of

 * [#103](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/103) - Feature/search products catalog
   - Refactor
   - Merge with current versions (with pagination)
 * [#4](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/107) - Feature/view single brand
   - Added routes to filter by brand
   - Updated API documentation
   - Integration with backend


### Two other contributions that I am especially proud of

- Participated in demo with the PO. 
- Helped updating frontend tests due to some design changes.
- Help my team colleagues in their assigned tasks.
- Reviewed a lot of my peers' code.

<!---
## Sprint 4

...

 
### The two user stories that I am most proud of

This can include user stories that you have written or refined during the sprint. If it was a refinement, explain what you have added or changed.

 * #1
 * #2


### The two pull requests that I am most proud of

This can include PRs that you have implemented or reviewed during the sprint.

 * #3
 * #4


### Two other contributions that I am especially proud of

This can be anything that you think worked particularly well and benefited the project as whole, from a hard conversation with the PO that worked out very well, to the adoption of a new framework or library. 
-->
<!---
## Overall Product

Reflect on your specific contributions to the product as perceived by a user and, in particular, on the three categories below (see Dashboard > Final result > Product).


### Technical Soundness

...


### Product Realization

...


### Value for the Client

...
-->