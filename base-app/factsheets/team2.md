# Factsheet for Team 2 

## Sprint 0

The team started the sprint by doing research on Maersk and analyzing the initial product proposal. After the conversation with the PO where the main goals were defined, the team made the catalog user stories [#1](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/1) to [#12](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/12) as well as contributed to the creation of the common template repository.

### The four user stories that we are most proud of

 * [#5](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/5) - As a brand, I want to archive a product of my catalog so that I can keep the catalog up-to-date.
 * [#8](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/8) - As a brand, I want to import a list of products in a .xlsx file so that I can insert products in the catalog that are already listed in a template format.
 * [#9](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/9) - As an admin, I want to see the list of products of the catalog so that I know which products are offered by the brands.
 * [#11](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/11) - As an admin, I want to see a product of the catalog and its properties so that I can see more detailed information about the product.

### The four pull requests that we are most proud of

None were made during this sprint.

### Four other contributions that we are especially proud of

The team contributed positively to the discussion on the division of tasks for this project and creation of high level user stories alongside members of other teams in class.

## Sprint 1

The team started the sprint by dividing the user stories into smaller pieces, work items, and assigning them to team members.
We have managed to implement the products listing and insertion in the catalog.
Also updated [backend README](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/blob/develop/backend/README.md) with migrations commands and routes for the API.

### The four user stories that we are most proud of

 * [#1](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/1) - As an admin, I want to filter the catalog so that I can obtain products according to a specific set of properties.
    - Updated Mockups according to new provided information by PO (products properties).
    - Added examples of filter scenarios.
 * [#2](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/2) - As a brand, I want to filter the catalog so that I can obtain products of my brand according to a specific set of properties. 
    - Updated Mockups according to new provided information by PO (products properties).
    - Added examples of filter scenarios.
 * [#45](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/45) As a brand, I want to insert a new variant to an already existent product in the catalog so that it can be visible in the platform's catalog.
    - Done
 * [#9](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/9) - As an admin, I want to see the list of products of the catalog so that I know which products are offered by the brands.
    - Done

### The four pull requests that we are most proud of

 * [#24](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/24) Feature/api product
    - Add product model
    - Add product controller (Get products)
    - Add route to get products (`/products`)
 * [#31](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/31) Fix automatic erased product fields
    - Upon creating an "Add product form", we noticed that the ListView widget made the fields lose their content when scrolling. 
    - Controllers and StatefulWidgets were used to fix this.
 * [#33](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/33) Feature/new product
    - [BE] Post route to add a product (`/products/add`)
    - [FE] Add "Add product form"
    - [FE] Update database when product is added
 * [#34](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/34) Feature/list products
    - [BE] Add product model and controller (get)
    - [FE] Add list of products

### Four other contributions that we are especially proud of

Team contributions:
- Hard conversation via email with the PO requesting the .xlsx products import template.
- Deciding on a common state management tool for the Flutter frontends of all microservices: `provider`.
- Sharing backend knowledge about post requests consuming a JSON body.
- Helping test drive the deployment of the base-app mainly the catalog microservice.

## Sprint 2

In sprint 2, the team adopted better practices, when it comes to testing, time management and thorough code reviews. We focused on the switch from products to products/variants, as requested by the PO, and continued the implementation of CRUD operations on the latter.
We have managed to implement multiple new features which resulted in an excellent improvement and increment to the product which was appreciated by the PO.

We have managed to implement:
   - Variants' detailed page
   - Import list of products via .xlsx
   - Edit Variant/Product
   - Archive Variant

Also a major refactor was made in order to separate variant and product, as mentioned before, which lead to new features requested by the PO which were also implemented in this sprint:
   - Add Variant to an already existent product
   - Add Variant to a non existent product

### The four user stories that we are most proud of

 * [#5](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/5) - As a brand, I want to archive a variant of my catalog so that I can keep the catalog up-to-date.
   - Implemented
 * [#8](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/8) - As a brand, I want to import a list of product variants in a .xlsx file so that I can insert variants in the catalog that are already listed in a template format.
   - Implemented
 * [#11](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/11) - As an admin, I want to see a product variant of the catalog and its properties so that I can see more detailed information about the product variant.
   - Implemented
 * [#66](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/66) - As an admin I want the catalog to be paginated so that it scales with the number of variants.

### The four pull requests that we are most proud of

 * [#57](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/57) - Feature/view product details
 * [#60](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/60) - Refactor BE Product to Product & Variant and add routes to add products and variants
 * [#65](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/65) - Refactor frontend to accomodate for variant concept
 * [#75](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/75) - Feature/archive variant

### Four other contributions that we are especially proud of

Team contributions:
- Hard conversation with the PO discussing refactor of variants and products.
- Helped colleague [Rui Alves](../factsheets/Rui_Alves.md) to join our team's work, by helping him to understand the codebase.
- Set up the backend unit tests to the routes and implement some of the possible ones.
- Hosted team building event with fun activities in order to strengthen bond between teams.


## Sprint 3

In sprint 3, the team focused on the implementation of the search and filter by brand functionality, as well as the pagination of the catalog. We have managed to implement multiple new features which resulted in an excellent improvement and increment to the product which was appreciated by the PO.


### The four user stories that we are most proud of


 * [#112](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/112) - As a user, I want a responsive interface for the edit product/variant popup, so that I can use it in any device with ease.
   - Written
 * [#20](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/design-system/issues/20) - As a user I want the pagination icons across micro services to be consistent, so that the design is easier to understand.
   - Written
 * [#9](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/design-system/issues/9) - As a user I want the Data Tables across micro services to be consistent, so that the design is easier to understand.
   - Refined with mockups
 * [#117](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/117) - As a brand, I want to have access only to my variants/products so that my items are not accessed by other brands.
   - Written


### The four pull requests that we are most proud of


 * [#96](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/96) - Feature/supplier not brand
 * [#97](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/97) - Feature/be variant list paginated
 * [#98](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/98) - Feature/variant pagination fe
 * [#103](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/103) - Feature/search products catalog


### Four other contributions that we are especially proud of

- Review of the Inbound frontend refactor;
- Contribution to the design system package to be used across all microservices;
- Discussion with the Inbound team about the implementation of the search and pagination functionalities;
- Contributed to keeping the pace of the project.


<!--- 
## Sprint 4

...

Briefly state what you believe were the team's best contributions to the project during this period. Each of the topics below is mandatory unless otherwise stated. In each of the sections below, it is important that you link to any relevant observable evidence of your work when they exist (e.g., pull requests, specific commits, issues, markdown files) and very briefly explain why you think they are important. State it explicitly when you choose to include an item that you worked on together with other teams, not forgetting to explain what was your team's role in it.


### The four user stories that we are most proud of

This can include user stories that the team has written or refined during the sprint. If it was a refinement, explain what you have added or changed.

 * #1
 * #2


### The four pull requests that we are most proud of

This can include PRs that the team has implemented or reviewed during the sprint.

 * #3
 * #4


### Four other contributions that we are especially proud of

This can be anything that you think worked particularly well and benefited the project as whole, from a hard conversation with the PO that worked out very well, to the adoption of a new framework or library. 
-->

<!-- 
## Overall Product

Reflect on your specific contributions to the product as perceived by a user and, in particular, on the three categories below (see Dashboard > Final result > Product).


### Technical Soundness

...


### Product Realization

...


### Value for the Client

...
-->