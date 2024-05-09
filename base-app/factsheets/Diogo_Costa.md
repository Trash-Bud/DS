# Factsheet for Diogo Costa

## Sprint 0

Along with the rest of team 2, I helped create the user stories for the catalog microservice of the project.  
Contributed to the creation of the common template repository.

### The two user stories that I am most proud of

Made acceptance tests and created mockups for the following user stories:

 * [#11](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/11) - As an admin, I want to see a product of the catalog and its properties so that I can see more detailed information about the product.
 * [#12](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/12) - As a brand, I want to see one of my products and its properties so that I can see more detailed information about the product.


### The two pull requests that I am most proud of

None were made during this sprint.


### Two other contributions that I am especially proud of

Designed the initial [domain model](../docs/images/prospective_domain_model.png) which was useful to clarify doubts in the first meeting with the PO.


## Sprint 1

Alongside the rest of team 2, I helped to refine and clarify the user stories of the catalog micro-service,
with the new information that came from the PO in the meantime.

Along with [Bruno Mendes](./Bruno_Mendes.md), [Catarina Pires](./Catarina_Pires.md) and
[Victor Nunes](./Victor_Nunes.md), I helped implement the products listing
(user story [#9](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/9)),
mainly the backend (Product model and controller).

Started working on the backend of the user story [#10](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/10),
defining Brand model and controller and relating it to the Product.

As a scrum master I scheduled a meeting for the sprint retrospective so that the team could reflect
on what went well, what could have gone better, and could be done differently. Also, made an effort
to ensure that everyone on the team had user stories / work items ready for the second sprint.


### The two user stories that I am most proud of

 * [#45](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/45) As a brand, I want to insert a new variant to an already existent product in the catalog so that it can be visible in the platform's catalog.
    - User story enhancement elaborated as a result of feedback from the PO.
 * [#10](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/10) As a brand, I want to see a list of my product variants so that I know which products of my brand Maersk manages.
    - Refined this US as a result of feedback from the PO:
        - product variants instead of products
        - changed mockups


### The two pull requests that I am most proud of

 * [#24](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/24) Feature/api product
 * [#34](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/34) Feature/list products


### Two other contributions that I am especially proud of

- Noticed that we had a problem with duplicated folders Src/src and Test/test which caused
trouble on some OS as they are case insensitive and git could neither add nor restore them:
[#26](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/26).
- Proud to participate on the team development as a team player.


## Sprint 2

This sprint, due to the feedback of the PO from the previous sprint, our team had to adapt both frontend and backend of the catalog microservice to support the duality of products and variants.

Alongside with [Bruno Mendes](../factsheets/Bruno_Mendes.md) and [Catarina Pires](../factsheets/Catarina_Pires.md) I helped making this refactor requested by the PO, namely in the backend.

Helped in QA during code review which detected several bugs introduced on previous features introduced in PRs of other features.

As a scrum master I scheduled a meeting for the sprint retrospective so that the team could reflect on what went well, what could have gone better, and could be done differently. Also, made an effort to ensure that everyone on the team had user stories / work items ready for the third sprint.


### The two user stories that I am most proud of

 * [#66](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/66) As an admin I want the catalog to be paginated so that it scales with the number of variants. 
    - Converted the work item into a user story to properly reflect its importance to the product.
 * [#46](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/46) As a brand, I want to insert a new variant to a non existent product in the catalog so that it can be visible in the platform's catalog.


### The two pull requests that I am most proud of

 * [#60](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/60) Refactor BE Product to Product & Variant and add routes to add products and variants
 * [#64](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/64) Add brand table and endpoints to query and add brands


### Two other contributions that I am especially proud of

Created work items according to the feedback from the PO at the end of the sprint.

Along with the rest of team 2, I welcomed my colleague [Rui Alves](../factsheets/Rui_Alves.md) from [Team 4](../factsheets/team4.md) to join our team's work.


## Sprint 3

Alongside with [Bruno Mendes](../factsheets/Bruno_Mendes.md) I helped to implement the pagination user story [#66](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/66), namely the backend.

Alongside with [Flávio Vaz](../factsheets/Flavio_Vaz.md) I helped to implement the search products/variants user story [#4](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/4), namely the backend.

As a scrum master I scheduled a meeting for the sprint retrospective so that the team could reflect on what went well, what could have gone better, and could be done differently.

### The two user stories that I am most proud of

 * [#20](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/design-system/issues/20) As a user I want the pagination icons across micro services to be consistent, so that the design is easier to understand.
   - Written
 * [#4](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/4) As an admin, I want to search in the catalog so that I can obtain products according to my information needs.


### The two pull requests that I am most proud of

 * [#97](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/97) Add backend endpoint to get the variant list paginated
 * [#101](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/101) Add backend endpoint to search variants and products by field values


### Two other contributions that I am especially proud of

Participated in the sprint review meeting with the PO which made me and the whole team realize how much important the design system is to the product.

Made an effort to ensure every team had a burndown chart of the sprint 3.


<!--
## Sprint 4

...
Briefly state what you believe were your best contributions to the project during this period. Each of the topics below is mandatory unless otherwise stated. In each of the sections below, it is important that you link to any relevant observable evidence of your work when they exist (e.g., pull requests, specific commits, issues, markdown files) and very briefly explain why you think they are important. State it explicitly when you choose to include an item that you worked on together with other people in the projecy, not forgetting to explain what was your specific role in it.


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

## Overall Product

Reflect on your specific contributions to the product as perceived by a user and, in particular, on the three categories below (see Dashboard > Final result > Product).


### Technical Soundness

...


### Product Realization

...


### Value for the Client

...
-->
