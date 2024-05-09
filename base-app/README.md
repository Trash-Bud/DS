# Maersk Ecommerce Logistics API and Applications


[![codecov](https://codecov.io/gh/FEUP-MEIC-DS-2022-1MEIC01/base-app/branch/develop/graph/badge.svg?token=2U6DXJH92Y)](https://codecov.io/gh/FEUP-MEIC-DS-2022-1MEIC01/base-app)

<!--- Explain here in one or two sentences what is the goal of your product. More details about the product should be found in the [product management](docs/product.md) documentation (make sure you link it from here), which includes the product vision, market research and domain analysis. -->

For MAERSK's clients, who want MAERSK to support their entire logistics operation. The Ecommerce Logistics API is an API that gives more control to clients and visibility on theirs operations. The API combines multiple services such as catalog and purchase orders' management and brand configuration.

More details about the product should be found in the [product management](docs/product.md) documentation.

<!--
## How to use

Explain how to use your software from user standpoint. This can include short videos, screenshots, or API documentation, depending on what makes sense for your particular software system and target users. If needed, link to external resources or additional markdown files with further details (please place these in the [docs](docs/) directory).
 -->

## How to contribute

<!--
Explain what a new developer to the project should know in order to develop the system, including who to build, run and test it in a development environment.  -->

The project has 3 different microservices and one main application that interacts with them.

Each microservice has its own repository including the backend and frontend, and how to build and run.

Further information on the microservices and links to the repositories can be found in the Microservices section below.

More details about the technical vision can be found in the [development](docs/development.md) documentation, which includes information on architectural, design and technical aspects.

## How to access

This system can be accessed by the [main microservice](http://maersk.duckdns.org/#/).

Each microservice has both a development and production deploy.

### Base App

- [Production](http://maersk.duckdns.org/#/)
- [Development](http://dev-maersk.duckdns.org/#/)

### Inbound

- [Production](http://maersk-inbound.duckdns.org/#/)
- [Development](http://dev-maersk-inbound.duckdns.org/#/)

### Catalog

- [Production](http://maersk-catalog.duckdns.org/#/)
- [Development](http://dev-maersk-catalog.duckdns.org/#/)

### Brand Configs

- [Production](http://maersk-config.duckdns.org/#/)
- [Development](http://dev-maersk-config.duckdns.org/#/)

## How to run

In order to run the project with docker, we need to give permissions to the frontend containers to access the design system repository. To do this, create an organization PAT in github and add it to the `frontend/pat/pat` file. The docker images will then replace this personal access token in the `pubspec.yaml` file inside the build container.

After this initial setup, we can run each microservice with:

- Frontend `./dev_fe.sh`
- Backend `./dev_be.sh`

These commands can be executed with custom docker flags such as `--build` to tell docker to rebuild the images.

## Contributions

- [Team 1](factsheets/team1.md)
  - [Antonio Ribeiro](factsheets/Antonio_Ribeiro.md)
  - [Bruno Rosendo](factsheets/Bruno_Rosendo.md) (SM)
  - [David Preda](factsheets/David_Preda.md)
  - [Joana Mesquita](factsheets/Joana_Mesquita.md)
  - [João Mesquita](factsheets/Joao_Mesquita.md)
  - [José Ferreira](factsheets/José_Ferreira.md) (SPO)
- [Team 2](factsheets/team2.md)
  - [António Miranda](factsheets/António_Miranda.md)
  - [Bruno Mendes](factsheets/Bruno_Mendes.md)
  - [Catarina Pires](factsheets/Catarina_Pires.md) (SPO)
  - [Diogo Costa](factsheets/Diogo_Costa.md) (SM)
  - [Flávio Vaz](factsheets/Flavio_Vaz.md)
  - [Henrique Nunes](factsheets/Henrique_Nunes.md)
  - [Victor Nunes](factsheets/Victor_Nunes.md)
- [Team 3](factsheets/team3.md)
  - [Daniel Félix](factsheets/Daniel_Félix.md)
  - [Francisco Colino](factsheets/Francisco_Colino.md) (SPO)
  - [Lucas Santos](factsheets/Lucas_Santos.md)
  - [Miguel Freitas](factsheets/Miguel_Freitas.md) (SM)
  - [Nuno Alves](factsheets/Nuno_Alves.md)
  - [Pedro Machado](factsheets/Pedro_Machado.md)
- [Team 4](factsheets/team4.md)
  - [André Moreira](factsheets/André_Moreira.md)
  - [João Baltazar](factsheets/João_Baltazar.md) (SM)
  - [Juan Lopez](factsheets/Juan_Lopez.md) (SPO)
  - [Luís Matos](factsheets/Luís_Matos.md)
  - [Nuno Costa](factsheets/Nuno_Costa.md)
  - [Rui Alves](factsheets/Rui_Alves.md)

## Microservices

The system is organized into multiple microservices, explained below. Each of them has a backend and a frontend services,
which are then used in the base app:

- [**Inbound**](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/inbound): Application for the management of advanced shipping notices and purchase oders.
- [**Catalog**](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog): Application for the management of the catalog.
- [**Brand Configs**](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/brand-configs): Application for the management of the brand configurations.
