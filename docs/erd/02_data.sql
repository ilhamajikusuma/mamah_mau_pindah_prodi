USE dentacare;

-- 1. pengguna
INSERT INTO pengguna (pengguna_id, username, password_hash, peran) VALUES
(1, 'admin_utama',   '$2y$10$hashadmin001',   'admin'),
(2, 'resepsionis1',  '$2y$10$hashresep001',   'resepsionis'),
(3, 'drg_nadia',     '$2y$10$hashdokter001',  'dokter'),
(4, 'drg_farhan',    '$2y$10$hashdokter002',  'dokter'),
(5, 'drg_clara',     '$2y$10$hashdokter003',  'dokter'),
(6, 'drg_bagas',     '$2y$10$hashdokter004',  'dokter'),
(7, 'drg_sinta',     '$2y$10$hashdokter005',  'dokter'),
(8, 'pasien_andi',   '$2y$10$hashpasien001',  'pasien'),
(9, 'pasien_bella',  '$2y$10$hashpasien002',  'pasien'),
(10, 'pasien_citra', '$2y$10$hashpasien003',  'pasien');

-- 2. tindakan
INSERT INTO tindakan (tindakan_id, nama_tindakan, tarif) VALUES
(1, 'Konsultasi & Pemeriksaan Umum', 100000.00),
(2, 'Scaling Karang Gigi',           250000.00),
(3, 'Tambal Gigi Komposit',          350000.00),
(4, 'Pencabutan Gigi Bungsu',        850000.00),
(5, 'Pemasangan Implan Gigi',       4500000.00);

-- 3. obat
INSERT INTO obat (obat_id, nama_obat, satuan, harga, stok) VALUES
(1, 'Amoxicillin 500mg',     'Strip', 15000.00, 50),
(2, 'Asam Mefenamat 500mg',  'Strip', 12000.00, 60),
(3, 'Paracetamol 500mg',     'Strip',  8000.00, 80),
(4, 'Clindamycin 300mg',     'Strip', 28000.00, 30),
(5, 'Chlorhexidine Kumur',   'Botol', 35000.00, 25);

-- 4. asuransi
INSERT INTO asuransi (asuransi_id, nama_asuransi) VALUES
(1, 'BPJS Kesehatan'),
(2, 'Prudential Dental Care'),
(3, 'Allianz SmartHealth'),
(4, 'AXA Mandiri'),
(5, 'Manulife ProHealth');

-- 5. pasien
INSERT INTO pasien (pasien_id, pengguna_id, no_rm, nik, nama, tanggal_lahir, telepon, alamat) VALUES
(1, 8,    'RM-2026-001', '3404011205980001', 'Andi Saputra',   '1998-05-12', '081234560001', 'Jl. Kaliurang Km 10, Sleman'),
(2, 9,    'RM-2026-002', '3404022308000002', 'Bella Maharani', '2000-08-23', '081234560002', 'Jl. Gejayan No. 15, Sleman'),
(3, 10,   'RM-2026-003', '3471031411950003', 'Citra Dewi',     '1995-11-14', '081234560003', 'Jl. Tamansiswa No. 8, Yogyakarta'),
(4, NULL, 'RM-2026-004', '3402040502920004', 'Dimas Pratama',  '1992-02-05', '081234560004', 'Jl. Bantul Km 5, Bantul'),
(5, NULL, 'RM-2026-005', '3404051907010005', 'Eko Prasetyo',   '2001-07-19', '081234560005', NULL);

-- 6. dokter
INSERT INTO dokter (dokter_id, pengguna_id, no_str, nama, spesialisasi) VALUES
(1, 3, 'STR-3401-001', 'drg. Nadia Putri, Sp.KG',  'Konservasi Gigi'),
(2, 4, 'STR-3401-002', 'drg. Farhan Hakim, Sp.BM', 'Bedah Mulut'),
(3, 5, 'STR-3401-003', 'drg. Clara Wijaya',        'Dokter Gigi Umum'),
(4, 6, 'STR-3401-004', 'drg. Bagas Santoso, Sp.Ort','Ortodonti'),
(5, 7, 'STR-3401-005', 'drg. Sinta Lestari',       NULL);

-- 7. jadwal_praktik
INSERT INTO jadwal_praktik (jadwal_id, dokter_id, hari, jam_mulai, jam_selesai) VALUES
(1, 1, 'Senin',  '09:00:00', '14:00:00'),
(2, 2, 'Selasa', '10:00:00', '15:00:00'),
(3, 3, 'Rabu',   '08:00:00', '13:00:00'),
(4, 4, 'Kamis',  '13:00:00', '18:00:00'),
(5, 5, 'Jumat',  '09:00:00', '12:00:00');

