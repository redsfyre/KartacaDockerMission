https://github.com/Sysnove/flask-hello-world adresindeki basic flask uygulamasına Docker container'ı içinde HAProxy (load balancer) kullanarak erişebilmek için aşağıdaki yönergeleri takip edin.

Çalıştırmadan önce;
  - `pip install docker-compose`
  - `pip install --upgrade backports.ssl_match_hostname`
  
Çalıştırmak için;

  - `docker build .`
  - Oluşturulan imaja ait ID'yi öğrenebilmek için;
  - `docker images`
  - `docker run -it -p 80:8000 --net=host <ImageID>`
  - Tarayıcınızdan http://localhost:8000 adresine giderek "Hello World!" çıktısını gördüğünüzden emin olun.
  - Buraya kadar bir problem yoksa docker-compose.yml dosyasının içinde çağırdığımız python uygulamasını ve HAProxy'yi çalıştırabiliriz.
  - `docker-compose build`
  - `docker-compose up -d`
  - `-d` parametresi (detach) uygulamamızı arka planda çalıştırabilmemize olanak sağlıyor

Servislerin çalışıp çalışmadığını kontrol etmek için:
  - `docker-compose ps` komutunun çıktısında `*_pyapp_1` ve `*_loadbalancer_1` servislerinin `State` başlığı altında `Up` ifadesini aramalıyız.
  
Ve işte oldu, flask-hello-world uygulamamız HAProxy load balancer ile birlikte çalışıyor.
Ancak şu anda python uygulamamıza karşılık gelen sadece bir servisimiz var. Uygulamayı ölçeklendirmek istersek;
  - `docker-compose scale pyapp=5`
  - Python uygulamamızı çalıştıran 5 container olduğunu doğrulayalım;
  - `docker-compose ps`
  - Terminalinizden de görebileceğiniz gibi uygulamamız 5 container içinde çalışıyor ama işimiz henüz bitmedi. HAProxy yeni değişimlerden henüz haberdar değil;
  - `docker-compose stop loadbalancer`
  - `docker-compose rm loadbalancer`
  - `docker-compose up -d` 
  - komutlarını çalıştırdıktan sonra şuna benzer bir çıktı göreceksiniz:
  ```
  *_pyapp_4 is up-to-date
  *_pyapp_2 is up-to-date  
  *_pyapp_3 is up-to-date  
  *_pyapp_5 is up-to-date  
  *_pyapp_1 is up-to-date  
  Creating *_loadbalancer_1 
  ```
Load balancer'ın yeniden başladığını görmüş olduk. 
İşte bu kadar. Artık "Hello World!" mesajı basmak dışında hiçbir işe yaramayan uygulamamıza load balancer ile erişebiliyoruz. 
