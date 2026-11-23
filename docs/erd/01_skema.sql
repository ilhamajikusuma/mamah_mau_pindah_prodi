CREATE DATABASE IF NOT EXISTS dentacare DEFAULT CHARACTER SET utf8mb4;
USE dentacare;

CREATE TABLE pengguna (
  pengguna_id   INT AUTO_INCREMENT NOT NULL,
  username      VARCHAR(50)  NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  peran         VARCHAR(20)  NOT NULL,
  PRIMARY KEY (pengguna_id),
  UNIQUE (username),
  CHECK (peran IN ('admin','dokter','resepsionis','pasien'))
) ENGINE=InnoDB;

CREATE TABLE tindakan (
  tindakan_id   INT AUTO_INCREMENT NOT NULL,
  nama_tindakan VARCHAR(100) NOT NULL,
  tarif         DECIMAL(12,2) NOT NULL,
  PRIMARY KEY (tindakan_id),
  UNIQUE (nama_tindakan),
  CHECK (tarif >= 0)
) ENGINE=InnoDB;

CREATE TABLE obat (
  obat_id   INT AUTO_INCREMENT NOT NULL,
  nama_obat VARCHAR(100) NOT NULL,
  satuan    VARCHAR(20)  NOT NULL,
  harga     DECIMAL(12,2) NOT NULL,
  stok      INT NOT NULL DEFAULT 0,
  PRIMARY KEY (obat_id),
  UNIQUE (nama_obat),
  CHECK (harga >= 0),
  CHECK (stok >= 0)
) ENGINE=InnoDB;

CREATE TABLE asuransi (
  asuransi_id   INT AUTO_INCREMENT NOT NULL,
  nama_asuransi VARCHAR(100) NOT NULL,
  PRIMARY KEY (asuransi_id),
  UNIQUE (nama_asuransi)
) ENGINE=InnoDB;

