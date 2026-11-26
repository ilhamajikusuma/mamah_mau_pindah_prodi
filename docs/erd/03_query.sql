USE dentacare;

-- Query 1
-- Pertanyaan bisnis: Menampilkan daftar seluruh jadwal kunjungan pasien beserta nama pasien, nama dokter pemeriksa, dan status kunjungannya.
-- Halaman/fitur    : Halaman Manajemen Kunjungan & Antrean
-- Jumlah baris     : 6 baris
SELECT k.kunjungan_id,
       k.tanggal,
       k.jam,
       k.nomor_antrean,
       p.no_rm,
       p.nama AS nama_pasien,
       d.nama AS nama_dokter,
       k.status
FROM kunjungan k
JOIN pasien p ON k.pasien_id = p.pasien_id
JOIN dokter d ON k.dokter_id = d.dokter_id
ORDER BY k.tanggal DESC, k.jam ASC;

-- Query 2
-- Pertanyaan bisnis: Menampilkan daftar tindakan medis yang belum pernah dipilih dalam transaksi kunjungan mana pun.
-- Halaman/fitur    : Halaman Laporan Evaluasi Layanan
-- Jumlah baris     : 1 baris
SELECT t.tindakan_id,
       t.nama_tindakan,
       t.tarif
FROM tindakan t
LEFT JOIN detail_tindakan dt ON t.tindakan_id = dt.tindakan_id
WHERE dt.tindakan_id IS NULL;

-- Query 3
-- Pertanyaan bisnis: Menampilkan rekap dokter yang sudah menangani lebih dari 1 kunjungan selesai beserta total kunjungannya.
-- Halaman/fitur    : Dashboard Statistik Kinerja Dokter
-- Jumlah baris     : 2 baris
SELECT d.dokter_id,
       d.nama AS nama_dokter,
       d.spesialisasi,
       COUNT(k.kunjungan_id) AS total_kunjungan
FROM dokter d
JOIN kunjungan k ON d.dokter_id = k.dokter_id
WHERE k.status = 'selesai'
GROUP BY d.dokter_id, d.nama, d.spesialisasi
HAVING COUNT(k.kunjungan_id) > 1
ORDER BY total_kunjungan DESC;

-- Query 4
-- Pertanyaan bisnis: Menampilkan daftar tindakan medis yang tarifnya lebih mahal daripada rata-rata tarif seluruh tindakan di klinik.
-- Halaman/fitur    : Katalog Tarif Layanan Premium
-- Jumlah baris     : 1 baris
SELECT tindakan_id,
       nama_tindakan,
       tarif
FROM tindakan
WHERE tarif > (SELECT AVG(tarif) FROM tindakan)
ORDER BY tarif DESC;

-- Query 5
-- Pertanyaan bisnis: Menampilkan riwayat rekam medis lengkap pasien bernama Andi Saputra beserta keluhan, diagnosis, tindakan yang dilakukan, dan dokter pemeriksa.
-- Halaman/fitur    : Halaman Detail Rekam Medis Pasien
-- Jumlah baris     : 4 baris
SELECT p.no_rm,
       p.nama AS nama_pasien,
       k.tanggal,
       d.nama AS nama_dokter,
       rm.keluhan,
       rm.diagnosis,
       t.nama_tindakan,
       dt.jumlah
FROM pasien p
JOIN kunjungan k ON p.pasien_id = k.pasien_id
JOIN dokter d ON k.dokter_id = d.dokter_id
JOIN rekam_medis rm ON k.kunjungan_id = rm.kunjungan_id
JOIN detail_tindakan dt ON k.kunjungan_id = dt.kunjungan_id
JOIN tindakan t ON dt.tindakan_id = t.tindakan_id
WHERE p.nama = 'Andi Saputra'
ORDER BY k.tanggal ASC;

-- Query 6
-- Pertanyaan bisnis: Menampilkan rincian tagihan, total biaya tindakan, pembayaran pasien, dan status klaim asuransi untuk setiap kunjungan yang sudah ditagih.
-- Halaman/fitur    : Halaman Kasir & Klaim Asuransi
-- Jumlah baris     : 5 baris
SELECT tg.tagihan_id,
       k.tanggal AS tanggal_kunjungan,
       p.nama AS nama_pasien,
       SUM(dt.jumlah * dt.harga_satuan) AS total_biaya_tindakan,
       pb.jumlah_bayar AS dibayar_pasien,
       pb.metode,
       ka.jumlah_klaim,
       ka.status_klaim
FROM tagihan tg
JOIN kunjungan k ON tg.kunjungan_id = k.kunjungan_id
JOIN pasien p ON k.pasien_id = p.pasien_id
JOIN detail_tindakan dt ON k.kunjungan_id = dt.kunjungan_id
LEFT JOIN pembayaran pb ON tg.tagihan_id = pb.tagihan_id
LEFT JOIN klaim_asuransi ka ON tg.tagihan_id = ka.tagihan_id
GROUP BY tg.tagihan_id, k.tanggal, p.nama, pb.jumlah_bayar, pb.metode, ka.jumlah_klaim, ka.status_klaim
ORDER BY tg.tagihan_id ASC;