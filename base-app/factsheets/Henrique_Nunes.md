# Factsheet for Henrique Nunes

## Sprint 0

Alongside the team 2, I helped create, estimate and assign the [Catalog](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues)'s User Stories, including some of their mockups. Contributed to the creation of the microservice template repository on a mob programming kinda session.


### The two user stories that I am most proud of

Made acceptance tests and created mockups for the following user stories:

 * [#7](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/7) - As a brand, I want to insert a new product in the catalog so that it can be visible in the platform's catalog.
 * [#8](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/8) - As a brand, I want to import a list of products in a .xlsx file so that I can insert products in the catalog that are already listed in a template format.


### The two pull requests that I am most proud of

No pull request was made during the sprint 0.

### Two other contributions that I am especially proud of

- Organization of the Figma sidebar to better manage the mockups with the increase of mockups.
- Creation of some mockups.

---

## Sprint 1

Alongside the team 2, I helped to refine and clarify the user stories of the catalog micro-service, with the new information that came from the PO in the meantime. I implement the insertion of a new product user story ([#7](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/7)) with some help of other members of the team. I also have helped some team members to better understand the technologies that we are using and setting them up. I was always available to help the team members when they need it more ([#21](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/21)) as well as for beeing helped by them ([#29](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/29)).

### The two user stories that I am most proud of

- [#7](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/7) - As a brand, I want to insert a new product in the catalog so that it can be visible in the platform's catalog.
  - Define the product properties to be implemented 
  - Split US in work items
- [#8](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/8) - As a brand, I want to import a list of products in a .xlsx file so that I can insert products in the catalog that are already listed in a template format.
  - Split US in work items


### The two pull requests that I am most proud of

- [#33](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/33) - Feature/new product 
  - This is the PR that closes the US [#7](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/7) and consists on the implementation of the backend and frontend that allows a user to insert a new product on the Database. The backend allows to make a post request with a json body with the new product properties and add the product to the Database. The frontend allows to take this action from a nice form with 30 fields (the fields requested by the PO)
- [#20](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/20) - Add Product UI
  - This PR is the implementation of a part of the PR [#33](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/33) that opens a form to insert a new product on catalog. With the improvement applied in PR [#30](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/30) this feature becomes very useful since it could actually something happening in the App.

### Two other contributions that I am especially proud of

- Help teamates installing flutter and android sdk without Android Studio, as well as help them using the technologies required (git, flutter, docker, etc.)
- Ask for untrack .env file from the repository

---

## Sprint 2

Alongside with [Victor](https://github.com/victorsnunes), I implement the detailed view of a product user story ([#11](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/11) and [#12](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/11)). I also identified that [António](https://github.com/Antjcmiranda) and [Flávio](https://github.com/wolfCuanhamaRWS) were having dificulties implementing the US [#8](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/8) (more specifically the work item [#21](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/21) since I implemented the rest of the US [#22](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/22) and [#71](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/71)) so I decided to help them by first trying to guide them and then by implementing it under their supervision (pair programming without changing the driver). In addition, I welcomed [Rui](https://github.com/ruialves35), that because of Kafka problems decided to give us a hand, and introduced him to the catalog microservice. I also implemented the Unit Tests for the Backend for this sprint ([#85](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/85)).

### The two user stories that I am most proud of

The implementation of the follow US:

- [#8](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/8) - As a brand, I want to import a list of products in a .xlsx file so that I can insert products in the catalog that are already listed in a template format.
- [#11](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/11) - As an admin, I want to see a product variant of the catalog and its properties so that I can see more detailed information about the product variant.


### The two pull requests that I am most proud of

- [#71](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/70) - Feature/import-xlsx
  - This PR involved the understanding of some unusual concepts on this project until that time like multipart post requests, request to the backend to download a file and even the challenge of dealing with teammates with some difficulties on the task.
- [#57](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/57) - feature/view-product-details
  - This PR was important in order to add interest to the app by being able to see the details of the products.

### Two other contributions that I am especially proud of

- Identify a PR ([#64](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/64)) that was merged in `develop` when it should't because it was adding complexity to the DB and the overall microservice (some features had to be modified in order to follow this change and to be considered done) by assuming unclear things. I then contributed to the discussion around this issue and after the PO meeting it became clear that we shouldn't have done it (a supplier is not a brand! 😆).
- Set up the backend unit tests to the routes and implement some of the possible ones ([#85](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/85)).


## Sprint 3

I focused this sprint on adding a simulation of an authentication so that other USs could use this feature to be completed. I have also helped debugging and fixing other issues.

### The two user stories that I am most proud of

I contributed to the conclusion of the follow USs:

- [#10](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/10)
- [#6](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/6)


### The two pull requests that I am most proud of

- [#96](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/96) - Feature/supplier not brand
- [#102](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/102) - Fix imported template empty cells recognition

### Two other contributions that I am especially proud of

- I have reviewed almost every PR made in this sprint and I was always available to help my teamates in the US asigned to them when they needed or have requested any help to solve some issues (e.g. [64f1dd](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/107/commits/64f1dd15438b92584115d635014caa33daf23a8e), [7a036](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/98/commits/7a036a377d085d668e8c77fe3f49b90f32fa1f7d), ...).
- Change the actions to run on self-hosted runners and offer my pc as a local runner to run pipelines before release.

<!--
## Sprint 4

...


## Overall Product

...
-->
<!-- Reflect on your specific contributions to the product as perceived by a user and, in particular, on the three categories below (see Dashboard > Final result > Product).-->

<!--
### Technical Soundness

...


### Product Realization

...


### Value for the Client

...
-->
