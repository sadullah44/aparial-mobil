# Flutter Nedir?

Flutter, Google tarafından geliştirilen **açık kaynaklı bir UI (User Interface) yazılım geliştirme kitidir (SDK)**.  
Flutter, tek bir kod tabanı kullanarak hem **Android**, hem **iOS**, hem **Web**, hem de **masaüstü** uygulamaları oluşturmanıza olanak tanır.

Flutter'ın temel özellikleri şunlardır:

- **Tek Kod Tabanı**: Android ve iOS için ayrı ayrı kod yazmanıza gerek kalmaz.  
- **Hızlı Geliştirme**: "Hot Reload" özelliği sayesinde yaptığınız değişiklikleri anında görebilirsiniz.  
- **Zengin Widget Kütüphanesi**: Modern ve özelleştirilebilir arayüzler oluşturmanıza yardımcı olan birçok hazır widget sunar.  
- **Performans**: Flutter, uygulamaları doğrudan yerel makine koduna derler, bu sayede yüksek performanslı çalışır.  
- **Açık Kaynak**: Geliştiriciler topluluğu tarafından sürekli desteklenir ve geliştirilir.

---

# Flutter Widget Mantığı

## Widget Nedir?

Flutter’da **widget**, kullanıcı arayüzünün temel yapı taşıdır.  
Ekranda gördüğünüz her şey bir widget’tır: butonlar, metinler, resimler, kutular, satırlar, sütunlar…

Widget’lar **immutable**’dır (değiştirilemez).  
UI değişirse, Flutter yeni bir widget oluşturur ve eski widget ile değiştirir.

---

# Hot Reload Nedir?

**Hot Reload**, Flutter geliştirme sürecinde kullanılan bir özelliktir.  
Uygulama çalışırken **kod değişikliklerini hızlıca uygulamaya yansıtmayı** sağlar.

---

# SharedPreferences Nedir?

**SharedPreferences**, Flutter’da küçük boyutlu veri depolamak için kullanılan bir pakettir.  
Özellikle uygulama kapatılsa bile **basit verileri cihaz üzerinde saklamak** için idealdir.

### Kullanım Amaçları

- Kullanıcının tercihlerinin saklanması (tema seçimi, dil seçimi, vs.)  
- Basit ayarlar ve uygulama durumu bilgileri  
- Kullanıcının girdiği metin veya sayaç gibi küçük verilerin hatırlanması  

### Özellikleri

- **Veri Tipi:** Basit veriler (String, int, double, bool, List<String>)  
- **Kullanım Amacı:** Küçük ve hızlı veri saklama ihtiyacı, örn. ayarlar, kullanıcı tercihleri, token, tema seçimi  
- **Veri Yapısı:** Key-Value (anahtar-değer)  

#### Avantajları

- Kullanımı çok kolay  
- Hızlı erişim sağlar  
- Küçük miktardaki veriler için ideal  

#### Dezavantajları

- Karmaşık veri yapıları için uygun değil  
- Büyük veri saklamak için tasarlanmamış

---

# SQLite Nedir?

**SQLite**, Flutter’da daha karmaşık ve ilişkisel veri yapıları için kullanılan bir veritabanıdır.

### Özellikleri

- **Veri Tipi:** Karmaşık veri yapıları, tablolar ve ilişkili veriler  
- **Kullanım Amacı:** Daha büyük veri setleri, uygulama içi veri depolama (ör. not defteri, görev listesi, ürün listesi)  
- **Veri Yapısı:** Tablo-temelli (SQL sorguları ile erişim)  

#### Avantajları

- Karmaşık ve büyük veri yapıları için uygundur  
- SQL sorguları ile veri yönetimi yapılabilir  
- Offline veri depolama için güçlüdür  

#### Dezavantajları

- Kullanımı SharedPreferences’a göre daha karmaşıktır  
- Küçük ve basit veri saklama için fazla yük getirebilir
