#
#	Ubuntu 16.04
#
# Basic installation as per https://jena.apache.org/documentation/fuseki2/fuseki-run.html#fuseki-web-application


#	Server update
sudo apt update
sudo timedatectl set-timezone Australia/Brisbane


#	Environment variables
sudo sh -c 'echo "JAVA_HOME=\"/usr/lib/jvm/default-java\"" >> /etc/environment'
sudo sh -c 'echo "TOMCAT_HOME=\"/var/lib/tomcat7/\"" >> /etc/environment'
sudo sh -c 'echo "CATALINA_HOME=\"/usr/share/tomcat7\"" >> /etc/environment'
sudo sh -c 'echo "CATALINA_BASE=\"/var/lib/tomcat7/\"" >> /etc/environment'
source /etc/environment


#	Apache
sudo apt install -y apache2
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2enmod proxy_ajp
sudo a2enmod headers
sudo a2enmod rewrite
sudo htpasswd -b -c /etc/.htpasswd xxxxxx yyyyyy
sudo rm /etc/apache2/sites-available/default-ssl.conf
sudo cp apache.conf /etc/apache2/sites-available/000-default.conf
# static index page
sudo echo "XYZ's RDF graph database server" > /var/www/html/index.html
sudo service apache2 restart

#	Tomcat
sudo apt install -y tomcat7
sudo apt install -y tomcat7-admin
sudo cp tomcat-users.xml /var/lib/tomcat7/conf/tomcat-users.xml
sudo service tomcat7 restart

#	Fuseki
wget http://mirror.ventraip.net.au/apache/jena/binaries/apache-jena-fuseki-2.6.0.tar.gz
tar -xzf apache-jena-fuseki-2.6.0.tar.gz
sudo mkdir /etc/fuseki
sudo chown -R tomcat7 /etc/fuseki
sudo cp apache-jena-fuseki-2.6.0/fuseki.war /var/lib/tomcat7/webapps/
# wait for Tomcat to unpack WAR
sudo nano /etc/fuseki/shiro.ini # comment out #/$/** = localhostFilter, implement username/pwd as indicated in file if not using Apache auth
sudo nano /etc/default/tomcat7 --> set heap size to 256m


#	create first DB via HTTP commands TODO


