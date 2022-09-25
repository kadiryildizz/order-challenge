##  Challenge

Projede 
Sipariş oluşturma,güncelleme,listeleme,sisteme login olma ve token alma olmak
üzere 4 enpoint altında yapılmıştır.
Sipariş de bulunan ürün çıkarılması için ürün quantity adeti (0) sıfır olarak verilebilir.
Müşteri kendi oluşturulan tüm siparişleri görebilir ve nakliyesi gelmemiş siparişleri güncelleyebilir.
Admin oluşturulan tüm siparişleri görebilir ve nakliyesi gelmemiş siparişleri güncelleyebilir.
Kullanıcılar ve ürünler laravel seed olarak tanımlanmıştır.
#İşlemlerin Yapıldığı Kullanıcılar 

Örnek Kullanıcı login bilgileri

- email    : test_user@example.org
- password : 123123

Admin Kullanıcı Bilgileri

- email    : admin@example.org
- password : 123456


# Kurulum
```bash
git clone https://github.com/kadiryildizz/order-challenge.git
```
```bash
/bin/bash ./install.sh
```

# Postman
Postman klasörü içinde environment ve api ile enpointleri içeri aktarabilirsiniz.

Collections içinde detaylı istek çıktıları mevcut.

[Postman Collection](https://github.com/kadiryildizz/order-challenge/tree/master/postman)

# Sql
- HOST=127.0.0.1
- PORT=3317
- DATABASE=laravel
- USERNAME=sail
- PASSWORD=password

postman testleri için kullandığım sql datasını buradan yükleye bilirsiniz.

[sql dump](https://github.com/kadiryildizz/order-challenge/blob/master/sql%20dump.sql)


