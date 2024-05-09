# Microservice backend
The `ASP.NET` backend for this microservice.

## Database connection
To specify a `PostgreSQL` database to use rather than the default one, fill the `database` section in `src/appsettings.local.json`.

## Project structure

- **src/**: Main source files of the application
- **test/**: Unit tests, used to test single components or functions in the application
- **integrations-tests/**: Integration tests, used to test the application running as a whole

## Running the Application
To run the application through docker, simply run the script `dev_be.sh` located in the parent directory.

## API Documentation
The API specification can be consulted on the [deployed version](http://137.66.62.29/swagger) or directly in the [yaml documentation](./docs/api.yaml).

## Deployed Versions
- [Develop](http://137.66.52.18/)
- [Production](http://137.66.62.29/)
