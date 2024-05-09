# Factsheet for Team 4

## Sprint 0

The team was responsible for creating the User Stories of the Brand Configurations and Data as well as the work items about the microservice template.

### The four user stories that we are most proud of

 * [As an admin, I want to change a brand's policies for e-fulfilment so that it matches their preferences.](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/brand-configs/issues/2)
 * [As an admin, I want to change the warehouses that store a brand's products so that the brand's customers have a better delivery experience.](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/brand-configs/issues/3)
 * [As an admin, I want to search for a brand so that I can see and edit their settings.](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/brand-configs/issues/6)
 * [As a brand, I want to check my configurations so that I can be informed on how my fulfilments will be processed.](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/brand-configs/issues/7)


### The four pull requests that we are most proud of

No PRs were made during this sprint.

### Four other contributions that we are especially proud of

Along with the User Stories created by the team, we are also proud of helping on defining the whole structure of the project and on its division along the teams.

## Sprint 1

The team was responsible for doing the setup of the Kafka system.
We also were responsible for integrate Kafka with Inbound, by sending a ReceptionCreated message [#13](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/13) and for receiving a ReceptionReceived message [#14](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/14), which was not possible due to lack of material and user stories being crude - no mockups, or tasks, or effort estimation, or any detail whatsoever on how to proceed, and heavily dependent on other issues not planned for this sprint.

We also were responsible to deploy both versions that are in the main and develop branches into two different links.

### The four user stories that we are most proud of

Despite not finishing any user story, we established a very solid codebase for Kafka development on the backend, as well as frontend-backend communication to generate messages and deploy automatically both main and develop versions, which is essential to further developments.

### The four pull requests that we are most proud of

We took part in these PRs:
 * #24 [Setup Kafka](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/24)
 * #9 [Docker Files for development and production](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/microservice-template/pull/9)
 * #22 [Automatic deploys on push to main and develop](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/base-app/pull/22)


### Four other contributions that we are especially proud of
- The team made a substantial effort to deliver the planned items with quality so they can be scalable, specifically the Kafka to be used by all the microservices,
and to communicate with the team that defined the user stories to be implemented by us.
- Collaboration with the other teams, specifically the one working on the Inbound.
- Collaboration time and support among team members.
- Automatic deployment of main and develop branches code into two different links

## Sprint 2

The team was responsible for the integration of Kafka with the [Inboud](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound).
Unfortunately, that was not possible, and what was planned to be done on this sprint was not accomplished.

Despite of that, the team worked around that and decided to be agile and work both in the frontend display and backend management of the other microservices ([Inboud](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound) and [Catalog](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog)).

Along with this, the team also did a good work on deploying the base app and improve dockerfiles, leading to a faster and easier development.


### The four user stories that we are most proud of

- #10 [As a user, I want to cancel an ASN, so that I can stop it in case I need to](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/10)
- #3 [Edit Product](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/3)
- 
- 

### The four pull requests that we are most proud of

- #44 [Add automatic deploys to brand configs repository](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/brand-configs/pull/44)
- #57 [Cancel ASN](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/57)
- #3 [Edit Product](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/63)
- 

### Four other contributions that we are especially proud of

- Creation of a free instance of kafka due to our try in setting up kafka with the inbound microservice
- Collaboration with the other teams, specifically the ones working on [Inboud](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound) and [Catalog](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog) microservices.
- Collaboration time and support among team members.
- 


## Sprint 3

The team was responsible for the development of the Kafka Service and its respective Producers and Consumers.
The main focus was on creating a ReceptionCreated message and sending it to a Kafka Topic, and receiving a ReceptionReceived message
from a Kafka Topic.

Generic message sending and capturing were achieved successfully with great results. It was not possible to integrate the production and reception of those  specific messages (ReceptionCreated/ReceptionReceived) due to inconsistencies on the models provided by the PO, which are to be scrapped and replaced by the current Models used on the backend of [Inbound](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound).

Along with this, the team was responsible for the migration of the database to postgres.

### The four user stories that we are most proud of

- #14 [As an administrator of the service, I want to receive a ReceptionReceived message in KAFKA](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/14)
- #13 [As a user, I want the warehouse to be informed of a new ASN via Kafka, so that they can receive it](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/13)
- 
- 

### The four pull requests that we are most proud of

- #85 [Create and send ReceptionCreated message on Kafka Topic](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/85)
- #81 [Create ReceptionReceived Model](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/81)
- #74 [Create Kafka Boilerplate](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/74)
- #73 [Add Postgres Database Support](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/73)


### Four other contributions that we are especially proud of

- Collaboration time and support among teams and team members
- Migration of database to postgres on all microservices
- Extensive message modeling
- 


...


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
