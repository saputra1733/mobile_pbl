class ActivityModel {
  final int? kegiatanJurusanId;
  final int? kegiatanProgramStudiId;
  final int? suratId;
  final int userId;
  final String namaKegiatan;
  final String deskripsiKegiatan;
  final String lokasiKegiatan;
  final String tanggalMulai;
  final String tanggalSelesai;
  final String statusKegiatan;
  final String penyelenggara;
  final String? suratPenugasan;
  final String createdAt;
  final String updatedAt;
  final List<Jabatan> jabatan;
  final Kegiatan? kegiatan;
  final String? nomerSurat;
  final String? judulSurat;
  final String? fileSurat;
  final String? tanggalSurat;

  ActivityModel({
    this.kegiatanJurusanId,
    this.kegiatanProgramStudiId,
    required this.suratId,
    required this.userId,
    required this.namaKegiatan,
    required this.deskripsiKegiatan,
    required this.lokasiKegiatan,
    required this.tanggalMulai,
    required this.tanggalSelesai,
    required this.statusKegiatan,
    required this.penyelenggara,
    this.suratPenugasan,
    required this.createdAt,
    required this.updatedAt,
    required this.jabatan,
    required this.kegiatan,
    this.nomerSurat,
    this.judulSurat,
    this.fileSurat,
    this.tanggalSurat
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    List<Jabatan> jabatanList = [];
    if (json['jabatan'] != null) {
      jabatanList = List<Jabatan>.from(
          json['jabatan'].map((x) => Jabatan.fromJson(x)));
    }

    return ActivityModel(
      kegiatanJurusanId: json['kegiatan_jurusan_id'],
      kegiatanProgramStudiId: json['kegiatan_program_studi_id'],
      suratId: json['surat_id'],
      userId: json['user_id'],
      namaKegiatan: json['nama_kegiatan_jurusan'] ?? json['nama_kegiatan_program_studi'] ?? '',
      deskripsiKegiatan: json['deskripsi_kegiatan'],
      lokasiKegiatan: json['lokasi_kegiatan'],
      tanggalMulai: json['tanggal_mulai'],
      tanggalSelesai: json['tanggal_selesai'],
      statusKegiatan: json['status_kegiatan'],
      penyelenggara: json['penyelenggara'],
      suratPenugasan: json['surat_penugasan'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      jabatan: jabatanList,
      kegiatan: json['kegiatan'] != null ? Kegiatan.fromJson(json['kegiatan']) : null,
      nomerSurat: json['nomer_surat'],
      judulSurat: json['judul_surat'],
      fileSurat: json['file_surat'],
      tanggalSurat: json['tanggal_surat']
    );
  }
}

class Kegiatan {
  final int? kegiatanProgramStudiId;
  final int? kegiatanJurusanId;
  final int suratId;
  final int userId;
  final String namaKegiatan;
  final String deskripsiKegiatan;
  final String lokasiKegiatan;
  final String tanggalMulai;
  final String tanggalSelesai;
  final String statusKegiatan;
  final String penyelenggara;
  final String? suratPenugasan;
  final String createdAt;
  final String updatedAt;

  Kegiatan({
    this.kegiatanProgramStudiId,
    this.kegiatanJurusanId,
    required this.suratId,
    required this.userId,
    required this.namaKegiatan,
    required this.deskripsiKegiatan,
    required this.lokasiKegiatan,
    required this.tanggalMulai,
    required this.tanggalSelesai,
    required this.statusKegiatan,
    required this.penyelenggara,
    this.suratPenugasan,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Kegiatan.fromJson(Map<String, dynamic> json) {
    return Kegiatan(
      kegiatanProgramStudiId: json['kegiatan_program_studi_id'],
      kegiatanJurusanId: json['kegiatan_jurusan_id'],
      suratId: json['surat_id'],
      userId: json['user_id'],
      namaKegiatan: json['nama_kegiatan_program_studi'] ?? json['nama_kegiatan_jurusan'],
      deskripsiKegiatan: json['deskripsi_kegiatan'],
      lokasiKegiatan: json['lokasi_kegiatan'],
      tanggalMulai: json['tanggal_mulai'],
      tanggalSelesai: json['tanggal_selesai'],
      statusKegiatan: json['status_kegiatan'],
      penyelenggara: json['penyelenggara'],
      suratPenugasan: json['surat_penugasan'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}


class Jabatan {
  final int jabatanId;
  final int userId;
  final int levelId;
  final String jabatan;
  final int? kegiatanLuarInstitusiId;
  final int? kegiatanInstitusiId;
  final int? kegiatanJurusanId;
  final int? kegiatanProgramStudiId;
  final String createdAt;
  final String updatedAt;

  Jabatan({
    required this.jabatanId,
    required this.userId,
    required this.levelId,
    required this.jabatan,
    this.kegiatanLuarInstitusiId,
    this.kegiatanInstitusiId,
    this.kegiatanJurusanId,
    this.kegiatanProgramStudiId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Jabatan.fromJson(Map<String, dynamic> json) {
    return Jabatan(
      jabatanId: json['jabatan_id'],
      userId: json['user_id'],
      levelId: json['level_id'],
      jabatan: json['jabatan'],
      kegiatanLuarInstitusiId: json['kegiatan_luar_institusi_id'],
      kegiatanInstitusiId: json['kegiatan_institusi_id'],
      kegiatanJurusanId: json['kegiatan_jurusan_id'],
      kegiatanProgramStudiId: json['kegiatan_program_studi_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
