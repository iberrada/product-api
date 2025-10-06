#!/bin/bash

# Start development environment script
echo "🚀 Starting Product API Development Environment"

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Check if docker-compose is available
if ! command -v docker-compose &> /dev/null; then
    echo "❌ docker-compose is not installed. Please install docker-compose first."
    exit 1
fi

# Start the services
echo "📦 Starting PostgreSQL and Product API..."
docker-compose up -d

# Wait for services to be healthy
echo "⏳ Waiting for services to be ready..."
sleep 10

# Check if services are running
if docker-compose ps | grep -q "Up"; then
    echo "✅ Services are running!"
    echo ""
    echo "🌐 Application URLs:"
    echo "  - API: http://localhost:8080"
    echo "  - Health Check: http://localhost:8080/actuator/health"
    echo "  - API Documentation: http://localhost:8080/api/products"
    echo ""
    echo "📊 Database:"
    echo "  - Host: localhost"
    echo "  - Port: 5432"
    echo "  - Database: productdb"
    echo "  - Username: postgres"
    echo "  - Password: password"
    echo ""
    echo "🛠️  To start with pgAdmin, run:"
    echo "  docker-compose --profile tools up -d"
    echo ""
    echo "🛑 To stop services, run:"
    echo "  docker-compose down"
else
    echo "❌ Failed to start services. Check the logs:"
    docker-compose logs
fi