CREATE TABLE pasien (
  pasien_id     INT AUTO_INCREMENT NOT NULL,
  pengguna_id   INT NULL,
  no_rm         VARCHAR(20)  NOT NULL,
  nik           CHAR(16)     NOT NULL,
  nama          VARCHAR(100) NOT NULL,
  tanggal_lahir DATE         NOT NULL,
  telepon       VARCHAR(20)  NOT NULL,
  alamat        VARCHAR(255) NULL,
  PRIMARY KEY (pasien_id),
  UNIQUE (pengguna_id),
  UNIQUE (no_rm),
  UNIQUE (nik),
  CONSTRAINT fk_pasien_pengguna
    FOREIGN KEY (pengguna_id) REFERENCES pengguna(pengguna_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE dokter (
  dokter_id    INT AUTO_INCREMENT NOT NULL,
  pengguna_id  INT NOT NULL,
  no_str       VARCHAR(30)  NOT NULL,
  nama         VARCHAR(100) NOT NULL,
  spesialisasi VARCHAR(50)  NULL,
  PRIMARY KEY (dokter_id),
  UNIQUE (pengguna_id),
  UNIQUE (no_str),
  CONSTRAINT fk_dokter_pengguna
    FOREIGN KEY (pengguna_id) REFERENCES pengguna(pengguna_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE jadwal_praktik (
  jadwal_id   INT AUTO_INCREMENT NOT NULL,
  dokter_id   INT NOT NULL,
  hari        VARCHAR(10) NOT NULL,
  jam_mulai   TIME NOT NULL,
  jam_selesai TIME NOT NULL,
  PRIMARY KEY (jadwal_id),
  UNIQUE (dokter_id, hari, jam_mulai),
  CHECK (hari IN ('Senin','Selasa','Rabu','Kamis','Jumat','Sabtu','Minggu')),
  CHECK (jam_selesai > jam_mulai),
  CONSTRAINT fk_jadwal_dokter
    FOREIGN KEY (dokter_id) REFERENCES dokter(dokter_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE kunjungan (
  kunjungan_id  INT AUTO_INCREMENT NOT NULL,
  pasien_id     INT NOT NULL,
  dokter_id     INT NOT NULL,
  tanggal       DATE NOT NULL,
  jam           TIME NOT NULL,
  nomor_antrean INT NULL,
  status        VARCHAR(15) NOT NULL DEFAULT 'terjadwal',
  PRIMARY KEY (kunjungan_id),
  CHECK (nomor_antrean IS NULL OR nomor_antrean > 0),
  CHECK (status IN ('terjadwal','menunggu','diperiksa','selesai','batal')),
  CONSTRAINT fk_kunjungan_pasien
    FOREIGN KEY (pasien_id) REFERENCES pasien(pasien_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_kunjungan_dokter
    FOREIGN KEY (dokter_id) REFERENCES dokter(dokter_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE pengingat (
  pengingat_id INT AUTO_INCREMENT NOT NULL,
  kunjungan_id INT NOT NULL,
  waktu_kirim  DATETIME NOT NULL,
  saluran      VARCHAR(20) NOT NULL,
  status_kirim VARCHAR(15) NOT NULL DEFAULT 'menunggu',
  PRIMARY KEY (pengingat_id),
  CHECK (saluran IN ('whatsapp','sms','email')),
  CHECK (status_kirim IN ('menunggu','terkirim','gagal')),
  CONSTRAINT fk_pengingat_kunjungan
    FOREIGN KEY (kunjungan_id) REFERENCES kunjungan(kunjungan_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE rekam_medis (
  rekam_id     INT AUTO_INCREMENT NOT NULL,
  kunjungan_id INT NOT NULL,
  keluhan      TEXT NOT NULL,
  diagnosis    TEXT NULL,
  catatan      TEXT NULL,
  PRIMARY KEY (rekam_id),
  UNIQUE (kunjungan_id),
  CONSTRAINT fk_rekam_kunjungan
    FOREIGN KEY (kunjungan_id) REFERENCES kunjungan(kunjungan_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE detail_tindakan (
  kunjungan_id INT NOT NULL,
  tindakan_id  INT NOT NULL,
  jumlah       INT NOT NULL DEFAULT 1,
  harga_satuan DECIMAL(12,2) NOT NULL,
  PRIMARY KEY (kunjungan_id, tindakan_id),
  CHECK (jumlah > 0),
  CHECK (harga_satuan >= 0),
  CONSTRAINT fk_detail_tindakan_kunjungan
    FOREIGN KEY (kunjungan_id) REFERENCES kunjungan(kunjungan_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_detail_tindakan_tindakan
    FOREIGN KEY (tindakan_id) REFERENCES tindakan(tindakan_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE resep (
  kunjungan_id INT NOT NULL,
  obat_id      INT NOT NULL,
  jumlah       INT NOT NULL,
  aturan_pakai VARCHAR(100) NOT NULL,
  PRIMARY KEY (kunjungan_id, obat_id),
  CHECK (jumlah > 0),
  CONSTRAINT fk_resep_kunjungan
    FOREIGN KEY (kunjungan_id) REFERENCES kunjungan(kunjungan_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_resep_obat
    FOREIGN KEY (obat_id) REFERENCES obat(obat_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE tagihan (
  tagihan_id     INT AUTO_INCREMENT NOT NULL,
  kunjungan_id   INT NOT NULL,
  tanggal_terbit DATE NOT NULL,
  PRIMARY KEY (tagihan_id),
  UNIQUE (kunjungan_id),
  CONSTRAINT fk_tagihan_kunjungan
    FOREIGN KEY (kunjungan_id) REFERENCES kunjungan(kunjungan_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE pembayaran (
  pembayaran_id INT AUTO_INCREMENT NOT NULL,
  tagihan_id    INT NOT NULL,
  tanggal_bayar DATE NOT NULL,
  jumlah_bayar  DECIMAL(12,2) NOT NULL,
  metode        VARCHAR(20) NOT NULL,
  PRIMARY KEY (pembayaran_id),
  CHECK (jumlah_bayar > 0),
  CHECK (metode IN ('tunai','transfer','kartu','qris')),
  CONSTRAINT fk_pembayaran_tagihan
    FOREIGN KEY (tagihan_id) REFERENCES tagihan(tagihan_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE polis (
  polis_id    INT AUTO_INCREMENT NOT NULL,
  pasien_id   INT NOT NULL,
  asuransi_id INT NOT NULL,
  nomor_polis VARCHAR(50) NOT NULL,
  PRIMARY KEY (polis_id),
  UNIQUE (nomor_polis),
  CONSTRAINT fk_polis_pasien
    FOREIGN KEY (pasien_id) REFERENCES pasien(pasien_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_polis_asuransi
    FOREIGN KEY (asuransi_id) REFERENCES asuransi(asuransi_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE klaim_asuransi (
  klaim_id      INT AUTO_INCREMENT NOT NULL,
  tagihan_id    INT NOT NULL,
  polis_id      INT NOT NULL,
  jumlah_klaim  DECIMAL(12,2) NOT NULL,
  status_klaim  VARCHAR(15) NOT NULL DEFAULT 'diajukan',
  tanggal_ajuan DATE NOT NULL,
  PRIMARY KEY (klaim_id),
  CHECK (jumlah_klaim > 0),
  CHECK (status_klaim IN ('diajukan','disetujui','ditolak','dibayar')),
  CONSTRAINT fk_klaim_tagihan
    FOREIGN KEY (tagihan_id) REFERENCES tagihan(tagihan_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_klaim_polis
    FOREIGN KEY (polis_id) REFERENCES polis(polis_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;
