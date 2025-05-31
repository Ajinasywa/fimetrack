import 'package:flutter/material.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 40,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image, size: 40);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Edukasi',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF7B9C),
                  ),
                ),
                const SizedBox(height: 24),
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.75,
                  children: [
                    _EducationCard(
                      title: 'Obat-obatan',
                      image: 'assets/images/edukasi1.jpeg',
                      onTap: () => _showArticle(
                        context,
                        'Obat-obatan untuk Mengatasi Nyeri Haid',
                        '''Berikut adalah panduan lengkap tentang obat-obatan yang dapat membantu meredakan nyeri haid:

OBAT-OBATAN MEDIS:

1. Paracetamol
• Obat pereda nyeri yang umum dan dapat dibeli bebas di apotek
• Dosis disesuaikan dengan berat badan dan usia
• Aman dikonsumsi untuk nyeri ringan

2. Ibuprofen
• Lebih efektif untuk nyeri sedang hingga berat
• Sebaiknya dikonsumsi setelah makan untuk mengurangi risiko sakit perut
• Termasuk obat antiinflamasi nonsteroid (NSAID)

3. Aspirin
• Efektif untuk nyeri haid ringan hingga sedang
• Termasuk obat antiinflamasi nonsteroid (OAINS)
• Sebaiknya dikonsumsi setelah makan
• Hindari jika memiliki masalah pembekuan darah

4. Asam Mefenamat
• Efektif untuk nyeri haid ringan hingga sedang
• Bekerja dengan menghambat produksi prostaglandin
• Konsumsi sesuai anjuran dokter

5. Naproxen
• Diresepkan dokter jika nyeri tidak mereda dengan ibuprofen/aspirin
• Dosisnya harus sesuai resep dokter
• Efektif untuk nyeri berat

OBAT HERBAL:

1. Jahe
• Dapat dikonsumsi dalam bentuk teh atau minuman
• Memiliki efek anti-inflamasi alami
• Membantu melancarkan peredaran darah

2. Teh Peppermint
• Membantu meredakan kram dan nyeri
• Memiliki efek menenangkan
• Dapat diminum beberapa kali sehari

3. Teh Chamomile
• Membantu meredakan nyeri dan kram perut
• Memiliki efek relaksasi
• Aman dikonsumsi sebelum tidur

4. Biji Adas
• Mengandung senyawa nitrit
• Membantu melancarkan sirkulasi darah dalam rahim
• Dapat dikonsumsi dalam bentuk teh

PENTING UNTUK DIINGAT:

• Konsumsi obat sesuai dosis yang direkomendasikan
• Konsultasikan dengan dokter jika memiliki kondisi medis tertentu
• Konsultasikan jika sedang mengonsumsi obat-obatan lain
• Perbanyak minum air putih
• Istirahat yang cukup
• Konsumsi makanan bergizi
• Segera ke dokter jika nyeri sangat berat dan mengganggu aktivitas''',
                      ),
                    ),
                    _EducationCard(
                      title: 'Aktivitas & olahraga',
                      image: 'assets/images/edukasi2.jpeg',
                      onTap: () => _showArticle(
                        context,
                        'Aktivitas & Olahraga yang Aman Saat Haid',
                        '''Olahraga saat haid tetap bisa dilakukan dengan memperhatikan jenis dan intensitasnya. Berikut panduan lengkapnya:

OLAHRAGA YANG DISARANKAN:

1. Jalan Santai
• Olahraga ringan yang aman
• Membantu melancarkan sirkulasi darah
• Efektif meredakan kram perut
• Bisa dilakukan 15-30 menit sehari

2. Bersepeda
• Aktivitas kardio yang tidak terlalu berat
• Membantu mengurangi rasa nyeri menstruasi
• Pilih rute yang datar dan nyaman
• Sesuaikan kecepatan dengan kondisi tubuh

3. Yoga
• Membantu meregangkan otot
• Mengurangi ketegangan tubuh
• Meningkatkan mood
• Pilih pose yang nyaman dan tidak terlalu menantang

4. Pilates
• Melatih otot dasar panggul
• Membantu mengurangi nyeri haid
• Memperkuat core (otot perut)
• Gerakan dapat disesuaikan dengan kondisi

5. Renang
• Boleh dilakukan saat aliran darah tidak deras
• Gunakan pembalut khusus renang
• Hindari jika sering mengalami kram
• Pastikan air kolam bersih

6. Zumba
• Menari dengan musik yang menyenangkan
• Meningkatkan fleksibilitas tubuh
• Membakar kalori
• Membantu mengurangi nyeri

OLAHRAGA YANG PERLU DIHINDARI:

1. Latihan Kardio Intensitas Tinggi
• Hindari lari cepat
• Hindari lari jarak jauh
• Dapat memperparah pendarahan
• Meningkatkan rasa tidak nyaman

2. Gerakan Keras pada Perut
• Hindari angkat beban berat
• Hindari sit-up berlebihan
• Hindari gerakan melompat tinggi
• Dapat memperparah kram perut

TIPS PENTING SAAT BEROLAHRAGA:

Persiapan:
• Pilih pakaian yang nyaman dan menyerap keringat
• Gunakan pembalut yang sesuai
• Ganti pembalut secara teratur
• Siapkan air minum yang cukup

Selama Olahraga:
• Perhatikan intensitas, jangan berlebihan
• Dengarkan sinyal tubuh
• Istirahat jika merasa tidak nyaman
• Jaga hidrasi yang cukup

Setelah Olahraga:
• Mandi dan bersihkan diri
• Ganti pakaian
• Istirahat secukupnya
• Konsumsi makanan bergizi

PERINGATAN:
Segera hentikan aktivitas dan konsultasi dengan dokter jika mengalami:
• Nyeri yang tidak biasa
• Pendarahan berlebihan
• Pusing atau mual
• Kram perut yang parah''',
                      ),
                    ),
                    _EducationCard(
                      title: 'Kenapa Haid Nggak Teratur?',
                      image: 'assets/images/edukasi3.jpeg',
                      onTap: () => _showArticle(
                        context,
                        'Kenapa Haid Tidak Teratur dan Cara Mengatasinya',
                        '''Haid tidak teratur adalah kondisi yang umum dialami wanita dan dapat disebabkan oleh berbagai faktor. Berikut penjelasan lengkapnya:

PENYEBAB HAID TIDAK TERATUR:

1. Perubahan Hormonal
• Masa Pubertas: Sistem hormon masih berkembang pada remaja
• Pasca Melahirkan & Menyusui: Perubahan hormon mempengaruhi siklus
• Menjelang Menopause: Penurunan hormon estrogen dan progesteron
• Penggunaan KB Hormonal: Pil KB dan IUD dapat mempengaruhi siklus

2. Faktor Stres
• Stres fisik dan mental mempengaruhi keseimbangan hormon
• Tekanan pekerjaan atau akademik
• Masalah pribadi atau keluarga
• Gangguan kecemasan

3. Masalah Berat Badan
• Penurunan berat badan drastis
• Kenaikan berat badan signifikan
• Gangguan makan (eating disorder)
• Obesitas

4. Gaya Hidup
• Olahraga berlebihan/terlalu intens
• Pola makan tidak sehat
• Kurang nutrisi penting (zat besi, vitamin D, B kompleks)
• Kurang tidur/kualitas tidur buruk

5. Kondisi Medis
• Sindrom Polikistik Ovarium (PCOS)
• Gangguan tiroid
• Perdarahan uterin tidak normal
• Kista ovarium

6. Faktor Lainnya
• Efek samping obat-obatan tertentu
• Faktor genetik
• Perubahan zona waktu ekstrem
• Penyakit kronis

SOLUSI MENGATASI HAID TIDAK TERATUR:

1. Penanganan Medis
• Konsultasi rutin dengan dokter
• Pemeriksaan hormon
• Terapi hormonal jika diperlukan
• Pengobatan kondisi medis yang mendasari

2. Perbaikan Gaya Hidup
Pola Makan:
• Konsumsi makanan seimbang dan bergizi
• Perbanyak sayur dan buah
• Makanan kaya omega-3
• Suplemen vitamin jika direkomendasikan dokter

Aktivitas Fisik:
• Olahraga teratur tapi tidak berlebihan
• Pilih aktivitas yang menyenangkan
• Hindari latihan terlalu intens
• Jaga berat badan ideal

3. Manajemen Stres
• Praktik teknik relaksasi
• Yoga atau meditasi
• Istirahat yang cukup
• Tidur 7-9 jam sehari

4. Kebiasaan Sehat
• Berhenti merokok
• Batasi konsumsi alkohol
• Minum air putih cukup
• Jaga kebersihan diri

5. Pemantauan Rutin
• Catat siklus menstruasi
• Perhatikan gejala yang muncul
• Dokumentasikan perubahan
• Simpan catatan untuk diskusi dengan dokter

KAPAN HARUS KE DOKTER:

Segera konsultasi jika mengalami:
• Tidak haid lebih dari 3 bulan
• Perdarahan sangat berat
• Nyeri hebat saat haid
• Perdarahan di luar siklus
• Siklus sangat pendek (< 21 hari)
• Siklus sangat panjang (> 35 hari)

TIPS TAMBAHAN:

• Gunakan aplikasi pelacak menstruasi
• Perhatikan pola siklus Anda
• Kenali "normal" untuk tubuh Anda
• Jangan ragu berkonsultasi dengan dokter
• Diskusikan dengan keluarga/teman yang dipercaya

Ingat: Setiap wanita memiliki siklus yang berbeda. Yang terpenting adalah mengenali apa yang normal bagi tubuh Anda dan segera mencari bantuan medis jika ada perubahan yang mengkhawatirkan.''',
                      ),
                    ),
                    _EducationCard(
                      title: 'Kapan harus ke dokter?',
                      image: 'assets/images/edukasi4.jpeg',
                      onTap: () => _showArticle(
                        context,
                        'Kapan Harus Segera ke Dokter?',
                        '''Penting untuk mengenali tanda-tanda yang mengharuskan Anda segera berkonsultasi dengan dokter. Berikut adalah panduan lengkapnya:

TANDA-TANDA NYERI YANG PERLU DIWASPADAI:

1. Nyeri yang Sangat Parah
• Mengganggu aktivitas sehari-hari
• Menyebabkan pingsan
• Tidak bisa beraktivitas normal
• Membutuhkan istirahat total

2. Durasi Nyeri Tidak Normal
• Berlangsung lebih dari dua hari
• Tidak mereda setelah minum obat
• Nyeri terus-menerus
• Intensitas nyeri tidak berkurang

3. Lokasi Nyeri Tidak Biasa
• Nyeri di area selain perut bawah
• Nyeri menjalar ke pinggang
• Nyeri di area paha
• Nyeri di area punggung

4. Masalah Perdarahan
• Perdarahan sangat berat
• Darah menggumpal
• Perdarahan di luar siklus
• Perdarahan lebih lama dari biasanya

5. Gejala Tambahan yang Muncul
• Disertai demam
• Mual dan muntah
• Diare
• Nyeri saat berhubungan seksual

KONDISI KHUSUS YANG PERLU PERHATIAN:

1. Perubahan Pola Nyeri
• Nyeri baru muncul setelah usia 25 tahun
• Nyeri setelah pemasangan KB spiral
• Nyeri yang semakin memburuk
• Perubahan karakteristik nyeri

2. Gangguan pada Siklus
• Tidak haid lebih dari 3 bulan
• Siklus kurang dari 21 hari
• Siklus lebih dari 35 hari
• Pola haid berubah drastis

3. Masalah saat Aktivitas
• Nyeri saat buang air kecil
• Nyeri saat buang air besar
• Nyeri saat berhubungan intim
• Nyeri yang mengganggu tidur

4. Kondisi Darah Haid
• Warna sangat gelap
• Berbentuk gumpalan besar
• Berbau tidak normal
• Konsistensi tidak biasa

5. Gejala di Luar Periode Haid
• Nyeri pinggang di luar masa haid
• Pendarahan di antara periode
• Spotting (bercak darah)
• Nyeri perut kronis

SEGERA KE DOKTER JIKA:

1. Nyeri Berkelanjutan
• Terjadi selama 3 periode berturut-turut
• Semakin parah setiap bulan
• Tidak responsif terhadap obat
• Mengganggu kualitas hidup

2. Perdarahan Abnormal
• Membasahi pembalut setiap 1-2 jam
• Gumpalan darah besar
• Perdarahan lebih dari 7 hari
• Perdarahan di luar siklus

3. Gejala Serius
• Demam tinggi
• Pingsan
• Mual dan muntah parah
• Nyeri yang tidak tertahankan

TIPS PERSIAPAN KE DOKTER:

1. Dokumentasi Gejala
• Catat tanggal mulai gejala
• Rekam intensitas nyeri (skala 1-10)
• Foto gumpalan jika ada
• Simpan catatan siklus haid

2. Informasi yang Perlu Disiapkan
• Riwayat menstruasi
• Obat-obatan yang dikonsumsi
• Riwayat kesehatan keluarga
• Gaya hidup dan aktivitas

3. Pertanyaan untuk Dokter
• Penyebab gejala
• Opsi pengobatan
• Tindakan pencegahan
• Kapan harus kontrol ulang

PENTING DIINGAT:
Jangan menunda konsultasi ke dokter jika mengalami tanda-tanda di atas. Penanganan dini dapat mencegah komplikasi dan membantu menemukan penyebab masalah dengan lebih cepat. Dokter akan melakukan pemeriksaan yang diperlukan dan memberikan pengobatan yang sesuai dengan kondisi Anda.''',
                      ),
                    ),
                    _EducationCard(
                      title: 'Warna haid',
                      image: 'assets/images/edukasi5.jpeg',
                      onTap: () => _showArticle(
                        context,
                        'Memahami Arti Warna Darah Menstruasi',
                        '''Warna darah menstruasi dapat memberikan petunjuk penting tentang kesehatan reproduksi Anda. Berikut adalah panduan lengkap tentang berbagai warna darah haid dan artinya:

WARNA NORMAL:

1. Merah Terang
• Menandakan darah haid segar
• Umum terjadi di awal siklus
• Aliran darah sedang deras
• Kondisi normal dan sehat

2. Merah Gelap
• Darah yang sudah lebih lama di rahim
• Normal di pertengahan siklus
• Aliran mulai melambat
• Masih termasuk kondisi wajar

3. Cokelat
• Darah yang sudah teroksidasi
• Umum di akhir siklus
• Aliran sudah melambat
• Normal menjelang selesai haid

WARNA YANG PERLU PERHATIAN:

1. Merah Muda
• Bisa indikasi kadar estrogen rendah
• Kemungkinan anemia
• Bercampur lendir serviks
• Perlu perhatikan gejala lain

2. Abu-abu
• Bisa menandakan infeksi
• Kemungkinan vaginosis bakteri
• Waspadai jika ada bau tidak sedap
• Perlu pemeriksaan lebih lanjut

3. Kehijauan
• Tanda kemungkinan infeksi
• Bisa karena infeksi menular seksual
• Perlu segera ke dokter
• Jangan ditunda penanganannya

4. Hitam
• Darah yang sangat lama di rahim
• Normal jika hanya sesekali
• Waspadai jika terus-menerus
• Perhatikan gejala tambahan

5. Oranye
• Bercampur cairan serviks
• Normal di awal siklus
• Waspadai jika berbau tidak sedap
• Bisa tanda infeksi jika disertai gejala lain

KAPAN PERLU WASPADA:

1. Perubahan Warna Mendadak
• Warna berubah drastis
• Tidak sesuai dengan pola biasa
• Berlangsung lebih dari 1 siklus
• Disertai gejala tidak nyaman

2. Gejala Tambahan
• Bau tidak sedap
• Gatal atau iritasi
• Nyeri tidak biasa
• Demam atau pusing

3. Konsistensi Tidak Normal
• Terlalu encer
• Terlalu kental
• Banyak gumpalan
• Tekstur tidak biasa

KAPAN HARUS KE DOKTER:

Segera konsultasi jika mengalami:
• Warna abu-abu atau kehijauan
• Bau tidak sedap yang mengganggu
• Gatal atau perih
• Nyeri yang tidak biasa
• Demam
• Perdarahan sangat berat

TIPS PEMANTAUAN:

1. Dokumentasi
• Catat perubahan warna
• Foto jika perlu
• Perhatikan pola perubahan
• Simpan catatan untuk diskusi dengan dokter

2. Perhatikan Juga
• Jumlah perdarahan
• Konsistensi darah
• Gejala yang menyertai
• Durasi setiap warna

PENTING DIINGAT:

• Setiap wanita memiliki pola menstruasi yang berbeda
• Perubahan warna selama siklus adalah normal
• Yang penting adalah mengenali apa yang normal bagi tubuh Anda
• Jika ragu, selalu lebih baik berkonsultasi dengan dokter
• Jangan ragu mencatat dan mendokumentasikan perubahan

Catatan: Informasi ini bersifat umum dan tidak menggantikan konsultasi medis. Jika Anda mengalami perubahan warna yang tidak biasa atau disertai gejala yang mengganggu, segera konsultasikan dengan dokter untuk mendapatkan pemeriksaan dan penanganan yang tepat.''',
                      ),
                    ),
                    _EducationCard(
                      title: 'Hormon yang Sering Diabaikan',
                      image: 'assets/images/edukasi6.jpeg',
                      onTap: () => _showArticle(
                        context,
                        'Hormon-hormon Penting dalam Siklus Menstruasi',
                        '''Hormon memainkan peran vital dalam mengatur siklus menstruasi. Memahami peran setiap hormon dapat membantu Anda mengenali tanda-tanda ketidakseimbangan hormon. Berikut penjelasan lengkapnya:

HORMON UTAMA DAN FUNGSINYA:

1. FSH (Follicle Stimulating Hormone)
• Merangsang pertumbuhan folikel di ovarium
• Memicu pematangan sel telur
• Diproduksi oleh kelenjar pituitari
• Penting untuk kesuburan

2. LH (Luteinizing Hormone)
• Memicu terjadinya ovulasi
• Merangsang pembentukan korpus luteum
• Mengatur produksi hormon lain
• Penting untuk siklus ovulasi

3. Estrogen
• Menebalkan dinding rahim
• Membantu perkembangan folikel
• Mengatur siklus menstruasi
• Mempengaruhi kesehatan tulang

4. Progesteron
• Mempersiapkan rahim untuk kehamilan
• Menjaga kehamilan jika terjadi
• Diproduksi oleh korpus luteum
• Mempengaruhi suhu tubuh

5. GnRH (Gonadotropin-Releasing Hormone)
• Mengontrol pelepasan FSH dan LH
• Mengatur keseluruhan siklus
• Diproduksi oleh hipotalamus
• Penting untuk keseimbangan hormonal

6. Testosteron
• Berperan dalam gairah seksual
• Mempengaruhi pertumbuhan rambut
• Membantu pembentukan otot
• Diproduksi dalam jumlah kecil oleh ovarium

FASE SIKLUS DAN PERAN HORMON:

1. Fase Folikular (Hari 1-14)
• FSH meningkat untuk pematangan folikel
• Estrogen mulai meningkat
• Dinding rahim mulai menebal
• Persiapan untuk ovulasi

2. Fase Ovulasi (Hari 14)
• Lonjakan LH memicu ovulasi
• Estrogen mencapai puncak
• Sel telur dilepaskan
• Suhu tubuh meningkat

3. Fase Luteal (Hari 15-28)
• Progesteron meningkat
• Pembentukan korpus luteum
• Persiapan untuk kehamilan
• Suhu tubuh tetap tinggi

4. Fase Menstruasi
• Penurunan semua hormon
• Dinding rahim luruh
• Terjadi pendarahan
• Siklus dimulai kembali

TANDA KETIDAKSEIMBANGAN HORMON:

1. Gejala Fisik
• Siklus tidak teratur
• Nyeri haid berlebihan
• Jerawat hormonal
• Perubahan berat badan

2. Gejala Emosional
• Perubahan mood drastis
• Kecemasan berlebih
• Depresi
• Gangguan tidur

3. Masalah Menstruasi
• Amenore (tidak haid)
• Menoragia (pendarahan berat)
• Spotting
• Siklus terlalu panjang/pendek

PENYEBAB KETIDAKSEIMBANGAN:

1. Faktor Gaya Hidup
• Stres berlebihan
• Pola makan tidak sehat
• Olahraga berlebihan
• Kurang tidur

2. Kondisi Medis
• PCOS (Sindrom Ovarium Polikistik)
• Masalah tiroid
• Endometriosis
• Tumor hormon

CARA MENJAGA KESEIMBANGAN HORMON:

1. Pola Hidup Sehat
• Makan makanan bergizi
• Olahraga teratur
• Tidur cukup
• Kelola stres

2. Nutrisi Penting
• Vitamin D
• Vitamin B kompleks
• Omega-3
• Mineral penting

3. Pemeriksaan Rutin
• Cek hormon secara berkala
• Pantau siklus menstruasi
• Catat gejala yang muncul
• Konsultasi dengan dokter

KAPAN HARUS KE DOKTER:

Segera konsultasi jika mengalami:
• Siklus sangat tidak teratur
• Nyeri haid yang parah
• Perubahan mood ekstrem
• Gejala yang mengganggu aktivitas

PENTING DIINGAT:
Keseimbangan hormon sangat penting untuk kesehatan reproduksi. Jika Anda mengalami gejala ketidakseimbangan hormon, jangan ragu untuk berkonsultasi dengan dokter. Pemeriksaan dan penanganan dini dapat mencegah masalah yang lebih serius di kemudian hari.''',
                      ),
                    ),
                    _EducationCard(
                      title: 'Informasi siklus haid',
                      image: 'assets/images/edukasi7.jpeg',
                      onTap: () => _showArticle(
                        context,
                        'Memahami Siklus Menstruasi',
                        '''Siklus menstruasi adalah proses alami yang terjadi dalam tubuh wanita setiap bulan. Memahami siklus ini penting untuk kesehatan reproduksi dan perencanaan kehamilan. Berikut penjelasan lengkapnya:

DASAR SIKLUS MENSTRUASI:

1. Pengertian
• Siklus bulanan yang mempersiapkan kehamilan
• Berlangsung 21-35 hari (rata-rata 28 hari)
• Menstruasi berlangsung 2-7 hari
• Dimulai dari hari pertama haid

2. Karakteristik Normal
• Volume darah: 30-80 ml per siklus
• Warna darah: merah segar hingga gelap
• Konsistensi: cair hingga sedikit menggumpal
• Siklus teratur setiap bulan

FASE-FASE SIKLUS MENSTRUASI:

1. Fase Menstruasi (Hari 1-7)
• Peluruhan dinding rahim
• Keluarnya darah melalui vagina
• Durasi 2-7 hari
• Hormon estrogen dan progesteron rendah

2. Fase Folikular (Hari 1-14)
• Pembentukan folikel di ovarium
• Pematangan sel telur
• Penebalan dinding rahim
• Peningkatan hormon estrogen

3. Fase Ovulasi (Sekitar Hari 14)
• Pelepasan sel telur matang
• Sel telur siap dibuahi
• Peningkatan hormon LH
• Masa subur tertinggi

4. Fase Luteal (Hari 15-28)
• Pembentukan korpus luteum
• Persiapan untuk kehamilan
• Peningkatan progesteron
• Dinding rahim semakin tebal

HORMON YANG BERPERAN:

1. Estrogen
• Mengendalikan pertumbuhan folikel
• Menebalkan dinding rahim
• Mengatur siklus menstruasi
• Mempengaruhi karakteristik seksual

2. Progesteron
• Mempersiapkan kehamilan
• Mempertahankan dinding rahim
• Mengatur suhu tubuh
• Mempengaruhi produksi ASI

3. FSH (Follicle Stimulating Hormone)
• Merangsang pertumbuhan folikel
• Memicu pematangan sel telur
• Mengatur produksi estrogen
• Penting untuk kesuburan

4. LH (Luteinizing Hormone)
• Memicu ovulasi
• Membentuk korpus luteum
• Mengatur hormon reproduksi
• Penting untuk kehamilan

FAKTOR YANG MEMPENGARUHI SIKLUS:

1. Kondisi Kesehatan
• Penyakit kronis
• Gangguan hormon
• PCOS
• Endometriosis

2. Gaya Hidup
• Pola makan
• Aktivitas fisik
• Kualitas tidur
• Tingkat stres

3. Berat Badan
• Obesitas
• Berat badan kurang
• Perubahan berat drastis
• Gangguan makan

4. Faktor Eksternal
• Penggunaan kontrasepsi
• Obat-obatan tertentu
• Perubahan lingkungan
• Jet lag

PENTINGNYA MEMAHAMI SIKLUS:

1. Manfaat Pemahaman
• Mengetahui masa subur
• Memantau kesehatan reproduksi
• Mengenali ketidaknormalan
• Perencanaan kehamilan

2. Cara Memantau
• Catat tanggal menstruasi
• Perhatikan durasi dan volume
• Dokumentasi gejala
• Gunakan aplikasi pelacak

3. Tanda Perlu Perhatian
• Siklus sangat tidak teratur
• Nyeri hebat
• Pendarahan berlebihan
• Spotting di luar siklus

TIPS MENJAGA KESEHATAN SIKLUS:

1. Pola Hidup Sehat
• Makan makanan bergizi
• Olahraga teratur
• Tidur cukup
• Kelola stres

2. Kebersihan
• Ganti pembalut teratur
• Jaga kebersihan area intim
• Hindari produk berbahan kimia keras
• Gunakan pakaian dalam yang nyaman

3. Pemeriksaan Rutin
• Kunjungi dokter secara berkala
• Lakukan papsmear rutin
• Periksa payudara sendiri
• Catat perubahan tidak normal

PENTING DIINGAT:
Setiap wanita memiliki siklus yang unik. Yang terpenting adalah mengenali apa yang normal bagi tubuh Anda dan segera berkonsultasi dengan dokter jika ada perubahan yang mengkhawatirkan. Pemahaman yang baik tentang siklus menstruasi akan membantu Anda menjaga kesehatan reproduksi secara optimal.''',
                      ),
                    ),
                    _EducationCard(
                      title: 'Gejala sebelum haid',
                      image: 'assets/images/edukasi8.jpeg',
                      onTap: () => _showArticle(
                        context,
                        'Gejala Sebelum dan Saat Haid: Kenali dan Atasi',
                        '''Setiap wanita mungkin mengalami gejala yang berbeda sebelum dan selama menstruasi. Memahami gejala-gejala ini dan cara mengatasinya dapat membantu Anda menjalani periode menstruasi dengan lebih nyaman. Berikut penjelasan lengkapnya:

GEJALA UMUM SEBELUM DAN SAAT HAID:

1. Gejala Fisik Utama
• Kram perut bagian bawah
• Nyeri punggung dan pinggul
• Payudara bengkak dan nyeri
• Sakit kepala atau migrain
• Kelelahan dan lemas

2. Gejala Emosional
• Perubahan suasana hati (mood swings)
• Mudah marah atau sensitif
• Kecemasan meningkat
• Perasaan sedih atau depresi
• Sulit berkonsentrasi

3. Perubahan Kulit
• Munculnya jerawat
• Kulit lebih berminyak
• Wajah terlihat lebih puffy
• Kulit lebih sensitif

4. Gangguan Pencernaan
• Perut kembung
• Mual
• Diare atau sembelit
• Nafsu makan berubah

5. Gejala Lainnya
• Gangguan tidur
• Pusing atau vertigo
• Sering buang air kecil
• Nyeri sendi

CARA MENGATASI GEJALA:

1. Penanganan Nyeri
• Kompres hangat pada perut
• Pijat lembut area yang nyeri
• Posisi tidur yang nyaman
• Gunakan bantal pemanas

2. Aktivitas Fisik
• Olahraga ringan seperti jalan kaki
• Yoga khusus menstruasi
• Peregangan ringan
• Hindari olahraga berat

3. Pola Makan Sehat
• Konsumsi makanan kaya zat besi
• Perbanyak sayur dan buah
• Batasi garam dan gula
• Hindari kafein dan alkohol

4. Istirahat dan Relaksasi
• Tidur cukup (7-9 jam)
• Meditasi atau teknik pernapasan
• Mandi air hangat
• Hindari aktivitas berlebihan

5. Pengobatan
• Obat pereda nyeri (jika diperlukan)
• Obat anti-inflamasi
• Vitamin dan suplemen
• Jamu tradisional

TIPS TAMBAHAN:

1. Persiapan Menghadapi Haid
• Siapkan pembalut yang cukup
• Bawa obat pereda nyeri
• Pakai pakaian yang nyaman
• Hindari pakaian ketat

2. Kebersihan
• Ganti pembalut secara teratur
• Jaga kebersihan area intim
• Mandi air hangat
• Gunakan celana dalam katun

3. Nutrisi Penting
• Zat besi
• Kalsium
• Magnesium
• Vitamin B kompleks
• Omega-3

4. Hindari:
• Makanan terlalu asin
• Minuman berkafein
• Alkohol
• Rokok
• Makanan berminyak

KAPAN HARUS KE DOKTER:

Segera konsultasi jika mengalami:
• Nyeri yang sangat hebat
• Pendarahan berlebihan
• Gejala yang mengganggu aktivitas
• Perubahan siklus drastis
• Gejala tidak normal lainnya

CARA MENCEGAH GEJALA BERAT:

1. Persiapan Sebelum Haid
• Pantau siklus menstruasi
• Perhatikan pola makan
• Jaga pola tidur
• Kelola stres

2. Gaya Hidup Sehat
• Olahraga teratur
• Makan seimbang
• Tidur cukup
• Hindari stres

3. Dokumentasi
• Catat gejala yang muncul
• Perhatikan pola gejala
• Dokumentasikan efektivitas pengobatan
• Simpan catatan untuk diskusi dengan dokter

PENGOBATAN ALAMI:

1. Herbal
• Jahe
• Kunyit
• Kayu manis
• Teh chamomile

2. Terapi Alternatif
• Akupuntur
• Akupresur
• Pijat aromaterapi
• Yoga

PENTING DIINGAT:
Setiap wanita memiliki pengalaman menstruasi yang berbeda. Yang terpenting adalah mengenali pola tubuh Anda sendiri dan menemukan cara yang paling efektif untuk mengatasi gejala yang muncul. Jika gejala terasa berat atau mengganggu aktivitas sehari-hari, jangan ragu untuk berkonsultasi dengan dokter.

Catatan: Informasi di atas bersifat umum. Selalu konsultasikan dengan dokter untuk penanganan yang sesuai dengan kondisi Anda, terutama jika mengalami gejala yang parah atau tidak biasa.''',
                      ),
                    ),
                    _EducationCard(
                      title: 'Olahraga saat haid',
                      image: 'assets/images/edukasi9.jpeg',
                      onTap: () => _showArticle(
                        context,
                        'Panduan Lengkap Olahraga saat Haid',
                        '''Olahraga saat haid sebenarnya aman dan bahkan direkomendasikan karena dapat membantu mengurangi berbagai gejala menstruasi. Yang terpenting adalah memilih jenis olahraga yang tepat dan mendengarkan kebutuhan tubuh Anda. Berikut panduan lengkapnya:

MANFAAT OLAHRAGA SAAT HAID:

1. Meredakan Nyeri
• Melepaskan hormon endorfin
• Mengurangi kram perut
• Meredakan nyeri punggung
• Meringankan sakit kepala

2. Meningkatkan Sirkulasi
• Melancarkan aliran darah
• Mengurangi perut kembung
• Membantu detoksifikasi
• Mengurangi retensi air

3. Manfaat Mental
• Meningkatkan mood
• Mengurangi stres
• Memperbaiki kualitas tidur
• Meningkatkan energi

4. Manfaat Fisik
• Menjaga kebugaran
• Mempertahankan berat badan
• Meningkatkan fleksibilitas
• Memperkuat sistem imun

OLAHRAGA YANG DISARANKAN:

1. Jalan Kaki
• Intensitas rendah dan aman
• 15-30 menit per hari
• Bisa dilakukan di mana saja
• Sesuaikan dengan kenyamanan

2. Yoga
• Pose yang menenangkan
• Membantu relaksasi
• Meningkatkan fleksibilitas
• Meredakan kram

3. Pilates
• Memperkuat otot inti
• Meningkatkan postur
• Latihan pernapasan
• Gerakan lembut

4. Senam Ringan
• Aerobik intensitas rendah
• Zumba ringan
• Senam lantai dasar
• Gerakan yang nyaman

5. Bersepeda
• Sepeda statis lebih disarankan
• Durasi 15-20 menit
• Intensitas rendah-sedang
• Di tempat yang sejuk

6. Berenang
• Gunakan pembalut khusus
• Hindari air terlalu dingin
• Durasi tidak terlalu lama
• Sesuaikan dengan kondisi

OLAHRAGA YANG DIHINDARI:

1. Latihan Intensitas Tinggi
• HIIT
• Lari sprint
• Angkat beban berat
• Latihan kardio intens

2. Gerakan Berisiko
• Pose yoga terbalik
• Squat berat
• Sit-up berlebihan
• Lompatan tinggi

3. Olahraga Kontak
• Bela diri
• Basket
• Sepak bola
• Voli

TIPS PENTING:

1. Persiapan
• Gunakan pembalut yang tepat
• Pakai pakaian nyaman
• Bawa air minum
• Siapkan handuk

2. Selama Olahraga
• Perhatikan intensitas
• Jaga hidrasi
• Istirahat jika lelah
• Dengarkan tubuh

3. Perlengkapan
• Celana olahraga nyaman
• Sports bra yang pas
• Sepatu yang sesuai
• Pembalut cadangan

4. Waktu Ideal
• Pagi atau sore hari
• Hindari cuaca ekstrem
• Durasi 20-30 menit
• Sesuaikan dengan siklus

PANDUAN KEAMANAN:

1. Sebelum Olahraga
• Pemanasan yang cukup
• Cek kondisi tubuh
• Makan ringan jika perlu
• Pastikan hidrasi baik

2. Selama Olahraga
• Monitor intensitas
• Perhatikan tanda lelah
• Jaga postur
• Bernapas teratur

3. Setelah Olahraga
• Pendinginan yang baik
• Mandi air hangat
• Istirahat cukup
• Makan bergizi

KAPAN HARUS BERHENTI:

Segera hentikan olahraga jika:
• Nyeri hebat
• Pusing
• Mual
• Pendarahan meningkat
• Lemas berlebihan

REKOMENDASI TAMBAHAN:

1. Nutrisi
• Makan sebelum olahraga
• Konsumsi protein cukup
• Perbanyak sayur dan buah
• Hindari makanan berminyak

2. Hidrasi
• Minum air putih cukup
• Hindari minuman kafein
• Konsumsi elektrolit
• Jaga keseimbangan cairan

PENTING DIINGAT:
Setiap wanita memiliki toleransi berbeda terhadap aktivitas fisik saat menstruasi. Yang terpenting adalah mendengarkan tubuh Anda dan tidak memaksakan diri. Jika ragu atau memiliki kondisi kesehatan tertentu, selalu konsultasikan dengan dokter sebelum memulai rutinitas olahraga saat haid.

Catatan: Informasi ini bersifat umum. Sesuaikan intensitas dan jenis olahraga dengan kondisi tubuh Anda. Jika mengalami ketidaknyamanan atau gejala yang mengkhawatirkan, segera hentikan aktivitas dan konsultasikan dengan dokter.''',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Edukasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Kalender',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 1:
              Navigator.pushNamed(context, '/');
              break;
            case 2:
              Navigator.pushNamed(context, '/calendar');
              break;
          }
        },
      ),
    );
  }

  void _showArticle(BuildContext context, String title, String content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  content,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EducationCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const _EducationCard({
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                image,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
