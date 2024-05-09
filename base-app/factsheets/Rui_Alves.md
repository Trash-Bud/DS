# Factsheet for Rui Alves

## Sprint 0

Along with the rest of team 4, I helped create the user stories for the catalog portion of the project. \
Along with the rest of team 4, I helped create work itens for the microservice-template.
Along with other members of the project, I helped on the designing of the architecture of the system.

### The two user stories that I am most proud of

 * [#7](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/brand-configs/issues/7)

Although this User Stories was created by member of team 4, I'm also proud of contributing to its creation:
 * [#3](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/brand-configs/issues/3)


### The two pull requests that I am most proud of

None were made during this sprint.

### Two other contributions that I am especially proud of

Helping with the configuration of some linting/formatting properties to be used by all the teams on the project.

## Sprint 1

In this sprint, I worked mostly on exploring Kafka and how we could implement it in our system, making its respective setup. 
Along with some colleagues in my team (team 4), I managed to find a structured architecture so Kafka could be used in all the microservices of the application. 
I was also responsible for integrating Kafka with inbound, although this was not possible due to lack of information and high dependencies on unplanned features.
I also helped them with some trouble they faced and tried to follow the progress of the team.
Finally, I did the sprint planning and retrospective with some of the colleagues of team 4 and updated all of the required documents, factsheets needed, and User Stories for the next Sprint.

### The two user stories that I am most proud of
Since the work consisted mostly on setup of Kafka and testing it, I could not finish any User Storie on this sprint.

### The two pull requests that I am most proud of

The two pull requests that I am most proud of are the following:
- #24 [Setup Kafka](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/24)

### Two other contributions that I am especially proud of

Setup the dockerfile for the Kafka deployment and refinement of the user stories for the next sprint, as well as helping some teammates on configuring their repositories.


## Sprint 2

In this sprint, I worked mostly on exploring Kafka and how we could implement it in our system, making its respective setup.
Unfortunately, this was not accomplished and we could not integrate the Kafka with [Inbound](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound) microservice.
Due to that, I decided to help other teams with their work, in order to increment the development of the product. 
This way, I "joined" team 2 and helped them with the development of the [Catalog](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog).
I also helped them with some trouble they faced and tried to follow the progress of the team.

Finally, I did the sprint planning and retrospective with some of the colleagues of team 4 and updated all of the required documents, factsheets needed, and User Stories for the next Sprint.

### The two user stories that I am most proud of

- #3 [Edit Product](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/issues/3)

### The two pull requests that I am most proud of

- #3 [Edit Product](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/63)
  - Extend Add Product view to add variant and edit both product and variant
  - Add route to product controler to edit a product (`/product/{productId}`)
  - Add route to variant controler to edit a variant (`/variant/{variantId}`)



### Two other contributions that I am especially proud of

Refinement of the user stories for the next sprint, as well as helping other teams with tasks and US of other 
projects (most specifically [Catalog](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog))


## Sprint 3

In this sprint, along with team 4, I worked mostly on Kafka.
Implemented it by creating the Model of the Reception Created and its respective controllers/listeners in 
order to show that Kafka system it's working.

I also helped with the setup of the kafka service and postgres.

Unfortunately, could not implement this feature directly in the [Inbound](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound) microservice
since we didn't have the required information from the PO on should the kafka payload be sent.

I also implemented tests for Kafka and helped other teams with configurations to be able to use kafka
and postgres on their backend.

Finally, I did the sprint planning and retrospective with some of the colleagues of team 4 and updated all of the required documents, factsheets needed, and User Stories for the next Sprint and added the docs for the kafka endpoints.

### The two user stories that I am most proud of

- 

### The two pull requests that I am most proud of

- #85 [Kafka Reception Created](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/85)
  - Created Reception Created Models
  - Created Kafka Reception Created endpoints on Controller to receive a post
  - Added kafka topic to reception created messages
  - Sending a kafka message when received the post in endpoint kafka/reception-created
  - Receiving the Reception Created message in a kafka consumer and storing them in database
  - Returning all the Reception Created messages sent until moment


### Two other contributions that I am especially proud of

Refinement of the user stories for the next sprint, as well as helping other teams with some tasks 
and configurations. 


## Sprint 4

In this sprint, along with team 4, I worked mostly on Kafka.

We changed the Reception Created and Reception Received Models to use the [Inbound](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound) 
Models that already existed (ASN), according to the information provided from PO.

I also implemented tests for Kafka and helped other teams with configurations to be able to use kafka
and postgres on their backend.

Finally, I did the sprint planning and retrospective with some of the colleagues of team 4 and updated all of the required documents, factsheets needed, and added the docs for the kafka endpoints.

### The two user stories that I am most proud of

- #101 [Create Reception Created message](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/101)

### The two pull requests that I am most proud of

- #122 [Integrate Kafka Reception Created](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/122)
  - Changed Reception Created Models
  - Integrate Kafka with frontend when booking a ASN
  - Send Reception Created Message
  - Receive Message on Consumer
  - Show the messages in Frontend
  - Create tests


### Two other contributions that I am especially proud of

Help other teammates with configurations of postgres database and kafka.

## Overall Product

I was active throughout this project, developing features both for inbound and catalog. Mainly, I focused in seting up Kafka to be used across all microservices,
its integration in [Inbound](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound), where it's used to send a message when an ASN is booked or to receive
messages from an external service to update the state of the respective ASN.

In [Catalog](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog) I worked mostly on the feature of editing a product.

Besides this direct features/User stories, I always helped my teammates with configurations, such as kafka and databases, and helped Migrate the database
from sqlite to Postgres.

### Technical Soundness
...

### Product Realization
...

### Value for the Client
...
