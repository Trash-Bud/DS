# Catalog
Catalog Microservice for Maersk Ecommerce Logistics API and Applications Project

## Backend

The backend is a `ASP.NET` based micro-service. The recommended runtime is `.NET Core 6.0.x`.

The recommended IDEs are `Visual Studio` or `Rider`. When using `Visual Studio Code`, you should install the `.NET Extension Pack` for debugging and linting purposes. If you run into problems, make sure to manually register a run configuration and/or enable the `Roslyn Analyzers` in the IDE settings.

More information on how to run and the routes in [backend README](https://github.com/FEUP-MEIC-DS-2022-1MEIC01/catalog/blob/develop/backend/README.md)

### Database

We use `SQLite` as our DBMS, and the respective version of the `Entity Framework Core` for `.NET` serving as an ORM.

When running the migrations, the `SQLite` file is automatically placed at the `src/` project root.

You can use a tool such as `DB Browser` to inspect the current state of the database when in need to debug queries.

## Frontend

The frontend is a `Flutter` based single-page application. The recommended version is `3.3.2`.

The recommended IDE is `Android Studio` or `IntelliJ IDEA`. When using `Visual Studio Code`, you should install the `Flutter` extension.

If not using `Chrome`, use `web-server` as your default device, e.g. `flutter run -d web-server`.
