# Microservice backend
The `AspNet` backend for this microservice.

## Database connection
To specify a `SQLite` database to use rather than the default one, fill the `DatabaseFilePath` section in `src/appsettings.local.json`.

## Running the application
To run the application, use the following command:

```bash
dotnet ef migrations add Product
dotnet ef database update
dotnet run
```
To reset the database and the migration, use the following command:

```bash 
dotnet ef database drop
dotnet ef migrations remove
```

## Routes

A Swagger endpoint is generated when the backend runs.
You can access it on https://localhost:8081/swagger, or view the .yaml at [docs/api.yaml](docs/api.yaml).

| Route                                                           | Method | Description                                                                          |
|-----------------------------------------------------------------|:------:|--------------------------------------------------------------------------------------|
| /                                                               | GET    | Health check                                                                         |
| /products                                                       | GET    | Get all products                                                                     |
| /products/{id}                                                  | GET    | Get the product with given id                                                        |
| /products/{id}/variants                                         | GET    | Get variants of given product                                                        |
| /products/{productId}                                           | PUT    | Edit the product with given id                                                       |
| /products/add                                                   | POST   | Add a product                                                                        |
| /variants?pageNumber={num}&pageSize={num}&q={str}&brandId={num} | GET    | Get all variants paginated (if `q` and `brandId` are defined, only the variants that match them |
| /variants/pages?pageSize={num}&q={str}&brandId={num}            | GET    | Get the number of variant pages (if `q` and `brandId` are defined, only the variants that match them) |
| /variants/{id}                                                  | GET    | Get the variant with given id                                                        |
| /variants/{variantId}                                           | PUT    | Edit the variant with given id                                                       |
| /variants/add?brandID={id}                                      | POST   | Add a variant                                                                        |
| /variants/archive/{id}                                          | POST   | Archive the variant with given id                                                    |
| /variants/template                                              | GET    | Get the excel template file                                                          |
| /variants/import?brandID={id}                                   | POST   | Add all variants in an excel file                                                    |
| /brands                                                         | GET    | Get all brands                                                                       |
| /brands/{id}                                                    | GET    | Get the brand with given id                                                          |
| /brands/add                                                     | POST   | Add a brand                                                                          |
