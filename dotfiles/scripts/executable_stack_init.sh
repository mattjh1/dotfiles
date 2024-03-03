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
mkdir -p "$PROJECT_DIR"

FRONTEND_DIR="$PROJECT_DIR/$PROJECT_NAME-frontend"
BACKEND_DIR="$PROJECT_DIR/$PROJECT_NAME-backend"
SHARED_TYPES_DIR="$PROJECT_DIR/sharedTypes"

DB_NAME=$(prompt "Enter database name")
DB_USER=$(prompt "Enter database user")
DB_PASSWORD=$(prompt "Enter database password")


echo "Creating Next.js app (Frontend)..."
npx create-next-app $FRONTEND_DIR --typescript

cd $FRONTEND_DIR
echo "Installing frontend dependencies..."
npm install

cd ..

if ! command -v nest &> /dev/null; then
    echo "Nest.js CLI not found. Installing @nestjs/cli globally..."
    npm install -g @nestjs/cli
fi

echo "Creating Nest.js app (Backend)..."
nest new $PROJECT_NAME-backend

echo "DATABASE_URL=postgresql://$DB_USER:$DB_PASSWORD@db:5432/$DB_NAME" > "$BACKEND_DIR/.env"
echo ".env" >> "$BACKEND_DIR/.gitignore"

cd $BACKEND_DIR
echo "Installing backend dependencies..."
npm install

npx prisma init

echo "Updating schema.prisma with database connection details..."
cat <<EOL >prisma/schema.prisma
datasource db {
 provider = "postgresql"
 url      = env("DATABASE_URL")
}
generator client {
 output = "./generated/client"
}
model User {
 id    Int      @id @default(autoincrement())
 email String   @unique
 name  String?
}
EOL

npm run build

cd "$BASE_DIR"

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
 backend:
   build:
     context: .
     dockerfile: Dockerfile-backend
   restart: always
   ports:
     - "3002:3002"
   depends_on:
     - postgres
 frontend:
   build:
     context: .
     dockerfile: Dockerfile-frontend
   restart: always
   ports:
     - "3001:3000"
EOL

echo "Creating Dockerfile for Backend..."
cat <<EOL >$PROJECT_DIR/Dockerfile-backend
FROM node:lts
WORKDIR /usr/src/app
COPY $PROJECT_NAME-backend/package*.json ./
RUN npm install
COPY $PROJECT_NAME-backend .
EXPOSE 3000
CMD ["npm", "run", "start:dev"]
EOL

echo "Creating Dockerfile for Frontend..."
cat <<EOL >$PROJECT_DIR/Dockerfile-frontend
FROM node:lts
WORKDIR /usr/src/app
COPY $PROJECT_NAME-frontend/package*.json ./
RUN npm install
COPY $PROJECT_NAME-frontend .
EXPOSE 3000
CMD ["npm", "run", "dev"]
EOL

echo "Creating sharedTypes directory..."
mkdir $SHARED_TYPES_DIR

echo "Updating package.json in Frontend..."
sed -i '' -e '/"dev":/s/"dev":.*/"dev": "next dev -p 3001",/' "$FRONTEND_DIR/package.json"
sed -i '' 's/"scripts": {/"scripts": {\n    "postinstall": "ln -s ..\/sharedTypes .\/node_modules\/sharedTypes",/g' "$FRONTEND_DIR/package.json"

echo "Updating package.json in Backend..."
sed -i '' -e '/"start:dev":/s/"start:dev":.*/"start:dev": "nest start --watch --port 3002",/' "$BACKEND_DIR/package.json"
sed -i '' 's/"scripts": {/"scripts": {\n    "postinstall": "ln -s ..\/sharedTypes .\/node_modules\/sharedTypes",/g' "$BACKEND_DIR/package.json"

echo "Setup complete. Your Next.js app (Frontend) with Nest.js, Prisma, sharedTypes, and Docker is ready!"
echo "Run docker-compose up to start the application"