-- 8. kunjungan
INSERT INTO kunjungan (kunjungan_id, pasien_id, dokter_id, tanggal, jam, nomor_antrean, status) VALUES
(1, 1, 1, '2026-11-02', '09:30:00', 1,    'selesai'),
(2, 2, 3, '2026-11-04', '08:30:00', 1,    'selesai'),
(3, 1, 2, '2026-11-10', '10:30:00', 1,    'selesai'),
(4, 3, 1, '2026-11-16', '10:00:00', 2,    'selesai'),
(5, 4, 3, '2026-11-18', '09:15:00', 1,    'selesai'),
(6, 2, 1, '2026-11-30', '11:00:00', NULL, 'terjadwal');

-- 9. pengingat
INSERT INTO pengingat (pengingat_id, kunjungan_id, waktu_kirim, saluran, status_kirim) VALUES
(1, 1, '2026-11-01 09:00:00', 'whatsapp', 'terkirim'),
(2, 2, '2026-11-03 08:00:00', 'whatsapp', 'terkirim'),
(3, 3, '2026-11-09 10:00:00', 'email',    'terkirim'),
(4, 4, '2026-11-15 10:00:00', 'sms',      'gagal'),
(5, 6, '2026-11-29 11:00:00', 'whatsapp', 'menunggu');

-- 10. rekam_medis
INSERT INTO rekam_medis (rekam_id, kunjungan_id, keluhan, diagnosis, catatan) VALUES
(1, 1, 'Gigi geraham kanan bawah ngilu saat minum dingin', 'Karies dentin gigi 46',      'Hindari makanan terlalu keras 24 jam'),
(2, 2, 'Gusi sering berdarah saat menyikat gigi',          'Gingivitis kronis & kalkulus','Kontrol ulang 6 bulan ke depan'),
(3, 3, 'Gigi bungsu kiri bawah bengkak dan nyeri',        'Impaksi gigi 38 kelas II',   'Rekomendasi odontektomi & kompres dingin'),
(4, 4, 'Tambalan lama gigi depan lepas',                   'Fraktur restorasi gigi 11',  NULL),
(5, 5, 'Karang gigi menumpuk dan bau mulut',               'Kalkulus supragingiva',      'Edukasi teknik menyikat gigi Bass');

-- 11. detail_tindakan
INSERT INTO detail_tindakan (kunjungan_id, tindakan_id, jumlah, harga_satuan) VALUES
(1, 1, 1, 100000.00),
(1, 3, 1, 350000.00),
(2, 1, 1, 100000.00),
(2, 2, 1, 250000.00),
(3, 1, 1, 100000.00),
(3, 4, 1, 850000.00),
(4, 3, 2, 350000.00),
(5, 2, 1, 250000.00);

-- 12. resep
INSERT INTO resep (kunjungan_id, obat_id, jumlah, aturan_pakai) VALUES
(1, 2, 1, '3x1 sesudah makan bila nyeri'),
(1, 3, 1, '3x1 sesudah makan bila demam'),
(2, 3, 1, '3x1 sesudah makan'),
(3, 1, 2, '3x1 sesudah makan sampai habis'),
(3, 2, 1, '3x1 sesudah makan'),
(3, 4, 1, '2x1 sesudah makan'),
(4, 3, 1, '3x1 bila ngilu'),
(5, 2, 1, '3x1 bila gusi nyeri');

-- 13. tagihan
INSERT INTO tagihan (tagihan_id, kunjungan_id, tanggal_terbit) VALUES
(1, 1, '2026-11-02'),
(2, 2, '2026-11-04'),
(3, 3, '2026-11-10'),
(4, 4, '2026-11-16'),
(5, 5, '2026-11-18');

-- 14. pembayaran
INSERT INTO pembayaran (pembayaran_id, tagihan_id, tanggal_bayar, jumlah_bayar, metode) VALUES
(1, 1, '2026-11-02', 470000.00, 'qris'),
(2, 2, '2026-11-04', 158000.00, 'tunai'),
(3, 3, '2026-11-10', 220000.00, 'transfer'),
(4, 4, '2026-11-16', 708000.00, 'kartu'),
(5, 5, '2026-11-18', 262000.00, 'qris');

-- 15. polis
INSERT INTO polis (polis_id, pasien_id, asuransi_id, nomor_polis) VALUES
(1, 1, 2, 'PRU-2026-88901'),
(2, 2, 1, 'BPJS-0001928374'),
(3, 3, 3, 'ALZ-2026-55412'),
(4, 4, 4, 'AXA-2026-77123'),
(5, 1, 1, 'BPJS-0001928399');

-- 16. klaim_asuransi
INSERT INTO klaim_asuransi (klaim_id, tagihan_id, polis_id, jumlah_klaim, status_klaim, tanggal_ajuan) VALUES
(1, 2, 2, 200000.00, 'dibayar',   '2026-11-04'),
(2, 3, 1, 800000.00, 'disetujui', '2026-11-10'),
(3, 1, 5, 150000.00, 'ditolak',   '2026-11-03'),
(4, 4, 3, 350000.00, 'diajukan',  '2026-11-16'),
(5, 5, 4, 100000.00, 'diajukan',  '2026-11-18');