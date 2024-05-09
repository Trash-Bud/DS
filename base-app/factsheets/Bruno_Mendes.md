# Factsheet for Bruno Mendes

## Sprint 0

Alongside team 2, I contributed to the user stories to be implemented for the catalog-related micro-services. I was responsible for the writeup, acceptance tests and mockups of [#1](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/1) and [#2](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/2).

I was the driver for the group programming session some of the developers participated in for setting up the frontend and backend templates for later usage in the soon to be micro-services. We also had the time to setup the linting and testing pipeline using `GitHub Actions`. This work was put in a template repository, and can be seen in PRs [#1](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/microservice-template/pull/1) and [#2](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/microservice-template/pull/2).


### The two user stories that I am most proud of

 * [#1](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/1) - the products list filtering in the admin's shoes.
 * [#2](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/2) - the products list filtering in a brand's shoes.


### The two pull requests that I am most proud of

 * [#1](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/microservice-template/pull/1) - the `AspNet` backend boilerplate and related GH actions.
 * [#2](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/microservice-template/pull/2) - the `Flutter` frontend boilerplate and related GH actions.


### Two other contributions that I am especially proud of

I took initiative in the discussions with the rest of the class about the tech stack to use and the overall architecture of the project. This led to the decision to use `SQLite` as a easy-to-use out of the box DBMS.

I also investigated the use of Docker for the chosen tech stack, which should greatly contribute to a consistent developer experience across machines and a future setup of automatic deployments in platforms such as `Netlify` and/or `Microsoft Azure`.


## Sprint 1

Alongside the rest of team 2, I helped to refine and clarify the user stories of the catalog micro-service, with the new information that came from the PO in the meantime.

In terms of development, I started working on [#16](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/16) shortly after [Victor Nunes](./Victor_Nunes.md) finished working on an initial design with mock data. I refactored the code into multiple files and classes, to prepare for the usage of the `MVC` architecture that I was able to make a reality later on.

After [Catarina Pires](./Catarina_Pires.md) and [Diogo Costa](./Diogo_Costa.md) finished their work on [#14](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/14) (which I also got the opportunity to review, identifying the need for staged migrations for database consistency across multiple machines), I was able to get actual data from the backend, which was the end of my journey with the issue, storing the data with `provider`.

Later in the sprint, I have reviewed [Henrique Nunes'](./Henrique_Nunes.md) [#33](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/33), which made the insertion of a new product possible. I collaborated on the team group session aimed at merging his work with mine, in the frontend. I managed to solve some issues related to widget overflows and forced a refresh of the products list when a new product is added with success ("dispatching" a `provider` action).

### The two user stories that I am most proud of

 * [#9](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/9) - the backend and frontend for the products listing.
 * [#7](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/2) - the backend and frontend for inserting a new product into the catalog.

### The two pull requests that I am most proud of

 * [#32](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/microservice-template/pull/32) - the frontend for the products list.
 * [#33](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/microservice-template/pull/33) - the frontend and backend for the product insertion.

### Two other contributions that I am especially proud of

As stated above, I am proud of the participation in the work of the rest of the team, which already lead to a cohesive result on the first sprint. Pushing an interesting methodology for handling state on a larger scale like `provider` is also something I was really keen into.


## Sprint 2

In sprint 2, the whole class adopted better practices, when it comes to testing, and developed a bunch of new functionality. In team 2, we focused on the switch from products to products/variants, as requested by the PO, and continued the implementation of CRUD operations on the latter.

I was involved in the frontend refactor for the `Add Variant` feature ([#65](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/65)), which was possible after improving the field validation and testing it properly ([#59](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/59)).

Later in the sprint, I have reviewed some of my team mates' work, namely the breaking backend changes, which affected my frontend work. I participated in the discussion of the best architectural decisions throughout the sprint, too.

### The two user stories that I am most proud of

 * [#45](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/9) - the backend and frontend for inserting a variant to an existing product.
 * [#46](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/2) - the backend and frontend for inserting a new variant to a non existing product.

### The two pull requests that I am most proud of

 * [#65](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/microservice-template/pull/65) - the `Add Variant` form refactor for accomodating the new Product/Variant separation.
 * [#59](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/microservice-template/pull/59) - the `Add Variant` form validation.

### Two other contributions that I am especially proud of

I pointed to the need of emulating HTTP requests in frontend tests, for more integrated testing. For that purpose, the ([`nock`](https://pub.dev/packages/nock)) was added to the development dependencies.

I helped my colleague [Rui Alves](../factsheets/Rui_Alves.md) to join our team's work, by reviewing his PRs and helping him to understand the codebase.


## Sprint 3

In sprint 3, we had less time to work on the project, due to the deliveries for other course units. I was able to review the work of my team mates, and help them to improve their code, as well as the overall architecture of the project.

In terms of development, I have implemented the pagination for the variants' list. This was a bit more challenging than expected, due to the fact that some widgets' state was not being updated properly (for example, hovering the variants' rows would always trigger a widget rerender, even if the row's color did not need to change); in some cases, this led to an unnecessary call to a `provider` action and thus the backend. I managed to solve this issue by pulling up the variants fetch action to the startup of the application, and only calling it again when the user changes the page. I also extracted the variants' list to a separate widget, to make the code more readable.

I also added some responsiveness to the application, by making the `Add Variant` form's toggle buttons responsive.

### The two user stories that I am most proud of

 * [#66](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/9) - the backend and frontend for the variants' pagination.
 * [#112](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/112) - the responsiveness of the `Add Variant` form.

### The two pull requests that I am most proud of

 * [#98](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/98) - I implemented the variants' pagination.
 * [#71](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/71) - I reviewed the Inbound's microfrontend refactor, requesting code changes related to the `provider` usage.

### Two other contributions that I am especially proud of

I discussed alongside the Inbound's team the architecture of the design system package, namely which components of the catalog to include in it and how to modify and generalize them to fit to their use case.

I tried to review the work of my team mates as much as possible, and helped them to understand some technical concepts, such as the `provider` usage or `flutter` testing details.

<!-- >
## Sprint 4

...


## Overall Product

Reflect on your specific contributions to the product as perceived by a user and, in particular, on the three categories below (see Dashboard > Final result > Product).


### Technical Soundness

...


### Product Realization

...


### Value for the Client

...
