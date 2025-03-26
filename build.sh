#!/bin/bash

# Set paths
PROJECT_DIR=$(pwd)
LIB_DIR="$PROJECT_DIR/lib"
SRC_DIR="$PROJECT_DIR/src"
BUILD_DIR="$PROJECT_DIR/WEB-INF/classes"
WAR_FILE="myapp.war"
DEPLOY_DIR="/opt/tomcat/webapps"

# Clean previous build
echo "Cleaning previous build..."
rm -rf "$BUILD_DIR" "$WAR_FILE"
mkdir -p "$BUILD_DIR"

# Compile Java files
echo "Compiling Java files..."
javac -cp "$LIB_DIR/jakarta.jar" -d "$BUILD_DIR" $SRC_DIR/com/mycompany/servlets/*.java

# Package into WAR file
echo "Packaging into WAR file..."
jar -cvf "$WAR_FILE" -C WEB-INF/ .

# Deploy to Tomcat
echo "Deploying to Tomcat..."
sudo mv "$WAR_FILE" "$DEPLOY_DIR/"

echo "Build and deployment completed successfully!"
