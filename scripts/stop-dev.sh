#!/bin/bash

# Stop development environment script
echo "🛑 Stopping Product API Development Environment"

# Stop and remove containers
echo "📦 Stopping services..."
docker-compose down

# Optional: Remove volumes (uncomment if you want to reset database)
# echo "🗑️  Removing volumes..."
# docker-compose down -v

echo "✅ Development environment stopped!"
echo ""
echo "💡 To completely reset (including database data), run:"
echo "  docker-compose down -v"