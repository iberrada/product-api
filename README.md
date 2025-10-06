# Product API - Spring Boot REST API with PostgreSQL

A Spring Boot REST API application for managing products with PostgreSQL database.

## Features

- REST API endpoints for product management
- PostgreSQL database integration
- Input validation
- CRUD operations (Create, Read, Update, Delete)
- Maven project management

## Prerequisites

- Java 17 or higher
- Maven 3.6 or higher
- PostgreSQL 12 or higher

## Database Setup

1. Install PostgreSQL and create a database:
```sql
CREATE DATABASE productdb;
```

2. Update the database configuration in `src/main/resources/application.properties`:
```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/productdb
spring.datasource.username=your_username
spring.datasource.password=your_password
```

## Running the Application

1. Clone the repository
2. Navigate to the project directory
3. Run the application:
```bash
mvn spring-boot:run
```

The application will start on `http://localhost:8080`

## API Endpoints

### Get All Products
- **GET** `/api/products`
- Returns a list of all products

### Get Product by ID
- **GET** `/api/products/{id}`
- Returns a specific product by ID

### Create Product
- **POST** `/api/products`
- Creates a new product
- Request body example:
```json
{
    "name": "New Product",
    "quantity": 10,
    "price": 99.99
}
```

### Update Product
- **PUT** `/api/products/{id}`
- Updates an existing product
- Request body example:
```json
{
    "name": "Updated Product",
    "quantity": 15,
    "price": 129.99
}
```

### Delete Product
- **DELETE** `/api/products/{id}`
- Deletes a specific product

### Delete All Products
- **DELETE** `/api/products`
- Deletes all products

## Database Schema

The `products` table has the following structure:

| Column   | Type           | Constraints                    |
|----------|----------------|--------------------------------|
| id       | BIGSERIAL      | PRIMARY KEY, AUTO_INCREMENT    |
| name     | VARCHAR(255)   | NOT NULL                       |
| quantity | INTEGER        | NOT NULL, >= 0                 |
| price    | DECIMAL(10,2)  | NOT NULL, > 0                  |

## Sample API Calls

### Get all products:
```bash
curl -X GET http://localhost:8080/api/products
```

### Get product by ID:
```bash
curl -X GET http://localhost:8080/api/products/1
```

### Create a new product:
```bash
curl -X POST http://localhost:8080/api/products \
  -H "Content-Type: application/json" \
  -d '{"name": "Smartphone", "quantity": 20, "price": 599.99}'
```

### Update a product:
```bash
curl -X PUT http://localhost:8080/api/products/1 \
  -H "Content-Type: application/json" \
  -d '{"name": "Updated Laptop", "quantity": 8, "price": 1099.99}'
```

### Delete a product:
```bash
curl -X DELETE http://localhost:8080/api/products/1
```

## Project Structure

```
src/
├── main/
│   ├── java/
│   │   └── com/example/productapi/
│   │       ├── ProductApiApplication.java
│   │       ├── controller/
│   │       │   └── ProductController.java
│   │       ├── entity/
│   │       │   └── Product.java
│   │       └── repository/
│   │           └── ProductRepository.java
│   └── resources/
│       ├── application.properties
│       ├── schema.sql
│       └── data.sql
└── test/
    └── java/
        └── com/example/productapi/
```

## Technologies Used

- Spring Boot 3.2.0
- Spring Data JPA
- PostgreSQL
- Maven
- Java 17