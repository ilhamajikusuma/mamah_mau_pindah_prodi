-- 1. Inisialisasi Database
CREATE DATABASE IF NOT EXISTS pustakauii;
USE pustakauii;

-- Urutan 1: penerbit[cite: 7, 8, 11, 14]
CREATE TABLE penerbit (
    penerbit_id INT AUTO_INCREMENT NOT NULL,
    nama        VARCHAR(150) NOT NULL,
    kota        VARCHAR(100) NOT NULL,
    PRIMARY KEY (penerbit_id)
) ENGINE=InnoDB;

-- Urutan 2: kategori[cite: 7, 8, 11, 14]
CREATE TABLE kategori (
    kategori_id   INT AUTO_INCREMENT NOT NULL,
    nama_kategori VARCHAR(100) NOT NULL,
    PRIMARY KEY (kategori_id)
) ENGINE=InnoDB;

-- Urutan 3: buku[cite: 7, 8, 11, 13, 14]
CREATE TABLE buku (
    buku_id          INT AUTO_INCREMENT NOT NULL,
    isbn             VARCHAR(20) NOT NULL,
    judul            VARCHAR(150) NOT NULL,
    tahun_terbit     SMALLINT NOT NULL,
    jumlah_eksemplar INT NOT NULL,
    penerbit_id      INT NOT NULL,
    kategori_id      INT NOT NULL,
    PRIMARY KEY (buku_id),
    UNIQUE (isbn),
    CHECK (jumlah_eksemplar >= 0),
    CONSTRAINT fk_buku_penerbit
        FOREIGN KEY (penerbit_id) REFERENCES penerbit(penerbit_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_buku_kategori
        FOREIGN KEY (kategori_id) REFERENCES kategori(kategori_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Urutan 4: pengarang[cite: 7, 8, 11, 14]
CREATE TABLE pengarang (
    pengarang_id INT AUTO_INCREMENT NOT NULL,
    nama         VARCHAR(150) NOT NULL,
    PRIMARY KEY (pengarang_id)
) ENGINE=InnoDB;

-- Urutan 5: buku_pengarang (tabel jembatan)[cite: 7, 8, 11, 14]
CREATE TABLE buku_pengarang (
    buku_id      INT NOT NULL,
    pengarang_id INT NOT NULL,
    PRIMARY KEY (buku_id, pengarang_id),
    CONSTRAINT fk_bukupengarang_buku
        FOREIGN KEY (buku_id) REFERENCES buku(buku_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_bukupengarang_pengarang
        FOREIGN KEY (pengarang_id) REFERENCES pengarang(pengarang_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Urutan 6: anggota[cite: 7, 8, 11, 14]
CREATE TABLE anggota (
    anggota_id     INT AUTO_INCREMENT NOT NULL,
    nim            VARCHAR(20) NOT NULL,
    nama           VARCHAR(150) NOT NULL,
    email          VARCHAR(150) NOT NULL,
    tanggal_daftar DATE NOT NULL,
    jalan          VARCHAR(200) NOT NULL,
    kota           VARCHAR(100) NOT NULL,
    PRIMARY KEY (anggota_id),
    UNIQUE (nim),
    UNIQUE (email)
) ENGINE=InnoDB;

-- Urutan 7: anggota_telepon[cite: 7, 8, 11, 14]
CREATE TABLE anggota_telepon (
    anggota_id INT NOT NULL,
    telepon    VARCHAR(20) NOT NULL,
    PRIMARY KEY (anggota_id, telepon),
    CONSTRAINT fk_anggotatelepon_anggota
        FOREIGN KEY (anggota_id) REFERENCES anggota(anggota_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Urutan 8: kartu (relasi 1:1 dengan anggota)[cite: 7, 9, 11, 14]
CREATE TABLE kartu (
    kartu_id      INT AUTO_INCREMENT NOT NULL,
    nomor_kartu   VARCHAR(30) NOT NULL,
    tanggal_terbit DATE NOT NULL,
    masa_berlaku  DATE NOT NULL,
    anggota_id    INT NOT NULL,
    PRIMARY KEY (kartu_id),
    UNIQUE (nomor_kartu),
    UNIQUE (anggota_id),
    CONSTRAINT fk_kartu_anggota
        FOREIGN KEY (anggota_id) REFERENCES anggota(anggota_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Urutan 9: peminjaman[cite: 7, 9, 11, 14]
CREATE TABLE peminjaman (
    peminjaman_id       INT AUTO_INCREMENT NOT NULL,
    tanggal_pinjam      DATE NOT NULL,
    tanggal_jatuh_tempo DATE NOT NULL,
    anggota_id          INT NOT NULL,
    PRIMARY KEY (peminjaman_id),
    CHECK (tanggal_jatuh_tempo >= tanggal_pinjam),
    CONSTRAINT fk_peminjaman_anggota
        FOREIGN KEY (anggota_id) REFERENCES anggota(anggota_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Urutan 10: detail_peminjaman (tabel jembatan)[cite: 7, 9, 11, 14]
CREATE TABLE detail_peminjaman (
    peminjaman_id   INT NOT NULL,
    buku_id         INT NOT NULL,
    tanggal_kembali DATE NULL,
    denda           DECIMAL(10,2) NOT NULL DEFAULT 0,
    PRIMARY KEY (peminjaman_id, buku_id),
    CHECK (denda >= 0),
    CONSTRAINT fk_detail_peminjaman
        FOREIGN KEY (peminjaman_id) REFERENCES peminjaman(peminjaman_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_detail_buku
        FOREIGN KEY (buku_id) REFERENCES buku(buku_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;