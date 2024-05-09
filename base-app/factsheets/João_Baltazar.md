# Factsheet for João Baltazar

## Sprint 0

In preparation for the meeting with the PO, I helped prepare the questions and strategy to be followed by the teams, as well as research and share useful information about the project context, the client, and technologies to be used.
Furthermore, I accompanied and took an active role in the creation of the user stories alongside Team 4 members, namely, transforming the requirements discussed with the PO into user stories, and ensuring their correctness.


### The two user stories that I am most proud of

My contributions were predominantly done jointly with my teammates on a collaborative text editor that I set up to discuss and refine the user stories, but there are some evidences here as well.

 * [Changing the warehouse preferences](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/brand-configs/issues/3)
 * [Changing fulfillment and return policies](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/brand-configs/issues/2)


### The two pull requests that I am most proud of

None were made during this sprint.

### Two other contributions that I am especially proud of

 * I helped set up the base design for the mockups, mostly the main bar on the left of the screen.
 * Contributed to the [domain model and project vision](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/base-app/blob/main/docs/product.md).

## Sprint 1

During this Sprint I was focused mostly on Kafka exploration and setup for the project's backend - we arrived at a very solid base, with a simple docker composition and very useful utilities (Producer and Consumer), which will be used by all the microservices from now on.
I guided Team 3 when refining their user stories for Sprint 2 (regarding brand preferences and configurations) and create new ones with much more quality and information.

### The two user stories that I am most proud of

* [#23](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/brand-configs/issues/23) As an Admin, I want to see a list of all brands on the system, so that I may alter their configs
* [#13](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/13) As a user, I want to book an ASN, so that a ReceptionCreated message is created and sent using KAFKA

### The two pull requests that I am most proud of

* #24 [Setup Kafka](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/24)

### Two other contributions that I am especially proud of

Timeliness, agility and availability in helping not only Team 4 deliver a Kafka working base, but a bit among all other teams with code reviews, documentation (refining the domain model again, for example), and active participation on the Team and the Class' retrospectives.

## Sprint 2

This Sprint was marked by a major effort in getting Kafka deployed for all the microservices, although we couldn't complete this task due to technical difficulties. Due to this fact, US throughput was severely stalled and some adaptation was required. I then joined efforts with Team 3 and worked on API endpoints for searching, creating and editing brand information, as well as designing unit tests for it.

### The two user stories that I am most proud of

* [#14](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/brand-configs/issues/14) As a brand, I want to check my "Sales Channels & Fulfilment Type" configurations so that I can be informed on what sale channels I have active and their fulfillment types - I proposed, and helped creating and refining this user story.

### The two pull requests that I am most proud of

* #32 [Create API endpoint to search, create and edit brand info](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/brand-configs/pull/32) - Pair programming throughout this PR.

### Two other contributions that I am especially proud of

* Extensive research and testing into the root causes of the problems with Kafka deployment, taking up a major chunk of my invested time;
* Proactive participation in the group retrospective, taking and sharing notes about important feedback about last Sprint and identifying opportunities for betterment.

## Sprint 3

During Sprint 3, we got Kafka deployed and validated by the Product Owner. I worked on changing the docker containers, setting up new utilities, modeling the MAERSK Kafka messages, and migrating the database.

### The two user stories that I am most proud of

* [#14](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/14) As an administrator of the service, I want to receive a ReceptionReceived message in KAFKA, so that the PO status is updated
* [#13](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/13) As a user, I want the warehouse to be informed of a new ASN via Kafka, so that they can receive it

### Two other contributions that I am especially proud of

* Assembling the visualization of Kafka messages for the Sprint review
* Quality assessment of brand configs and detection of bugs - [#76](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/brand-configs/issues/76) and [#75](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/brand-configs/issues/75).

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
