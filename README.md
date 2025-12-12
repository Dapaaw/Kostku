# 🏠 KostKu - Aplikasi Pemesanan Kos Mobile

![Flutter](https://img.shields.io/badge/Flutter-3.9.0-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.9.0-0175C2?logo=dart&logoColor=white)
![GetX](https://img.shields.io/badge/GetX-4.6.6-8B5CF6?logo=flutter&logoColor=white)
![Dio](https://img.shields.io/badge/Dio-5.9.0-00B4AB?logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green)

<div align="center">
  <p><i>Platform pemesanan kos modern dengan UI/UX Klook Theme yang elegan dan responsif</i></p>
</div>

---

## 📱 Tentang Aplikasi

**KostKu** adalah aplikasi mobile berbasis **Flutter** yang dirancang khusus untuk memudahkan pencarian dan pemesanan kos/properti hunian. Aplikasi ini mengusung tema **Klook** dengan warna dominan **Vibrant Orange (#FF5B00)** dan gradient effects yang memberikan pengalaman visual yang menarik dan modern.

### 🎯 Tujuan Aplikasi
- Menyediakan platform yang mudah dan intuitif untuk mencari kos
- Memberikan informasi properti yang lengkap dan akurat
- Memfasilitasi interaksi antara pencari kos dan pemilik
- Menyimpan preferensi dan riwayat pemesanan pengguna
- Memberikan sistem review untuk transparansi kualitas properti

### 🌟 Keunggulan
- ✨ **Modern UI/UX** - Desain mengikuti Material Design 3 dengan Klook theme
- 🚀 **Performa Tinggi** - Menggunakan GetX untuk state management yang efisien
- 🔐 **Aman** - JWT authentication dengan auto-refresh token
- 📱 **Responsive** - Mendukung berbagai ukuran layar
- 🌐 **Real-time** - Sinkronisasi data langsung dengan backend
- 💾 **Offline Support** - Data tersimpan lokal dengan SharedPreferences

---

## ✨ Fitur Lengkap

### 🔐 1. Autentikasi & Manajemen User

#### Login & Register
- Form login dengan validasi email dan password
- Register dengan validasi lengkap (nama, email, password)
- Password visibility toggle untuk keamanan
- Error handling dengan pesan yang jelas
- Auto-redirect setelah login sukses

#### Session Management
- JWT token disimpan di SharedPreferences
- Auto-attach token di setiap API request
- Auto-logout saat token expired (401)
- Redirect otomatis ke login page
- Session persistence setelah app restart

#### Profile Management
- **View Profile**: Menampilkan foto, nama, dan email pengguna
- **Edit Profile**: Update nama dan email dengan validasi
- **Change Password**: Ganti password dengan verifikasi password lama
- **Logout**: Clear session dan redirect ke login

### 🏠 2. Property & Listing

#### Property List
- **Grid View**: Menampilkan properti dalam layout grid
- **Horizontal Scroll**: Properti unggulan di bagian atas
- **Shimmer Effect**: Loading animation yang smooth
- **Lazy Loading**: Load data secara bertahap untuk performa

#### Search & Filter
- **Search Bar**: Pencarian berdasarkan nama properti
- **Location Filter**: Filter berdasarkan lokasi/kota
- **Price Range**: Filter harga minimum dan maksimum
- **Real-time Search**: Update hasil saat mengetik
- **Clear Filter**: Reset filter dengan satu klik

#### Property Detail
- **Image Gallery**: Multiple images dengan horizontal scroll
- **Property Info**: Nama, lokasi, harga per bulan
- **Statistics**: Jumlah kamar tidur, kamar mandi, dapur
- **Description**: Deskripsi lengkap properti
- **Reviews**: List review dari pengguna lain
- **Book Button**: Tombol booking dengan validasi login
- **Back Button**: Navigasi kembali dengan overlay button

### ❤️ 3. Favorite System

#### Add/Remove Favorite
- **Icon Toggle**: Heart icon dengan animasi
- **Real-time Update**: Sinkronisasi langsung dengan backend
- **Visual Feedback**: Snackbar notification
- **Persistent**: Favorite tersimpan di database

#### Favorite Page
- **List View**: Semua properti favorit dalam satu halaman
- **Quick Access**: Akses cepat ke detail properti
- **Empty State**: Pesan ketika belum ada favorit
- **Remove Option**: Hapus dari favorit langsung dari list

### 📝 4. Booking System (My Kos)

#### Book Property
- **Login Required**: Validasi user harus login
- **Confirmation Dialog**: Dialog konfirmasi sebelum booking
- **Success Notification**: Notifikasi setelah booking berhasil
- **Auto Redirect**: Pindah ke My Kos page setelah booking

#### My Kos Page
- **Booking List**: Daftar semua kos yang sudah dipesan
- **Property Info**: Info lengkap properti yang dipesan
- **Review Button**: Tombol untuk memberikan review
- **Empty State**: Pesan ketika belum ada booking

### ⭐ 5. Review & Rating System

#### Add Review
- **Rating Stars**: Rating 1-5 bintang dengan flutter_rating_bar
- **Comment Field**: Text area untuk komentar/ulasan
- **Validation**: Validasi rating dan comment tidak boleh kosong
- **Success Feedback**: Notifikasi setelah review terkirim
- **Back to List**: Kembali ke My Kos setelah review

#### View Reviews
- **Review Card**: Card design untuk setiap review
- **User Info**: Avatar dan nama reviewer
- **Rating Display**: Tampilan rating dalam bentuk bintang
- **Comment**: Komentar lengkap dari reviewer
- **Empty State**: Pesan ketika belum ada review

### 🎨 6. UI/UX & Design System

#### Klook Theme
- **Primary Color**: Vibrant Orange (#FF5B00)
- **Gradient**: Linear gradient dari orange ke pink (#FF3366)
- **Color Palette**:
  - `klookOrange`: #FF5B00
  - `klookOrangeDark`: Darker shade
  - `klookBackground`: #F5F6F8
  - `klookBlack`: #1C1C1C
  - `klookGray`: #888888
  - `klookSoftGray`: #E0E0E0

#### UI Components
- **Auth Header**: Header dengan gradient dan ShaderMask
- **Property Card**: Card dengan shadow, border radius 8
- **Review Card**: Card dengan avatar, rating, dan comment
- **Input Field**: Custom text field dengan Klook style
- **Auth Button**: Primary button dengan gradient background
- **Bottom Navigation**: 4 tabs dengan icon dan label
- **Shimmer Loading**: Loading effect untuk skeleton screen

#### Animations & Transitions
- **Page Transitions**: Smooth navigation animations
- **Button Ripple**: Material ripple effect
- **Icon Animations**: Animated favorite icon
- **Shimmer Effect**: Shimmer animation saat loading
- **Gradient Animation**: Animated gradient backgrounds

### 🌐 7. Networking & API Integration

#### HTTP Client (Dio)
- **Base Configuration**: Configured Dio instance
- **Interceptors**: Request, Response, Error interceptors
- **Auto Token**: Automatic token attachment
- **Error Handling**: Comprehensive error messages
- **Timeout**: Request timeout configuration
- **Retry Logic**: Auto-retry on connection error

#### API Endpoints

**Authentication Endpoints**
```
POST   /api/login           - Login user
POST   /api/register        - Register user baru
POST   /api/logout          - Logout user
GET    /api/user            - Get user profile
PUT    /api/user            - Update user profile
PUT    /api/password        - Change password
```

**Property Endpoints**
```
GET    /api/kos             - Get all properties (with filters)
  Query Params:
  - search: string (nama properti)
  - location: string (lokasi/kota)
  - min_price: number
  - max_price: number
```

**Favorite Endpoints**
```
GET    /api/favorites       - Get user favorites
POST   /api/favorites       - Add to favorites
  Body: { kos_id: number }
DELETE /api/favorites/:id   - Remove from favorites
```

**Review Endpoints**
```
GET    /api/kos/:id/reviews - Get reviews untuk property
POST   /api/reviews         - Add review
  Body: {
    kos_id: number,
    rating: number (1-5),
    comment: string
  }
```

#### Error Handling
- **Connection Error**: Notifikasi tidak ada koneksi
- **401 Unauthorized**: Auto logout dan redirect ke login
- **Validation Error**: Tampilkan pesan validasi dari server
- **Server Error**: Pesan error yang user-friendly
- **Timeout**: Handle request timeout

---

## 🏗️ Arsitektur & Struktur Proyek

### Arsitektur Aplikasi

Aplikasi ini menggunakan **Clean Architecture** dengan pemisahan yang jelas antara:

```
┌─────────────────────────────────────┐
│         Presentation Layer          │
│   (UI - Pages & Widgets)           │
└─────────────┬───────────────────────┘
              │
┌─────────────▼───────────────────────┐
│      Business Logic Layer           │
│   (Controllers - GetX)              │
└─────────────┬───────────────────────┘
              │
┌─────────────▼───────────────────────┐
│         Data Layer                  │
│   (Models & Services)               │
└─────────────────────────────────────┘
```

### Tech Stack

| Kategori | Teknologi | Versi | Fungsi |
|----------|-----------|-------|--------|
| **Framework** | Flutter | 3.9.0 | Cross-platform mobile framework |
| **Language** | Dart | 3.9.0 | Programming language |
| **State Management** | GetX | 4.6.6 | Reactive state management & DI |
| **HTTP Client** | Dio | 5.9.0 | HTTP client dengan interceptor |
| **Storage** | SharedPreferences | 2.5.3 | Local storage (token, user data) |
| **UI Components** | flutter_rating_bar | 4.0.1 | Rating widget |
| **UI Effects** | shimmer | 3.0.0 | Shimmer loading effect |
| **Formatting** | intl | 0.19.0 | Currency & date formatting |
| **HTTP** | http | 1.2.1 | Alternative HTTP client |
| **Icons** | cupertino_icons | 1.0.8 | iOS-style icons |

### Design Patterns

1. **MVC Pattern** (Model-View-Controller)
   - Model: Data models (KosModel, ReviewModel)
   - View: Pages dan Widgets
   - Controller: GetX Controllers

2. **Repository Pattern**
   - ApiService sebagai data source layer
   - Centralized API calls

3. **Singleton Pattern**
   - Dio instance dengan shared configuration
   - AuthController sebagai global state

4. **Observer Pattern**
   - Reactive programming dengan GetX Rx
   - Real-time UI updates

5. **Dependency Injection**
   - GetX dependency injection
   - Controllers registered dengan Get.put()

### 📂 Struktur Folder Detail

```
d:\HOTEL\Kostku\
│
├── android/                    # Android native code
├── ios/                        # iOS native code
├── lib/                        # Main application code
│   │
│   ├── config/                 # Application configuration
│   │   ├── constants.dart      # API URL, constants
│   │   ├── theme.dart          # Klook theme configuration
│   │   └── formatter.dart      # Currency formatter (Rupiah)
│   │
│   ├── data/                   # Data layer
│   │   │
│   │   ├── models/             # Data models & Controllers
│   │   │   ├── kos_model.dart           # Property model
│   │   │   ├── kos_controller.dart      # Property state
│   │   │   ├── favorite_controller.dart # Favorite state
│   │   │   ├── my_kos_controller.dart   # Booking state
│   │   │   ├── review_controller.dart   # Review state
│   │   │   └── auth_controller.dart     # Auth state
│   │   │
│   │   └── services/           # API services
│   │       └── api_service.dart         # REST API client
│   │
│   ├── modules/                # Feature modules (UI)
│   │   │
│   │   ├── auth/               # Authentication module
│   │   │   ├── pages/
│   │   │   │   ├── login_page.dart      # Login screen
│   │   │   │   └── signup_page.dart     # Register screen
│   │   │   └── widgets/
│   │   │       ├── auth_header.dart     # Header with gradient
│   │   │       ├── auth_button.dart     # Primary button
│   │   │       ├── auth_footer.dart     # Footer links
│   │   │       ├── terms_text.dart      # Terms & conditions
│   │   │       └── input_field.dart     # Custom text input
│   │   │
│   │   ├── home/               # Home & Property module
│   │   │   ├── pages/
│   │   │   │   ├── home_page.dart       # Main home screen
│   │   │   │   ├── property_detail_page.dart
│   │   │   │   └── price_list_page.dart
│   │   │   └── widgets/
│   │   │       ├── header.dart          # Home header with gradient
│   │   │       ├── header_cari.dart     # Search & filter bar
│   │   │       ├── top_nearby_header.dart
│   │   │       ├── property_card.dart   # Horizontal property card
│   │   │       ├── nearby_property_card.dart
│   │   │       ├── property_header_info.dart
│   │   │       ├── property_statistics_row.dart
│   │   │       ├── property_image_gallery.dart
│   │   │       ├── property_back_button.dart
│   │   │       ├── property_review_section.dart
│   │   │       ├── review_card.dart     # Review item card
│   │   │       └── bottom_navbar.dart   # Bottom navigation
│   │   │
│   │   ├── favorite/           # Favorite module
│   │   │   └── pages/
│   │   │       └── favorite_page.dart   # Favorite list
│   │   │
│   │   ├── my_kos/             # Booking module
│   │   │   └── pages/
│   │   │       ├── my_kos_page.dart     # Booking list
│   │   │       └── review_page.dart     # Add review
│   │   │
│   │   └── profile/            # Profile module
│   │       └── pages/
│   │           ├── profile_page.dart    # User profile
│   │           ├── edit_profile_page.dart
│   │           └── change_password.dart
│   │
│   ├── routes/                 # Navigation
│   │   └── app_routes.dart     # Centralized routing
│   │
│   └── main.dart               # App entry point
│
├── test/                       # Unit & widget tests
├── pubspec.yaml                # Dependencies
├── analysis_options.yaml       # Linter rules
└── README.md                   # This file
```

### State Management dengan GetX

#### Controllers

1. **AuthController** (`auth_controller.dart`)
   ```dart
   - isLoggedIn: RxBool
   - userName: RxString
   - userEmail: RxString
   - login()
   - register()
   - logout()
   - updateUserProfile()
   - changePassword()
   ```

2. **KosController** (`kos_controller.dart`)
   ```dart
   - kosList: RxList<KosModel>
   - isLoading: RxBool
   - filteredKosList: RxList<KosModel>
   - searchKos()
   - filterByPrice()
   - filterByLocation()
   ```

3. **FavoriteController** (`favorite_controller.dart`)
   ```dart
   - favoritesList: RxList<KosModel>
   - addFavorite()
   - removeFavorite()
   - isFavorite()
   - loadFavorites()
   ```

4. **MyKosController** (`my_kos_controller.dart`)
   ```dart
   - myKosList: RxList<KosModel>
   - addMyKos()
   - removeMyKos()
   - loadMyKos()
   ```

5. **ReviewController** (`review_controller.dart`)
   ```dart
   - reviewList: RxList<ReviewModel>
   - isLoading: RxBool
   - addReview()
   - loadReviews()
   ```

### Navigation Flow

```
Login/Register → Home → Property Detail → Book
                  ↓           ↓
              Favorite    Add Review
                  ↓           ↓
              Profile    My Kos List
```

---

## 🚀 Instalasi & Setup

### Prerequisites

Pastikan Anda sudah menginstall:
- **Flutter SDK** >= 3.9.0 ([Download](https://flutter.dev/docs/get-started/install))
- **Dart SDK** >= 3.9.0 (sudah include di Flutter)
- **Android Studio** atau **VS Code**
- **Android Emulator** atau **iOS Simulator**
- **Git** untuk clone repository

### Langkah Instalasi

#### 1. Clone Repository

```bash
git clone https://github.com/Dapaaw/Kostku.git
cd Kostku
```

#### 2. Install Dependencies

```bash
flutter pub get
```

Output yang diharapkan:
```
Running "flutter pub get" in Kostku...
Resolving dependencies...
+ get 4.6.6
+ dio 5.9.0
+ shared_preferences 2.5.3
...
Got dependencies!
```

#### 3. Konfigurasi API Backend

Edit file `lib/config/constants.dart`:

```dart
class AppConstants {
  // Untuk Android Emulator
  static const String baseUrl = 'http://10.0.2.2:8000/api';
  
  // Untuk iOS Simulator / Real Device
  // static const String baseUrl = 'http://localhost:8000/api';
  // static const String baseUrl = 'http://192.168.1.xxx:8000/api';
  
  // Untuk Production
  // static const String baseUrl = 'https://api.yourdomain.com/api';
  
  static const double defaultPadding = 16.0;
}
```

**Catatan IP Address:**
- `10.0.2.2` → Android Emulator ke localhost
- `localhost` → iOS Simulator
- `192.168.1.xxx` → Real device di jaringan lokal
- Production URL → Server online

#### 4. Verifikasi Setup

```bash
# Check Flutter installation
flutter doctor

# Check available devices
flutter devices

# Run app in debug mode
flutter run

# Run in specific device
flutter run -d <device_id>
```

#### 5. Build untuk Production

**Android APK:**
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

**Android App Bundle (untuk Google Play):**
```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

**iOS (memerlukan Mac):**
```bash
flutter build ios --release
```

---

## 🔧 Konfigurasi Backend API

### Requirements Backend

Backend API harus menyediakan endpoint sesuai dengan spesifikasi berikut:

### Base URL
```
http://your-backend-url:port/api
```

### Authentication

Semua endpoint yang memerlukan autentikasi harus menggunakan:
```
Authorization: Bearer {jwt_token}
```

### Response Format

**Success Response:**
```json
{
  "success": true,
  "message": "Operation successful",
  "data": { ... }
}
```

**Error Response:**
```json
{
  "success": false,
  "message": "Error message",
  "errors": { ... }
}
```

### Endpoint Specifications

#### 1. POST /api/login
**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "user": {
      "id": 1,
      "full_name": "John Doe",
      "email": "user@example.com"
    }
  }
}
```

#### 2. POST /api/register
**Request Body:**
```json
{
  "full_name": "John Doe",
  "email": "user@example.com",
  "password": "password123"
}
```

#### 3. GET /api/kos
**Query Parameters:**
- `search`: string (optional)
- `location`: string (optional)
- `min_price`: number (optional)
- `max_price`: number (optional)

**Response:**
```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "name": "Kos Mawar",
      "location": "Jakarta Selatan",
      "price": 2000000,
      "description": "Kos nyaman dan strategis",
      "bedrooms": 1,
      "bathrooms": 1,
      "kitchen": 1,
      "image_url": "https://...",
      "gallery_image_urls": ["https://...", "https://..."]
    }
  ]
}
```

#### 4. POST /api/favorites
**Request Body:**
```json
{
  "kos_id": 1
}
```

#### 5. POST /api/reviews
**Request Body:**
```json
{
  "kos_id": 1,
  "rating": 5,
  "comment": "Kos sangat bagus dan nyaman"
}
```

### Database Schema (Rekomendasi)

```sql
-- Users table
CREATE TABLE users (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  full_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Kos table
CREATE TABLE kos (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  location VARCHAR(255) NOT NULL,
  price DECIMAL(12,2) NOT NULL,
  description TEXT,
  bedrooms INT DEFAULT 1,
  bathrooms INT DEFAULT 1,
  kitchen INT DEFAULT 1,
  image_url TEXT,
  gallery_image_urls JSON,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Favorites table
CREATE TABLE favorites (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  kos_id BIGINT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (kos_id) REFERENCES kos(id),
  UNIQUE KEY unique_favorite (user_id, kos_id)
);

-- Reviews table
CREATE TABLE reviews (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  kos_id BIGINT NOT NULL,
  user_id BIGINT NOT NULL,
  rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
  comment TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (kos_id) REFERENCES kos(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);
```

---

## 🎨 Theme & Styling Guide

### Color Palette

```dart
// Primary Colors
const Color klookOrange = Color(0xFFFF5B00);      // Main brand color
const Color klookOrangeDark = Color(0xFFE54F00);  // Darker shade

// Background Colors
const Color klookBackground = Color(0xFFF5F6F8);  // App background
const Color klookBlack = Color(0xFF1C1C1C);       // Text primary
const Color klookGray = Color(0xFF888888);        // Text secondary
const Color klookSoftGray = Color(0xFFE0E0E0);    // Borders, dividers

// Gradient
final LinearGradient klookGradient = LinearGradient(
  colors: [
    Color(0xFFFF5B00),  // Orange
    Color(0xFFFF3366),  // Pink
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
```

### Typography

```dart
// Heading
TextStyle(
  fontSize: 26,
  fontWeight: FontWeight.bold,
  color: klookBlack,
)

// Subheading
TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: klookBlack,
)

// Body
TextStyle(
  fontSize: 16,
  color: klookBlack,
)

// Caption
TextStyle(
  fontSize: 14,
  color: klookGray,
)
```

### Component Styles

**Button:**
```dart
ElevatedButton.styleFrom(
  backgroundColor: klookOrange,
  foregroundColor: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
)
```

**Card:**
```dart
Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.05),
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    ],
  ),
)
```

**Input Field:**
```dart
TextField(
  decoration: InputDecoration(
    filled: true,
    fillColor: klookBackground,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    contentPadding: EdgeInsets.symmetric(
      vertical: 14,
      horizontal: 16,
    ),
  ),
)
```

---

## 🧪 Testing

### Run Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/widget_test.dart
```

### Test Structure

```
test/
├── unit/              # Unit tests
│   ├── models/
│   └── controllers/
├── widget/            # Widget tests
│   └── widgets/
└── integration/       # Integration tests
    └── flows/
```

### Example Test

```dart
// test/unit/models/kos_model_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:kos/data/models/kos_model.dart';

void main() {
  test('KosModel should create from JSON', () {
    final json = {
      'id': 1,
      'name': 'Test Kos',
      'price': 2000000,
      // ...
    };
    
    final kos = KosModel.fromJson(json);
    
    expect(kos.id, 1);
    expect(kos.name, 'Test Kos');
    expect(kos.price, 2000000);
  });
}
```

---

## 🐛 Troubleshooting

### Common Issues

#### 1. API Connection Failed

**Problem:**
```
DioException: Connection error
```

**Solution:**
- Pastikan backend server sudah running
- Check IP address di `constants.dart`
- Untuk Android Emulator, gunakan `10.0.2.2` bukan `localhost`
- Untuk iOS Simulator, gunakan `localhost`
- Untuk real device, pastikan dalam satu jaringan WiFi

#### 2. Build Failed

**Problem:**
```
Error: Could not resolve all files for configuration ':app:debugRuntimeClasspath'
```

**Solution:**
```bash
# Clear cache
flutter clean
flutter pub get

# Update dependencies
flutter pub upgrade

# Rebuild
flutter run
```

#### 3. Token Expired

**Problem:**
User langsung logout tanpa sebab

**Solution:**
- Backend harus return status code 401 untuk expired token
- Check interceptor di `api_service.dart`
- Pastikan token refresh logic sudah benar

#### 4. Shimmer Not Working

**Problem:**
Shimmer effect tidak muncul

**Solution:**
```dart
// Pastikan import shimmer package
import 'package:shimmer/shimmer.dart';

// Check isLoading state
Obx(() {
  if (controller.isLoading.value) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: YourWidget(),
    );
  }
  return YourWidget();
})
```

#### 5. Hot Reload Issue

**Problem:**
Hot reload tidak update UI

**Solution:**
- Restart app dengan `R` di terminal
- Stop dan run ulang: `flutter run`
- Clear cache: `flutter clean`

### Debug Mode

Enable debug logging di `api_service.dart`:

```dart
Dio _dio = Dio()
  ..interceptors.add(LogInterceptor(
    request: true,
    responseBody: true,
    error: true,
  ));
```

### Performance Issues

Check performance dengan:
```bash
flutter run --profile
flutter run --release
```

---

## 📚 Best Practices

### Code Style

1. **Naming Conventions**
   ```dart
   // Classes: PascalCase
   class PropertyCard extends StatelessWidget {}
   
   // Variables: camelCase
   final String userName;
   
   // Constants: camelCase with const
   const double defaultPadding = 16.0;
   
   // Private: prefix with _
   void _handleLogin() {}
   ```

2. **File Naming**
   - Use snake_case: `property_card.dart`
   - Match class name: `PropertyCard` → `property_card.dart`

3. **Comments**
   - Gunakan /// untuk documentation
   - Jelaskan logic yang kompleks
   - Avoid obvious comments

### State Management

1. **Controller Initialization**
   ```dart
   // In main.dart or first screen
   Get.put(AuthController());
   Get.put(FavoriteController());
   
   // In widget
   final controller = Get.find<AuthController>();
   ```

2. **Reactive Updates**
   ```dart
   // Wrap with Obx
   Obx(() => Text(controller.userName.value))
   
   // Or use GetBuilder
   GetBuilder<AuthController>(
     builder: (controller) => Text(controller.userName.value),
   )
   ```

### Error Handling

1. **Try-Catch Blocks**
   ```dart
   try {
     final response = await apiService.login(email, password);
     // Handle success
   } on DioException catch (e) {
     // Handle Dio errors
     Get.snackbar('Error', e.message ?? 'Unknown error');
   } catch (e) {
     // Handle other errors
     Get.snackbar('Error', 'Something went wrong');
   }
   ```

2. **User Feedback**
   - Always show loading state
   - Always show success/error message
   - Use snackbar for notifications

### Performance

1. **Lazy Loading**
   ```dart
   ListView.builder(
     itemCount: items.length,
     itemBuilder: (context, index) => ItemWidget(items[index]),
   )
   ```

2. **Image Caching**
   ```dart
   Image.network(
     imageUrl,
     loadingBuilder: (context, child, loadingProgress) {
       if (loadingProgress == null) return child;
       return CircularProgressIndicator();
     },
   )
   ```

---

## 🚀 Deployment

### Android

1. **Generate Keystore**
   ```bash
   keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
   ```

2. **Configure Signing**
   
   Create `android/key.properties`:
   ```properties
   storePassword=your_password
   keyPassword=your_password
   keyAlias=key
   storeFile=path/to/key.jks
   ```

3. **Build Release**
   ```bash
   flutter build apk --release
   flutter build appbundle --release
   ```

### iOS

1. **Open Xcode**
   ```bash
   open ios/Runner.xcworkspace
   ```

2. **Configure Signing**
   - Select Runner → Signing & Capabilities
   - Choose Team
   - Automatic signing

3. **Build**
   ```bash
   flutter build ios --release
   ```

---

## 🤝 Contributing

Kontribusi sangat diterima! Berikut cara berkontribusi:

### Steps

1. **Fork Repository**
   ```bash
   # Click Fork button di GitHub
   ```

2. **Clone Fork**
   ```bash
   git clone https://github.com/YOUR_USERNAME/Kostku.git
   cd Kostku
   ```

3. **Create Branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```

4. **Make Changes**
   - Write clean code
   - Follow style guide
   - Add comments
   - Test your code

5. **Commit**
   ```bash
   git add .
   git commit -m "Add amazing feature"
   ```

6. **Push**
   ```bash
   git push origin feature/amazing-feature
   ```

7. **Pull Request**
   - Go to GitHub
   - Click "New Pull Request"
   - Describe your changes
   - Wait for review

### Contribution Guidelines

- Follow Dart/Flutter style guide
- Write meaningful commit messages
- Add tests for new features
- Update documentation
- One feature per PR

### Code Review Process

1. PR dibuat
2. Automated tests dijalankan
3. Code review oleh maintainer
4. Request changes jika perlu
5. Merge setelah approved

---

## 📋 Roadmap

### ✅ Phase 1: Core Features (Completed)
- [x] Authentication (Login/Register)
- [x] Property listing dengan search & filter
- [x] Property detail page
- [x] Favorite system
- [x] Review & rating
- [x] Profile management
- [x] Klook theme implementation

### 🔄 Phase 2: Enhancement (In Progress)
- [ ] Pagination untuk property list
- [ ] Image caching & optimization
- [ ] Offline mode dengan local database
- [ ] Push notifications
- [ ] Dark mode support

### 🔮 Phase 3: Advanced Features (Planned)
- [ ] Real booking system dengan calendar
- [ ] Payment gateway integration (Midtrans/Xendit)
- [ ] Transaction history
- [ ] In-app chat (user ↔ owner)
- [ ] Google Maps integration
- [ ] Advanced filters (facilities, type, etc)
- [ ] Property comparison
- [ ] Wishlist dengan notes

### 🚀 Phase 4: Optimization (Future)
- [ ] Multi-language (ID/EN)
- [ ] Analytics integration (Firebase)
- [ ] Performance optimization
- [ ] Unit & integration tests (100% coverage)
- [ ] CI/CD pipeline (GitHub Actions)
- [ ] Web version (Flutter Web)
- [ ] Desktop version (Windows/Mac/Linux)

---

## 📊 Project Statistics

- **Total Files**: 50+
- **Lines of Code**: 5000+
- **Controllers**: 5
- **Pages**: 12
- **Widgets**: 25+
- **API Endpoints**: 11
- **Dependencies**: 10

---

## 📖 Documentation

### Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [GetX Documentation](https://pub.dev/packages/get)
- [Dio Documentation](https://pub.dev/packages/dio)
- [Material Design 3](https://m3.material.io/)

### Video Tutorials

- Flutter Basics
- GetX State Management
- REST API Integration
- Klook UI/UX Design

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2025 Dapaaw

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 👥 Team & Credits

### Developer
- **Dapaaw** - Lead Developer
  - GitHub: [@Dapaaw](https://github.com/Dapaaw)
  - Role: Full-stack Flutter Developer

### Design Inspiration
- **Klook** - UI/UX Theme inspiration
- **Material Design 3** - Design system

### Special Thanks
- Flutter Team
- GetX Contributors
- Open Source Community

---

## 📞 Contact & Support

### Get in Touch

- **GitHub**: [@Dapaaw](https://github.com/Dapaaw)
- **Email**: your-email@example.com
- **Project**: [KostKu Repository](https://github.com/Dapaaw/Kostku)

### Report Issues

Jika menemukan bug atau ingin request fitur:
1. Go to [Issues](https://github.com/Dapaaw/Kostku/issues)
2. Click "New Issue"
3. Pilih template (Bug Report / Feature Request)
4. Isi detail dengan lengkap
5. Submit

### Community

- **Discussions**: Untuk pertanyaan umum dan diskusi
- **Pull Requests**: Untuk kontribusi code
- **Issues**: Untuk bug reports dan feature requests

---

## 🎯 Quick Links

- 🏠 [Home](https://github.com/Dapaaw/Kostku)
- 📚 [Documentation](#)
- 🐛 [Issues](https://github.com/Dapaaw/Kostku/issues)
- 🔀 [Pull Requests](https://github.com/Dapaaw/Kostku/pulls)
- 📊 [Project Board](#)
- 🎨 [Design System](#theme--styling-guide)

---

<div align="center">
  
### ⭐ Don't forget to give this project a star! ⭐

**Made with ❤️ using Flutter & Klook Theme 🧡**

*Happy Coding! 🚀*

</div>

---

**Last Updated**: December 12, 2025
**Version**: 1.0.0
**Status**: Active Development
