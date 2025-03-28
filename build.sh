# Step 1: Compile Java files
export CLASSPATH=lib/jakarta.jar:lib/jcbd.jar
javac -d ../WEB-INF/classes src/com/mycompany/utils/DatabaseConnection.java src/com/mycompany/servlets/HelloServlet.java

# Step 2: Package WAR file
cd webapp
jar -cvf ../myapp.war -C WEB-INF . -C ../WEB-INF/classes .

# Step 3: Deploy the WAR file
sudo systemctl stop tomcat
sudo rm -rf /opt/tomcat/webapps/myapp /opt/tomcat/webapps/myapp.war
sudo mv myapp.war /opt/tomcat/webapps/
sudo systemctl start tomcat

# Step 4: Check deployment
curl -I http://localhost:8080/myapp/

# Step 5: Test Database Connection (Optional)
java -cp WEB-INF/classes:lib/jakarta.jar:lib/jcbd.jar com.mycompany.utils.DatabaseConnection
