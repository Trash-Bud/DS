# Team 4 - Sprint 1 retrospective

## What went well?

We established a very solid codebase for Kafka development on the backend, as well as frontend-backend communication to generate messages.

We manage to deploy automatically both main and develop versions from their respective branches into two different links.

Pair programming proved useful in navigating documentation, and understanding new patterns.

Communication and cooperation in-team and between teams was positive and instrumental to achieve the Sprint's results.

## What could have gone better?

Unlike all other groups, and due to lack of material and user story refinement on the Product Owner's side, this Sprint we were dealt user stories and tasks created by another group.
Furthermore, they were crude - no mockups, or tasks, or effort estimation, or any detail whatsoever on how to proceed.
And on top of this, they were heavily dependent on that group's issues - since they contain models that the Kafka messages will communicate - which until now do not meet the definition of done.

The course's project deliveries were all stacked during these two weeks, giving everyone less time to work than what is needed for a project, and sprint, of this scale.

These hurdles - dependencies, other work, and technical complexity - on top of an already challenging set of tasks that require setting up a new paradigm on the project, made completion (and especially the ability to show said completion) very difficult.


## What should we do differently?

As much as possible, start working earlier, and review the tasks' challenges and dependencies even earlier.

Refine the Kafka user stories.

## What still puzzles us?

- How to integrate Kafka messages on the other micro-services?
- How should we update the Purchase Order's status?
- How can we make the Kafka destination address variable according to development/production?

## Metrics

**Velocity**: 21 story points in two weeks (sprint).

The time per task (lead time) was aproximately 1 complete day, counting around 3 hours for the review process before integration.

There was only a single deployment to the main environment, at the end of the sprint. There were integrations to the
develop environment (Github branch) every time a user story was completed.


# Sprint 2 retrospective

## What went well?

- Delivered a product increase with value to the client on [Inbound](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound) and [Catalog](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog).
- A great flexibility of the team to go over the Kafka problem and implement other US and Tasks
- Code reviews were improved significantly.

## What could have gone better?

The planned user stories were not done.
Some metrics are still missing in the microservices.
Although there was an improvement in testing, we still think there is room for improvement in both quantity and comprehensiveness of the tests.
Kafka integration was not possible due to confluent package problems.

## What should we do differently?

- We should focus on testing more thoroughly and more often.
- Add more technical documentation and metrics to the project.

## What still puzzles us?

- How to fix Confluent package integration with microservices.
- How to integrate Kafka in our microservice.
- How each microservice's interface is going to be made consistent.
- What we'll use for static analysis, metrics and code coverage.

## Metrics

**Velocity**: 18 story points in two weeks (sprint).

The time per task (lead time) was aproximately 1 complete day, counting 3-4 hours for the review process before integration.

There were no integrations resulting in the failure of the main/develop pipeline environment, so the failure rate
was none.

There was only a single deployment to the main environment, at the end of the sprint. There were integrations to the
develop environment (Github branch) every time a user story was completed.


# Sprint 3 retrospective

## What went well?

- Creation of a Kafka Boilerplate to be used in all microservices
- Implementation of Kafka producers and consumers that can write and read, respectively, from and to topics 
- Code reviews were improved significantly
- Migration of database to postgres
- There was a great improvement on design system for consistency
- All the services were integrated in base app

## What could have gone better?

- The integration of the Kafka system with [Inbound](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound) is not totally done
due to inconsistencies of models previously presented by PO. 
- Some metrics are still missing in the microservices.
- Although there was an improvement in testing, we still think there is room for improvement in both quantity and comprehensiveness of the tests.
- Kafka integration was not possible due to inconsistencies on Kafka payloads previously shown by PO.
- Deployment was block due to github actions expiration.

## What should we do differently?

- We should focus on testing more thoroughly and more often.
- Add more technical documentation and metrics to the project.
- Work sooner in the planned tasks of the sprint

## What still puzzles us?

- How to make Backend independent of Kafka.
- How should login be done and if Kafka need to be used on it.
- What we'll use for static analysis and metrics.

## Action Points

### Continue

-  Collaborating efficiently within the team and with other teams
-  Comprehensive code reviews

### Start

- Testing regularly with various methods (PBT, mutation) and upping kafka coverage
- Documenting how to use kafka and our utilities

### Stop

- Last-minute closing issues

## Metrics

**Velocity**: 16 story points in two weeks (sprint).

![burndown_s3](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/base-app/blob/feature/docs/docs/images/burndown/sprint3/team4.png)

The time per task (lead time) was aproximately 1 complete day, counting 3-4 hours for the review process before integration.

There were no integrations resulting in the failure of the main/develop pipeline environment, so the failure rate
was none.

There was only a single deployment to the main environment, at the end of the sprint. There were integrations to the
develop environment (Github branch) every time a user story was completed.
