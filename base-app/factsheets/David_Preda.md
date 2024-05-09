# Factsheet for David Preda

## Sprint 0

Along with the rest of team 1 I helped create the user stories for the inboud portion of the project.

### The two user stories that I am most proud of

I made the acceptance tests and chose the mockups for user story:

 * #9 - As a user, I want to book an ASN, so that I can plan its delivery to a warehouse
 * #10 - As a user, I want to cancel an ASN, so that I can stop it in case I need to

### The two pull requests that I am most proud of

None were made during this sprint

### Two other contributions that I am especially proud of

- Helped create the part of the UML related to the inbound.

## Sprint 1

During this sprint, I worked mostly on the [inbound](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound)'s backend. Specifically, I helped create new GET and POST endpoints for the Purchase Orders and the ASNs, and did a lot of the necessary work for those endpoints to come to life. I also reviewed some of my peers's code and helped with other problems that arised.

### The two user stories that I am most proud of

 * #2 [As a user, I want to create a PO, so that I can manage my order with the supplier](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/2)
 * #3 [As a user, I want to see the ASNs of a specific PO, so that I can analyze its status](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/3)


### The two pull requests that I am most proud of

 * #30 [Create purchase orders](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/30).
 * #29 [List ASNs](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/29).
 * #21 [Fix/db in docker](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/21).

### Two other contributions that I am especially proud of

- Helped with fixing the Dockerfile for the database.
- Reviewed some of my peers' code.


## Sprint 2

During this sprint, I worked mostly on the [inbound](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound)'s backend, but I also reviewed some of my peer's code on the frontend. I refactored the part of the backend responsible for the ASNs, to make it compliant with the PO's demands. I also solved a pressing issue with the database, which was not being properly initialized, with the PO's lacking a connection to the ASNs and vice-versa.

Since this database issue was rather tricky to deal with, I created a guide on how to properly connect the database's tables and shared it with my colleagues, which ended up helping [Diogo Costa](../factsheets/Diogo_Costa.md) with his work on the catalog microservice.

### The user storiy that I am most proud of

 * #35 [As a user, I want to see a list of ASNs, so that I can keep track of the receptions arriving](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/35).

### The pull request that I am most proud of
    
* #49 [Update ASN creation to reflect the PO's required changes](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/49).

### Two other contributions that I am especially proud of

I reviewed a lot of my peers' code, which lead to some positive changes on our work. I am also proud of the work we did as a team, since we improved much of our development process, which lead to a substantially more efficient workflow. Contrary to the last sprint, we were able to finish all of our tasks on time, which was a great achievement.

We also implemented more tests, which helped us catch some bugs that we would have otherwise missed, and we also improved our documentation, which helped us understand our code better.

## Sprint 3

During this sprint, I worked mostly on the [inbound](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound)'s backend, but I also reviewed some of my peer's code. I split the product class definition from the ASN class definition on the backend, making the database model cleaner and more elegant. 

I also helped [Rui Alves](../factsheets/Rui_Alves.md), who is, along with team 4, responsible for the Kafka-related part of the project, with some of the problems he was having configuring and updating the database. This lead to us discovering, together, a better way to implement some of the inbound's database, which was a great achievement.

### The work item that I am most proud of

 * #82 [Separate Product from ASN](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/82).

### The pull request that I am most proud of

* #96 [Separe Product definition and related classes from ASN](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/96).
