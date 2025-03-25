# Video Demo

[![Demo App](https://img.youtube.com/vi/KrOm_Q9ZzZc/0.jpg)](https://youtu.be/KrOm_Q9ZzZc)

## Fitur Utama

| Fitur          | Keterangan                                                               |
| -------------- | ------------------------------------------------------------------------ |
| **Tambah**     | Menambahkan kutipan baru beserta penulisnya                              |
| **Lihat**      | Menampilkan semua kutipan dalam daftar scrollable                        |
| **Edit**       | Memodifikasi kutipan yang sudah ada                                      |
| **Hapus**      | Menghapus kutipan dari daftar                                            |
| **Pengurutan** | Mengurutkan kutipan berdasarkan: terbaru, terlama, atau yang baru diedit |

## Widget yang Digunakan

| Widget                  | Fungsi                                                   |
| ----------------------- | -------------------------------------------------------- |
| `MaterialApp`           | Widget root untuk aplikasi Material Design               |
| `Scaffold`              | Struktur dasar aplikasi dengan app bar dan body          |
| `AppBar`                | Bagian header aplikasi dengan judul dan dropdown sorting |
| `Card`                  | Container untuk setiap kutipan dengan efek elevasi       |
| `TextField`             | Input field untuk menambah/mengedit kutipan              |
| `AlertDialog`           | Popup dialog untuk menambah/mengedit kutipan             |
| `DropdownButton`        | Dropdown opsi pengurutan                                 |
| `FloatingActionButton`  | Tombol untuk menambah kutipan baru                       |
| `TextButton`            | Tombol Edit dan Delete                                   |
| `SingleChildScrollView` | Membuat daftar kutipan bisa di-scroll                    |

## Kelas Kustom

| Kelas       | Jenis            | Deskripsi                                                 |
| ----------- | ---------------- | --------------------------------------------------------- |
| `Quote`     | Model Data       | Mewakili kutipan dengan teks, penulis, dan timestamp      |
| `QuoteCard` | Stateless Widget | Widget kustom untuk menampilkan kartu kutipan dengan aksi |
| `QuoteList` | Stateful Widget  | Widget utama yang mengelola state kutipan                 |

## Operasi CRUD

| Operasi    | Method                     | Lokasi          |
| ---------- | -------------------------- | --------------- |
| **Create** | `_showAddQuoteDialog()`    | Kelas QuoteList |
| **Read**   | `sortedQuotes` getter      | Kelas QuoteList |
| **Update** | `_showUpdateQuoteDialog()` | Kelas QuoteList |
| **Delete** | `_deleteQuote()`           | Kelas QuoteList |

## Opsi Pengurutan

| Opsi               | Deskripsi                                         |
| ------------------ | ------------------------------------------------- |
| `newestFirst`      | Urutkan berdasarkan tanggal dibuat (terbaru dulu) |
| `oldestFirst`      | Urutkan berdasarkan tanggal dibuat (terlama dulu) |
| `recentlyModified` | Urutkan berdasarkan tanggal edit (terbaru dulu)   |
