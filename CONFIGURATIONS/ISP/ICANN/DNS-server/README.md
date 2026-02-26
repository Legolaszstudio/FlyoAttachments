# ICANN DNS szerver

Ebben a mappában a ICANN hálózatában található DNS szerver beállításai találhatóak, mely egy minimized Ubuntu 24.04.3 LTS szerveren fut. 

A telepített szoftver egy egyéni készítésű fastify és nodejs alapú alakalmazás, mely a [simple-dns-gui](https://github.com/Legolaszstudio/simple-dns-gui) GitHub repository-ban érhető el. Ez a szolgáltatás pm2 segítségével fut daemon-ként, egy apró módosítással a sudoers fájlban, hogy újra tudja indítani a dnsmasq szolgáltatást.