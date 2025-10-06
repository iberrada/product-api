# Product API - Spring Boot REST API with PostgreSQL

A Spring Boot REST API application for managing products with PostgreSQL database.

## Features

- REST API endpoints for product management
- PostgreSQL database integration
- Liquibase database migration management
- Input validation
- CRUD operations (Create, Read, Update, Delete)
- Maven project management
- Docker containerization
- GitLab CI/CD pipeline
- Health checks and monitoring with Spring Boot Actuator

## Prerequisites

### For Local Development:
- Java 17 or higher
- Maven 3.6 or higher
- PostgreSQL 12 or higher

### For Docker Development:
- Docker 20.10 or higher
- Docker Compose 2.0 or higher

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

3. The database schema and sample data will be automatically created by Liquibase when the application starts.

## Running the Application

1. Clone the repository
2. Navigate to the project directory
3. Run the application:
```bash
mvn spring-boot:run
```

The application will start on `http://localhost:8080`

## Docker Development

### Using Docker Compose (Recommended)

1. Start the application with PostgreSQL:
```bash
docker-compose up -d
```

2. Start with pgAdmin for database management:
```bash
docker-compose --profile tools up -d
```

3. Stop the application:
```bash
docker-compose down
```

4. Stop and remove volumes:
```bash
docker-compose down -v
```

### Using Docker Only

1. Build the Docker image:
```bash
docker build -t product-api .
```

2. Run with external PostgreSQL:
```bash
docker run -p 8080:8080 \
  -e SPRING_DATASOURCE_URL=jdbc:postgresql://host.docker.internal:5432/productdb \
  -e SPRING_DATASOURCE_USERNAME=postgres \
  -e SPRING_DATASOURCE_PASSWORD=password \
  product-api
```

### Access Points

- **Application**: http://localhost:8080
- **Health Check**: http://localhost:8080/actuator/health
- **pgAdmin** (if using tools profile): http://localhost:5050
  - Email: admin@example.com
  - Password: admin

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

## Liquibase Database Management

This project uses Liquibase for database schema versioning and migration management.

### Liquibase Commands

#### Update database to latest version:
```bash
mvn liquibase:update
```

#### Check migration status:
```bash
mvn liquibase:status
```

#### Generate SQL for pending changes:
```bash
mvn liquibase:updateSQL
```

#### Rollback last changeset:
```bash
mvn liquibase:rollback -Dliquibase.rollbackCount=1
```

#### Clear all checksums:
```bash
mvn liquibase:clearCheckSums
```

### Migration Files

- **Master changelog**: `src/main/resources/db/changelog/db.changelog-master.xml`
- **Table creation**: `src/main/resources/db/changelog/001-create-products-table.xml`
- **Sample data**: `src/main/resources/db/changelog/002-insert-sample-data.xml`

### Adding New Migrations

1. Create a new XML file in `src/main/resources/db/changelog/`
2. Add the file reference to `db.changelog-master.xml`
3. Run `mvn liquibase:update` to apply changes

## GitLab CI/CD Pipeline

This project includes a comprehensive GitLab CI/CD pipeline with the following stages:

### Pipeline Stages

1. **Validate**: Check project structure and resolve dependencies
2. **Test**: Run unit tests with PostgreSQL integration
3. **Build**: Compile the application
4. **Package**: Create JAR file and Docker image
5. **Deploy**: Deploy to different environments

### Pipeline Features

- **Automated Testing**: Unit and integration tests with coverage reporting
- **Code Quality**: SonarQube integration (optional)
- **Security Scanning**: OWASP dependency check
- **Docker Build**: Automated container image creation
- **Multi-Environment Deployment**: Development, Staging, and Production
- **Caching**: Maven dependencies and build artifacts

### Required GitLab Variables

Set these variables in your GitLab project settings:

#### Database (for testing)
- `POSTGRES_DB`: productdb_test
- `POSTGRES_USER`: postgres  
- `POSTGRES_PASSWORD`: postgres

#### SonarQube (optional)
- `SONAR_HOST_URL`: Your SonarQube server URL
- `SONAR_TOKEN`: SonarQube authentication token

#### Deployment URLs
- `DEV_APP_URL`: Development environment URL
- `STAGING_APP_URL`: Staging environment URL  
- `PROD_APP_URL`: Production environment URL

### Running the Pipeline

The pipeline runs automatically on:
- **Merge Requests**: Validation and testing
- **Main Branch**: Full pipeline including packaging
- **Develop Branch**: Development deployment
- **Tags**: Production deployment

### Manual Jobs

Some jobs require manual approval:
- Code quality analysis
- Environment deployments
- Security scanning

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
│       ├── liquibase.properties
│       └── db/
│           └── changelog/
│               ├── db.changelog-master.xml
│               ├── 001-create-products-table.xml
│               └── 002-insert-sample-data.xml
└── test/
    └── java/
        └── com/example/productapi/
```

## Technologies Used

- **Backend**: Spring Boot 3.2.0, Spring Data JPA, Spring Boot Actuator
- **Database**: PostgreSQL, Liquibase 4.24.0
- **Build Tool**: Maven
- **Runtime**: Java 17
- **Containerization**: Docker, Docker Compose
- **CI/CD**: GitLab CI/CD
- **Testing**: JUnit 5, H2 (for tests)
- **Monitoring**: Spring Boot Actuator, Prometheus metrics