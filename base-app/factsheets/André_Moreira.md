# Factsheet for André Moreira

## Sprint 0

Alongside with my teamates, I helped define the user stories for the [Brand Config](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/brand-configs) microservice. We also defined work items related to setting up some development tools such as docker and some setups related to kafka and the database.

I was also a part of discussing the whole project architecture and structure, defining three microservices and repositories. With the rest of the team, we built the component diagram describing the architecture.

### The two user stories that I am most proud of

This can include user stories that you have written or refined during the sprint. If it was a refinement, explain what you have added or changed.

- #6 [As an admin, I want to search for a brand so that I can see and edit their settings](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/brand-configs/issues/6)
- #7 [As a brand, I want to check my configurations so that I can be informed on how my fulfilments will be processed](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/brand-configs/issues/7)

### Two other contributions that I am especially proud of

- I helped define the architecture of the project and plan the CI/CD operations
- I started thinking about how we could user docker to simplify the setup of tools to help the rest of the developers

## Sprint 1

In this sprint, I developed important work regarding dockerization. This helped all of the developers start working on the project without worrying about specific dependencies and toolchain versions.

I also was responsible for preparing the automatic deploys regarding the develop (staging) and main (production) branches. This took a lot of investigation regarding free platforms and how we could use github actions to automaticly deploy the previously implemented docker images. We are using [Fly.io](fly.io) to host our docker images.

### The two user stories that I am most proud of

In this sprint I was not a part of any refinement or creation of any new User Story

### The two pull requests that I am most proud of

- [#9](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/microservice-template/pull/9) - Add dockerfiles and docker compose to enable a faster and easier development
- [#22](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/base-app/pull/22) - Deploy the base app in fly.io

### Two other contributions that I am especially proud of

There are no other extra contributions in this sprint


## Sprint 2

In this sprint, I developed important work regarding the bug fixing of the deployed versions of the website. There was a problem regarding the configuration of the backend urls in the frontend due to missing and incorrect `.env` files. This problem took a lot more time than expected due to a lot of research regarding elegant ways of having a customized `.env` file for production and how to inject these variables in the docker build phase with flutter web. The solution was based in using github secrets with docker `build-var`'s.

We had trouble configuring kafka with our backend due to issues with the Confluent package, which didn't allow our team to progress in the kafka related user stories. We were able to setup a free kafka instance in [Cloud Karafka](https://www.cloudkarafka.com/).

### The two user stories that I am most proud of

I did not impact directly any user story, however the work done in the deploys impacted all of the project developed in this sprint.

### The two pull requests that I am most proud of

- [#77](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/pull/77) - Found the bug related to incorrect backend url's
- [#44](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/brand-configs/pull/44) - Add automatic deploys to brand configs repository

### Two other contributions that I am especially proud of

In this sprint, I created a free instance of kafka due to our try in setting up kafka with the inbound microservice. However we were not successfull in having a kafka system working due to unexpected errors with the confluent package.

## Sprint 3

In this sprint, I created instances of both Postgres and Kafka for our production deploys to be working.

Besides this, I implemented important work regarding the kafka boilerplate, defining example models and endpoints to test our approach.

### The two user stories that I am most proud of

Having developed robust work regarding the kafka boilerplate, I had a lot of impact on the following two user stories of my team.

- [#13](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/13) 
- [#14](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/issues/14)

### The two pull requests that I am most proud of

- [#74](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/74) - Developed the boilerplate and health check enpoints to validate the correctness of the kafka interaction system
- [#73](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound/pull/73) - Migrate database to postgres

### Two other contributions that I am especially proud of

In this sprint, I also created an [AWS](https://aws.amazon.com/) instance to host our postgres database system. I also found out that the Kafka server created in the previous sprint was not working properly, having found a reliable and free Kafka instance at [confluent](https://confluent.cloud/).


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
