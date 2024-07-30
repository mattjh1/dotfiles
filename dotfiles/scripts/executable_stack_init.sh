#!/bin/bash

usage() {
   echo "Usage: $0 <project_name>"
   exit 1
}

prompt() {
   read -e -p "$1: " value
   echo "$value"
}

if [ -z "$1" ]; then
   echo "Error: Project name not provided."
   usage
fi

PROJECT_NAME="$1"
BASE_DIR=$(pwd)  

PROJECT_DIR="$BASE_DIR/$PROJECT_NAME"
FRONTEND_DIR="$PROJECT_DIR/frontend"
BACKEND_DIR="backend"
BACKEND_PATH="$PROJECT_DIR/$BACKEND_DIR"
SHARED_TYPES_DIR="$PROJECT_DIR/sharedTypes"

mkdir -p "$PROJECT_DIR"

DB_NAME=$(prompt "Enter database name")
DB_USER=$(prompt "Enter database user")
DB_PASSWORD=$(prompt "Enter database password")

echo "Creating Next.js app (Frontend)..."
npx create-next-app "$FRONTEND_DIR" --typescript

echo "Updating package.json in Frontend..."
sed -i '' -e '/"dev":/s/"dev":.*/"dev": "next dev -p 3000",/' "$FRONTEND_DIR/package.json"

echo "Installing frontend dependencies..."
(cd "$FRONTEND_DIR" && npm install)

if ! command -v nest &> /dev/null; then
    echo "Nest.js CLI not found. Installing @nestjs/cli globally..."
    npm install -g @nestjs/cli
fi

cd $PROJECT_DIR

echo "Creating Nest.js app (Backend)..."
nest new "$BACKEND_DIR" --skip-install

# Adding a delay to ensure the backend files are created
sleep 5

# Check if the backend directory was created successfully
if [ -d "$BACKEND_PATH" ]; then
    echo "Nest.js app created successfully in $BACKEND_PATH"
else
    echo "Error: Backend directory not found."
    exit 1
fi

echo "Setting up environment variables..."
echo "DATABASE_URL=postgresql://$DB_USER:$DB_PASSWORD@localhost:5432/$DB_NAME" > "$BACKEND_PATH/.env"
echo ".env" >> "$BACKEND_PATH/.gitignore"

echo "Initializing Prisma..."
(cd "$BACKEND_DIR" && npx prisma init)

mkdir -p "$BACKEND_PATH/prisma"
echo "Updating schema.prisma with database connection details..."
cat <<EOL >"$BACKEND_PATH/prisma/schema.prisma"
datasource db {
 provider = "postgresql"
 url      = env("DATABASE_URL")
}

generator client {
 provider = "prisma-client-js"
 output   = "./generated/client"
}
model User {
 id    Int      @id @default(autoincrement())
 email String   @unique
 name  String?
}
EOL

echo "Installing backend dependencies..."
(cd "$BACKEND_PATH" && npm install && npx prisma generate)

echo "Creating Docker Compose file..."
cat <<EOL >$PROJECT_DIR/docker-compose.yml
version: '3.8'
services:
  postgres:
    image: postgres
    restart: always
    environment:
      POSTGRES_DB: $DB_NAME
      POSTGRES_USER: $DB_USER
      POSTGRES_PASSWORD: $DB_PASSWORD
    networks:
      - internal

  backend:
    build:
      context: ./backend
      dockerfile: Dockerfile
    restart: always
    ports:
      - "3001:3000"
    depends_on:
      - postgres
    env_file:
      - ./backend/.env
    networks:
      - internal
    volumes:
      - sharedTypes:/usr/src/app/node_modules/sharedTypes

  frontend:
    build:
      context: ./frontend
      dockerfile: Dockerfile
    restart: always
    ports:
      - "3000:3000"
    networks:
      - internal
    volumes:
      - sharedTypes:/usr/src/app/node_modules/sharedTypes

networks:
  internal:
    driver: bridge

volumes:
  sharedTypes:
    driver: local
EOL

echo "Creating Dockerfile for Backend..."
cat <<EOL >"$BACKEND_PATH/Dockerfile"
FROM node:lts-slim

# Set working directory
WORKDIR /usr/src/app

# Copy the package.json and package-lock.json to the container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Expose the backend port
EXPOSE 3000

# Command to run the Nest.js application
CMD ["npm", "run", "start:dev"]
EOL

echo "Creating Dockerfile for Frontend..."
cat <<EOL >"$FRONTEND_DIR/Dockerfile"
FROM node:lts-slim

# Set working directory
WORKDIR /usr/src/app

# Copy the package.json and package-lock.json to the container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Expose the frontend port
EXPOSE 3000

# Command to run the Next.js application
CMD ["npm", "run", "dev"]
EOL

echo "Creating sharedTypes directory..."
mkdir -p "$SHARED_TYPES_DIR"

echo "Setup complete. Your Next.js app (Frontend) with Nest.js, Prisma, sharedTypes, and Docker is ready!"
echo "Run docker-compose up to start the application"

