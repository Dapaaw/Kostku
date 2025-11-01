# KostKu - Aplikasi Pemesanan Kos

## Deskripsi

**KostKu** adalah aplikasi mobile pemesanan kos (properti) yang dibangun menggunakan **Flutter**. Aplikasi ini dirancang untuk memudahkan pengguna dalam mencari, melihat detail, menyimpan sebagai favorit, dan "memesan" properti atau kamar kos.

Proyek ini menggunakan **GetX** sebagai *state management* utama untuk mengelola daftar favorit dan daftar kos yang dipesan, serta untuk menangani navigasi antar halaman.


---

## Fitur Utama

Berikut adalah fungsionalitas utama yang ada dalam aplikasi ini:

* **Beranda (Home):**
    * Menampilkan sapaan kepada pengguna dan daftar properti yang dibagi menjadi "Top" (horizontal) dan "Top Nearby" (vertikal).
    * Dilengkapi *search bar* dan filter berdasarkan rentang harga dan lokasi.

* **Sistem Favorit:**
    * Pengguna dapat menekan ikon hati (❤️) pada setiap kartu properti (`PropertyCard` dan `NearbyPropertyCard`) untuk menambahkannya ke daftar favorit.
    * Halaman "Favorite" khusus akan menampilkan semua properti yang telah difavoritkan.
    * Status favorit dikelola secara reaktif oleh `FavoriteController`.

* **Detail Properti:**
    * Setiap properti memiliki halaman detail (`PropertyDetailPage`) yang menampilkan galeri gambar, harga, lokasi, deskripsi, dan fasilitas (jumlah kamar tidur, kamar mandi, dapur).

* **Sistem Booking ("My Kos"):**
    * Pengguna dapat "memesan" properti melalui tombol "Book Now" di halaman detail.
    * Properti yang dipesan akan masuk ke halaman "My Kos" (`MyTripPage`).
    * Daftar ini dikelola oleh `MyKosController`.

* **Navigasi:**
    * Aplikasi menggunakan `BottomNavBar` dengan 4 tab utama: Home, My Kos, Favorite, dan Profile.
    * Menggunakan sistem rute bernama (`AppRoutes`) untuk pengelolaan navigasi yang bersih dan terpusat.

* **Autentikasi:**
    * Proyek ini telah memiliki struktur untuk alur autentikasi dengan adanya `LoginScreen` yang terdaftar di rute `/login`.

  ---

## Arsitektur, Teknologi, & Struktur Folder

### Arsitektur & Teknologi

Proyek ini dibangun dengan arsitektur yang berfokus pada pemisahan antara logika bisnis (logic) dan tampilan (UI). Arsitektur ini difasilitasi oleh *library* GetX.

Teknologi utama yang digunakan adalah:

* **Framework:** **Flutter** (SDK)
* **Bahasa:** **Dart**
* **State Management:** **GetX** (digunakan untuk mengelola *state* aplikasi secara reaktif, seperti `FavoriteController` dan `MyKosController`).
* **Navigasi:** **GetX Navigation** (menggunakan sistem *named routes* yang terpusat di `app_routes.dart` untuk navigasi yang bersih).
* **Formatting:** Package `intl` (digunakan di halaman detail properti untuk memformat harga ke dalam mata uang Rupiah).
* **Data:** Saat ini masih menggunakan **data *dummy*** (model `KosModel` yang di-hardcode secara lokal, terutama di file `home_page.dart`).

### Struktur Folder

Struktur folder utama aplikasi ini dibagi berdasarkan fitur (modul):

* `/modules/auth`
    * Berisi halaman **Login** untuk autentikasi pengguna.

* `/modules/home`
    * Berisi halaman **Beranda (Home)**, **Detail Properti**, dan halaman daftar harga. Ini adalah inti dari aplikasi.

* `/modules/favorite`
    * Berisi halaman **Favorite** yang menampilkan daftar kos yang disukai pengguna.

* `/modules/my_kos`
    * Berisi halaman **My Kos** yang menampilkan daftar kos yang sudah dipesan oleh pengguna.

* `/modules/profile`
    * Berisi halaman **Profile** pengguna.

* `/data/models`
    * Tempat menyimpan logika bisnis (`FavoriteController`, `MyKosController`) dan struktur data (`KosModel`).

* `/app_routes.dart`
    * File pusat untuk mengelola semua rute navigasi aplikasi.

  ---


## ⚙️ Cara Menjalankan

1. Pastikan **Flutter SDK** sudah terpasang.
2. Clone repositori:
   ```bash
   git clone https://github.com/Dapaaw/Kostku.git
3. Masuk ke direktori proyek:
   ```bash
   cd Kostku
4. Ambil semua dependencies:
   ```bash
   flutter pub get
5. Jalankan aplikasi di emulator atau perangkat nyata:
      ```bash
   flutter run
---

## Roadmap & Pengembangan Selanjutnya

Berikut adalah rencana pengembangan untuk membuat aplikasi "KostKu" menjadi aplikasi yang *full-stack* dan siap produksi:

1.  **Integrasi API (Prioritas Utama):**
    * Membangun atau terhubung dengan **Backend REST API** untuk menggantikan semua data *dummy* yang saat ini ada di aplikasi (`home_page.dart`).
    * **Endpoint Properti:** Membuat *endpoint* untuk mengambil daftar kos (`/properties`), detail kos (`/properties/<id>`), dan properti berdasarkan filter (lokasi, harga).
    * **Endpoint Autentikasi:** Menghubungkan `LoginScreen` ke API (`/login`, `/register`) untuk autentikasi pengguna dan manajemen *token* (JWT).

2.  **Sinkronisasi Data Pengguna via API:**
    * Menghubungkan `FavoriteController` ke API. Saat pengguna menekan "favorit", data akan disimpan ke *database* pengguna di *backend*, bukan hanya di *state* lokal GetX.
    * Menghubungkan `MyKosController` ke API untuk menyimpan riwayat *booking* pengguna secara permanen di *database*.

3.  **Fungsionalitas Penuh Fitur yang Ada:**
    * **Search & Filter:** Mengaktifkan *search bar* dan filter (harga, lokasi) agar benar-benar melakukan *query* ke API untuk mendapatkan hasil yang relevan.
    * **Halaman Profile:** Melengkapi halaman profil dengan data pengguna dari API, serta menambahkan fungsionalitas **Edit Profile** dan **Logout** (yang akan menghapus *token*).

4.  **Fitur Baru (Jangka Panjang):**
    * **Proses Booking & Pembayaran:** Mengembangkan alur *booking* yang sebenarnya (pemilihan tanggal, durasi sewa) dan mengintegrasikan *payment gateway* (misalnya Midtrans, Xendit, atau lainnya).
    * **Sistem Review & Rating:** Memungkinkan pengguna untuk memberi ulasan dan *rating* pada properti yang telah mereka pesan.
---
📱 Tampilan Aplikasi
