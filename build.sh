#!/bin/bash

# Set project directories
PROJECT_DIR=$(pwd)
LIB_DIR="$PROJECT_DIR/lib"
SRC_DIR="$PROJECT_DIR/src"
BUILD_DIR="$PROJECT_DIR/WEB-INF/classes"
WEBAPP_DIR="$PROJECT_DIR/webapp"
WAR_FILE="myapp.war"
DEPLOY_DIR="/opt/tomcat/webapps"

# Tomcat Service Name
TOMCAT_SERVICE="tomcat"

echo "======================================"
echo "🚀 Starting Build and Deployment..."
echo "======================================"

# Step 1: Clean previous build
echo "🧹 Cleaning previous build..."
rm -rf "$BUILD_DIR" "$WAR_FILE"
mkdir -p "$BUILD_DIR"

# Step 2: Compile Java files
echo "🔨 Compiling Java files..."
find "$SRC_DIR" -name "*.java" | xargs javac -cp "$LIB_DIR/jakarta.jar" -d "$BUILD_DIR"

# Step 3: Verify Compilation
if [ $? -ne 0 ]; then
    echo "❌ Compilation failed! Check errors."
    exit 1
fi

# Step 4: Package into WAR file
echo "📦 Packaging into WAR file..."
jar -cvf "$WAR_FILE" -C "$WEBAPP_DIR" . -C WEB-INF/ .

# Step 5: Stop Tomcat
echo "🛑 Stopping Tomcat..."
sudo systemctl stop "$TOMCAT_SERVICE"

# Step 6: Remove previous deployment (Fix: Add sudo)
echo "🧹 Removing previous deployment..."
sudo rm -rf "$DEPLOY_DIR/myapp" "$DEPLOY_DIR/$WAR_FILE" /opt/tomcat/work/*

# Step 7: Deploy WAR file
echo "🚀 Deploying WAR file..."
sudo mv "$WAR_FILE" "$DEPLOY_DIR/"

# Step 8: Start Tomcat
echo "✅ Starting Tomcat..."
sudo systemctl start "$TOMCAT_SERVICE"

# Step 9: Wait for Deployment
echo "⏳ Waiting for Tomcat to deploy the application..."
sleep 10

# Step 10: Check Deployment
echo "🔍 Checking deployment..."
curl -I http://localhost:8080/myapp/

# Final Confirmation
echo "🎉 Build and Deployment Completed Successfully!"
