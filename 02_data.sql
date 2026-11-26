-- 02_data.sql  PustakaUII, data contoh untuk P21
-- Jalankan setelah 01_skema.sql dari P20, pada basis data yang masih kosong.
USE pustakauii;

INSERT INTO penerbit (penerbit_id, nama, kota) VALUES
 (1, 'Informatika Press', 'Bandung'),
 (2, 'Nusantara', 'Yogyakarta'),
 (3, 'Andi Offset', 'Yogyakarta');

INSERT INTO kategori (kategori_id, nama_kategori) VALUES
 (1, 'Komputer'), (2, 'Sejarah'), (3, 'Sastra');

INSERT INTO buku (buku_id, isbn, judul, tahun_terbit, jumlah_eksemplar, penerbit_id, kategori_id) VALUES
 (1, '978-1', 'Basis Data', 2022, 3, 1, 1),
 (2, '978-2', 'Algoritma', 2021, 2, 1, 1),
 (3, '978-3', 'Sejarah Islam', 2019, 1, 2, 2),
 (4, '978-4', 'Pemrograman Web', 2024, 4, 3, 1),
 (5, '978-5', 'Laskar Kata', 2018, 2, 2, 3),
 (6, '978-6', 'Jaringan Komputer', 2023, 2, 3, 1),
 (7, '978-7', 'Kerajaan Mataram', 2020, 1, 2, 2),
 (8, '978-8', 'Puisi Senja', 2017, 1, 3, 3);

INSERT INTO pengarang (pengarang_id, nama) VALUES
 (1, 'Ahmad Fauzi'), (2, 'Siti Rahma'), (3, 'Budi Santoso'),
 (4, 'Dewi Lestari'), (5, 'Hasan Basri'), (6, 'Rudi Hartono');

INSERT INTO buku_pengarang (buku_id, pengarang_id) VALUES
 (1, 1), (1, 2), (2, 3), (3, 5), (4, 1), (4, 3),
 (5, 4), (6, 6), (7, 5), (8, 4);

INSERT INTO anggota (anggota_id, nim, nama, email, tanggal_daftar, jalan, kota) VALUES
 (1, '2301001', 'Rina', 'rina@uii.ac.id', '2026-09-01', 'Jl. Kaliurang 14', 'Sleman'),
 (2, '2301002', 'Doni', 'doni@uii.ac.id', '2026-09-01', 'Jl. Gejayan 3', 'Sleman'),
 (3, '2301003', 'Sari', 'sari@uii.ac.id', '2026-09-05', 'Jl. Parangtritis 21', 'Bantul'),
 (4, '2301004', 'Bayu', 'bayu@uii.ac.id', '2026-09-10', NULL, NULL),
 (5, '2301005', 'Lina', 'lina@uii.ac.id', '2026-10-02', 'Jl. Magelang 7', 'Sleman');

INSERT INTO anggota_telepon (anggota_id, telepon) VALUES
 (1, '081200000001'), (1, '081300000001'), (2, '081200000002'), (3, '081200000003');

INSERT INTO kartu (kartu_id, nomor_kartu, tanggal_terbit, masa_berlaku, anggota_id) VALUES
 (1, 'K-0001', '2026-09-02', '2027-09-02', 1),
 (2, 'K-0002', '2026-09-02', '2027-09-02', 2),
 (3, 'K-0003', '2026-09-06', '2027-09-06', 3);

INSERT INTO peminjaman (peminjaman_id, tanggal_pinjam, tanggal_jatuh_tempo, anggota_id) VALUES
 (1, '2026-10-01', '2026-10-07', 1),
 (2, '2026-10-03', '2026-10-10', 2),
 (3, '2026-10-05', '2026-10-12', 1),
 (4, '2026-10-12', '2026-10-19', 3),
 (5, '2026-10-20', '2026-10-27', 2),
 (6, '2026-11-02', '2026-11-09', 3);

INSERT INTO detail_peminjaman (peminjaman_id, buku_id, tanggal_kembali, denda) VALUES
 (1, 1, '2026-10-07', 0),
 (1, 2, '2026-10-12', 5000),
 (2, 1, '2026-10-10', 0),
 (3, 3, NULL, 0),
 (4, 4, '2026-10-18', 0),
 (4, 1, '2026-10-22', 3000),
 (5, 4, '2026-10-25', 0),
 (5, 6, '2026-11-01', 5000),
 (6, 4, NULL, 0),
 (6, 5, '2026-11-08', 0);
