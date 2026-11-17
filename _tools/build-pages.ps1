# =====================================================================
#  FM MOBILE FIX - SEO page generator
#  Builds the service, brand and area pages from the data below.
#  Run:  powershell -ExecutionPolicy Bypass -File _tools\build-pages.ps1
#  Change $SITE when the real domain is ready, then run again.
#  (This _tools folder is not part of the website. Do not upload it.)
# =====================================================================
param([string]$SITE = 'https://fmmobilefix.com')

$ROOT = Split-Path -Parent $PSScriptRoot
$enc  = New-Object Text.UTF8Encoding $false
$TODAY = (Get-Date).ToString('yyyy-MM-dd')
$ADDR = 'Lot 3745, Jalan Murai, Kampung Batu 9 Kebun Baru, 42500 Telok Panglima Garang, Selangor'
$MAPDIR = 'https://www.google.com/maps?gl=my&amp;daddr=Lot+3745,+Jalan+Murai,+Kampung+Batu+9+Kebun+Baru,+42500+Telok+Panglima+Garang,+Selangor'
$MAPEMBED = 'https://maps.google.com/maps?q=Lot+3745,+Jalan+Murai,+Kampung+Batu+9+Kebun+Baru,+42500+Telok+Panglima+Garang,+Selangor&amp;z=16&amp;output=embed'
$GREVIEWS = 'https://www.google.com/maps/search/?api=1&amp;query=FM+Mobile+Fix+Telok+Panglima+Garang'

function I($name) { return '<svg class="i" aria-hidden="true"><use href="#i-' + $name + '"/></svg>' }
function Esc($s) { return ($s -replace '"', '&quot;') }
function JsonStr($s) {
  # plain-text value for JSON-LD (strip tags + decode the few entities we use)
  $t = $s -replace '<[^>]+>', ''
  $t = $t.Replace('&amp;', '&').Replace('&middot;', '-').Replace('&ndash;', '-').Replace('&quot;', '"').Replace('&hellip;', '...')
  return $t.Replace('\', '\\').Replace('"', '\"')
}

# ---------------------------------------------------------------------
#  Shared data
# ---------------------------------------------------------------------
$REV = @{
  nurhafizah = @('N','Nurhafizah H.','Repair handphone Oppo button on/off tenggelam dan button volume +- patah, caj hanya RM20. Sangat murah dan terbaik servis kedai ni. Hantar jam 2 petang, repair siap hari yang sama jam 6 petang.')
  harraz     = @('H','Harraz Z.','Servis terbaik, hantar baiki phone &amp; pasang tinted screen siap dalam hari yang sama, harga sangat berpatutan dan staff juga mesra serta dapat menyelesaikan masalah dengan baik.')
  azzoo      = @('A','Azzoo B.','Sangat sangat berpuas hati... kerja yang kemas... cepat... harga barangan dan servis sangat berpatutan... Staff sangat berpengalaman dan friendly too...')
  amar       = @('A','Amar S.','Sangat berpuas hati dengan service di sini.. handphone kembali pulih selepas motherboard rosak akibat jatuh.. sangat recommended..')
  ezam       = @('E','Ezam M.','Hantar phone repair di kedai ni.. charging pin rosak.. staff sangat mesra.. ambil masa repair pun tak berapa lama.. bagi penerangan pasal phone pun sangat jelas.. harga berpatutan.')
  parrahaina = @('P','Parrahaina M.','Close to home, owner very helpful and fast service. Honest &amp; clear when troubleshooting the problem. Price were really affordable, got my phone fixed twice here.')
  azzahra    = @('N','Nur Azzahra','Bagus sangat adik yang tolong tukarkan LCD phone saya ni... Teliti, cermat, ikhlas dalam bekerja.')
  syira      = @('S','Syira I.','Service tiptop.. mudah berurusan.. nak repair telefon dan laptop boleh buat sini.. nak pasang screen protector pun ada dijual sini..')
  amirul     = @('A','Amirul F.','Alhamdulillah diberi layanan yang sangat baik. Staff sangat teliti dengan kerja. Harga mampu milik.')
  hazril     = @('M','Mohd Noor H.','Alhamdulillah proses tukar bateri iPhone 13 berjalan lancar. Dalam 30 minit settle.')
  zuhaidah   = @('Z','Zuhaidah Z.','Saya gembira berurusan.. repair LCD phone saya. Ada kerusi menunggu... mereka sangat friendly. Good service, harga OK.')
  aiman      = @('A','Aiman R.','Aku hantar baiki phone wife aku.. murah weyhh dari kedai-kedai lain.. InsyaAllah kalau phone rosak memang aku pergi sana je lah.')
}

$WARRANTY = 'Tukar bateri dan LCD/skrin datang dengan <b style="display:inline">waranti 3 bulan</b>, bergantung pada jenis spare part. Kami akan maklumkan tempoh waranti sebelum repair dimulakan.'

$PAGES = [ordered]@{}

# ---------------------------- PHONE ---------------------------------
$PAGES['phone-repair/tukar-skrin'] = @{
  sec='phone'; icon='screen'; wa='tukar skrin phone'
  title='Tukar Skrin Phone Telok Panglima Garang | FM Mobile Fix'
  desc='Skrin phone pecah, bergaris, berkelip atau touch tak berfungsi? Tukar skrin dan LCD iPhone, Samsung, Oppo, Vivo &amp; Xiaomi di Telok Panglima Garang. Waranti 3 bulan.'
  crumb='Tukar Skrin'; eyebrow='Repair Phone &middot; Tukar Skrin'
  h1='Tukar Skrin Phone Pecah &amp; LCD Rosak'
  lead='Skrin retak, bergaris, berkelip atau touch tak jalan? Kami tukar skrin dan LCD untuk iPhone dan Android di kedai kami di Telok Panglima Garang, dekat dengan Jalan Kebun, Rimbayu dan Shah Alam.'
  hero='01-iphone-x-skrin.jpg'; heroAlt='Before dan after tukar skrin iPhone X di FM Mobile Fix'
  facts=@('Semakan dulu sebelum repair','Waranti 3 bulan untuk LCD','iPhone &amp; Android')
  symTitle='Tanda skrin phone anda perlu ditukar'
  sym=@(
    @('screen','Skrin retak atau pecah','Kaca depan retak selepas jatuh, walaupun phone masih boleh digunakan.'),
    @('scan','Skrin bergaris atau berkelip','Garisan hijau, ungu atau putih, atau paparan yang berkelip-kelip.'),
    @('chat','Touch tak berfungsi','Sentuhan tak respon, tersentuh sendiri (ghost touch) atau sebahagian skrin mati.'),
    @('phone','Skrin gelap atau blank','Phone berbunyi atau bergetar, tetapi tiada paparan langsung.'))
  prose=@('Sebelum tukar skrin, kami semak dahulu sama ada masalah datang dari skrin atau dari board. Dengan cara ini anda tidak membayar untuk alat ganti yang tidak diperlukan.','Selepas semakan, kami terangkan pilihan skrin yang ada untuk model phone anda dan anggaran kos. Repair hanya dimulakan selepas anda setuju.')
  warranty=$true
  photos=@(@('01-iphone-x-skrin.jpg','iPhone X skrin bergaris hijau, kini siap tukar skrin baru.'),@('05-samsung-skrin.jpg','Samsung skrin pecah teruk, kini siap tukar skrin baru.'),@('06-tukar-skrin.jpg','Skrin retak (kiri) diganti dengan skrin baru (kanan).'))
  reviews=@('azzahra','zuhaidah','harraz')
  faq=@(
    @('Berapa lama masa untuk tukar skrin phone?','Bergantung pada model dan stok skrin. Ramai pelanggan kami dapat ambil semula phone pada hari yang sama, dan kami akan maklumkan anggaran masa selepas semakan.'),
    @('Ada waranti untuk tukar skrin?','Ada. Tukar LCD atau skrin datang dengan waranti 3 bulan, bergantung pada jenis spare part. Kami akan beritahu tempoh waranti sebelum repair.'),
    @('Data dalam phone hilang tak bila tukar skrin?','Tukar skrin biasanya tidak melibatkan data dalam phone. Walaupun begitu, kami sentiasa cadangkan anda backup data dahulu jika boleh.'),
    @('Phone jenama apa yang boleh tukar skrin?','iPhone, Samsung, Oppo, Vivo, Xiaomi, Huawei, Realme dan Honor. Hantar model phone anda melalui WhatsApp untuk semak stok skrin.'))
  related=@('phone-repair/tukar-bateri','phone-repair/motherboard','phone-repair/repair-iphone','phone-repair/repair-samsung')
}
$PAGES['phone-repair/tukar-bateri'] = @{
  sec='phone'; icon='battery'; wa='tukar bateri phone'
  title='Tukar Bateri Phone Telok Panglima Garang | FM Mobile Fix'
  desc='Bateri cepat habis, kembung atau phone mati sendiri? Tukar bateri iPhone, Samsung &amp; Android di Telok Panglima Garang. Waranti 3 bulan. WhatsApp kami.'
  crumb='Tukar Bateri'; eyebrow='Repair Phone &middot; Tukar Bateri'
  h1='Tukar Bateri Phone Cepat Habis &amp; Kembung'
  lead='Bateri cepat kong, kembung atau phone tiba-tiba mati? Kami ganti bateri untuk iPhone dan Android, dan uji phone sebelum dipulangkan kepada anda.'
  hero='10-bateri-iphone.jpg'; heroAlt='Tukar bateri iPhone di FM Mobile Fix Telok Panglima Garang'
  facts=@('Semakan dulu sebelum repair','Waranti 3 bulan untuk bateri','iPhone &amp; Android')
  symTitle='Tanda bateri phone anda perlu ditukar'
  sym=@(
    @('battery','Bateri cepat habis','Peratus bateri jatuh dengan cepat walaupun phone tidak digunakan banyak.'),
    @('shield','Bateri kembung','Skrin atau penutup belakang terangkat. Elakkan cas phone sehingga ia diperiksa.'),
    @('phone','Phone mati sendiri','Phone tertutup tiba-tiba walaupun peratus bateri masih ada.'),
    @('plug','Lambat cas atau tak naik','Peratus bateri naik terlalu perlahan atau langsung tidak bertambah.'))
  prose=@('Tak semua masalah bateri datang dari bateri itu sendiri. Kadang-kadang punca sebenar ialah port charging, kabel atau adapter. Sebab itu kami periksa dahulu sebelum mencadangkan tukar bateri.')
  warranty=$true
  photos=@(@('10-bateri-iphone.jpg','Tukar bateri iPhone, siap dan sedia digunakan semula.'),@('09-iphone-siap.jpg','iPhone siap repair dan diuji sebelum dipulangkan.'))
  reviews=@('hazril','aiman','amirul')
  faq=@(
    @('Berapa lama masa untuk tukar bateri?','Untuk kebanyakan model, tukar bateri boleh siap dengan cepat. Salah seorang pelanggan kami siap tukar bateri iPhone 13 dalam 30 minit. Kami akan maklumkan anggaran masa selepas semak model anda.'),
    @('Ada waranti untuk tukar bateri?','Ada. Tukar bateri datang dengan waranti 3 bulan, bergantung pada jenis spare part.'),
    @('Bateri kembung bahaya tak?','Bateri kembung boleh menolak skrin dan merosakkan komponen lain. Kami cadangkan anda berhenti mengecas phone dan bawa untuk diperiksa secepat mungkin.'),
    @('Phone saya tak boleh charge, perlu tukar bateri?','Belum tentu. Masalah tak boleh charge juga boleh datang dari port charging. Kami diagnosis dahulu sebelum cadangkan apa-apa.'))
  related=@('phone-repair/charging-port','phone-repair/tukar-skrin','phone-repair/repair-iphone','phone-repair/repair-oppo-vivo-xiaomi')
}
$PAGES['phone-repair/phone-masuk-air'] = @{
  sec='phone'; icon='water'; wa='phone masuk air'
  title='Repair Phone Masuk Air Telok Panglima Garang | FM Mobile Fix'
  desc='Phone masuk air, tak boleh on atau skrin bertompok? Bawa segera ke FM Mobile Fix, Telok Panglima Garang untuk pembersihan dan repair water damage.'
  crumb='Phone Masuk Air'; eyebrow='Repair Phone &middot; Water Damage'
  h1='Repair Phone Masuk Air (Water Damage)'
  lead='Phone terjatuh dalam air, kena hujan atau tertumpah air? Lebih cepat phone diperiksa, lebih tinggi peluang untuk diselamatkan.'
  hero='stock/phone-masuk-air.jpg'; heroAlt='Phone basah terkena air'
  facts=@('Bawa secepat mungkin','Semakan board','iPhone &amp; Android')
  symTitle='Tanda phone anda terkena kerosakan air'
  sym=@(
    @('phone','Tak boleh on selepas basah','Phone mati atau tidak hidup semula selepas terkena air.'),
    @('screen','Skrin bertompok atau bergaris','Ada tompok, kesan air atau garisan pada paparan.'),
    @('mic','Speaker atau mic tak jelas','Suara pecah, perlahan atau orang tak dengar anda bercakap.'),
    @('plug','Tak boleh charge','Phone tidak mengecas atau keluar amaran cecair pada port.'))
  prose=@('<b>Apa perlu buat sekarang:</b> matikan phone, jangan cas, jangan guna hair dryer dan jangan bergantung pada beras. Air dan kotoran boleh kekal di dalam dan menyebabkan karat pada board.','Bawa phone ke kedai secepat mungkin supaya kami boleh buka, bersihkan komponen dalaman dan periksa kerosakan pada board.')
  warranty=$false
  photos=@(@('04-motherboard-iphone.jpg','Kerja repair motherboard di meja technician kami.'),@('03-iphone-13-pro-max-board.jpg','iPhone 13 Pro Max siap repair motherboard.'))
  reviews=@('amar','ezam','azzoo')
  faq=@(
    @('Phone yang masuk air masih boleh diselamatkan?','Banyak phone masih boleh diselamatkan, tetapi bergantung pada berapa lama ia basah dan tahap kerosakan pada board. Kami akan periksa dan terangkan peluangnya sebelum repair.'),
    @('Perlu letak phone dalam beras?','Kami tak cadangkan bergantung pada beras. Air dan kotoran boleh kekal di dalam phone. Matikan phone dan bawa untuk diperiksa.'),
    @('Data dalam phone boleh diselamatkan?','Bergantung pada keadaan board. Kami akan cuba sebaik mungkin dan maklumkan anda selepas semakan.'),
    @('Ada waranti untuk repair phone masuk air?','Waranti bergantung pada jenis kerosakan dan alat ganti yang digunakan. Kami akan maklumkan sebelum repair dimulakan.'))
  related=@('phone-repair/motherboard','phone-repair/charging-port','phone-repair/tukar-skrin')
}
$PAGES['phone-repair/charging-port'] = @{
  sec='phone'; icon='plug'; wa='repair charging port phone'
  title='Repair Charging Port Telok Panglima Garang | FM Mobile Fix'
  desc='Phone tak boleh charge, kabel longgar atau perlu goyang kabel? Repair charging port iPhone &amp; Android di FM Mobile Fix, Telok Panglima Garang.'
  crumb='Charging Port'; eyebrow='Repair Phone &middot; Charging Port'
  h1='Phone Tak Boleh Charge? Repair Charging Port'
  lead='Kena goyang kabel baru boleh cas, atau langsung tak masuk cas? Masalah ini selalunya boleh dibaiki tanpa perlu tukar phone baru.'
  hero='stock/charging-port-phone.jpg'; heroAlt='Close-up port charging phone'
  facts=@('Semakan dulu sebelum repair','Penerangan yang jelas','iPhone &amp; Android')
  symTitle='Tanda charging port phone anda bermasalah'
  sym=@(
    @('plug','Perlu goyang kabel','Phone hanya mengecas bila kabel dipegang pada sudut tertentu.'),
    @('battery','Tak masuk cas langsung','Tiada tanda mengecas walaupun guna kabel dan adapter lain.'),
    @('clock','Cas sangat perlahan','Phone mengambil masa terlalu lama untuk penuh.'),
    @('laptop','Tak dikesan oleh komputer','Phone tidak dikenali bila disambung ke komputer.'))
  prose=@('Kadang-kadang port cuma tersumbat dengan habuk atau kotoran dari poket. Kami periksa dan bersihkan dahulu. Jika port memang rosak, barulah kami cadangkan untuk diganti.')
  warranty=$false
  photos=@()
  reviews=@('ezam','nurhafizah','syira')
  faq=@(
    @('Berapa lama masa untuk repair charging port?','Bergantung pada model phone dan sama ada port perlu dibersihkan atau diganti. Kami akan maklumkan anggaran masa selepas semakan.'),
    @('Kenapa phone saya mengecas perlahan?','Boleh jadi disebabkan kabel, adapter, port yang kotor atau bateri yang lemah. Kami semak satu persatu untuk cari punca sebenar.'),
    @('Perlu tukar bateri juga?','Tak semestinya. Jika port yang rosak, bateri biasanya tidak perlu ditukar. Kami akan terangkan apa yang kami jumpa.'))
  related=@('phone-repair/tukar-bateri','phone-repair/phone-masuk-air','phone-repair/motherboard')
}
$PAGES['phone-repair/motherboard'] = @{
  sec='phone'; icon='chip'; wa='repair motherboard phone'
  title='Repair Motherboard Phone Telok Panglima Garang'
  desc='Phone mati total, restart sendiri, No Service atau tak detect SIM? Repair motherboard (board level) iPhone &amp; Android di FM Mobile Fix, Telok Panglima Garang.'
  crumb='Repair Motherboard'; eyebrow='Repair Phone &middot; Motherboard'
  h1='Repair Motherboard: Phone Tak Boleh On &amp; No Service'
  lead='Phone mati total, asyik restart, tiada line atau tak detect SIM card? Kami buat diagnosis dan repair pada peringkat board.'
  hero='03-iphone-13-pro-max-board.jpg'; heroAlt='iPhone 13 Pro Max No Service siap repair motherboard'
  facts=@('Diagnosis peringkat board','Peralatan khas','Bincang kos dulu')
  symTitle='Masalah yang biasanya melibatkan motherboard'
  sym=@(
    @('phone','Phone mati total','Tiada respon langsung walaupun dicas dan butang power ditekan.'),
    @('clock','Restart sendiri','Phone asyik tersekat pada logo atau restart berulang kali.'),
    @('scan','No Service atau tiada line','Tiada signal walaupun SIM card berfungsi dalam phone lain.'),
    @('chip','Tak detect SIM card','Phone tidak mengesan SIM card yang dimasukkan.'))
  prose=@('Repair motherboard memerlukan peralatan khas seperti mikroskop dan stesen soldering. Kami periksa litar untuk mencari komponen yang rosak, kemudian berbincang dengan anda tentang penyelesaian dan kos sebelum mula.')
  warranty=$false
  photos=@(@('03-iphone-13-pro-max-board.jpg','iPhone 13 Pro Max No Service, siap repair bottom layer.'),@('04-motherboard-iphone.jpg','Kerja repair motherboard iPhone di meja technician kami.'))
  reviews=@('amar','azzoo','parrahaina')
  faq=@(
    @('Boleh repair phone yang mati total?','Selalunya boleh diperiksa. Phone mati total boleh disebabkan bateri, port charging atau komponen pada board. Kami diagnosis dahulu dan terangkan apa yang kami jumpa.'),
    @('Data saya selamat bila repair motherboard?','Kami berhati-hati dengan data anda, tetapi keadaan data bergantung pada kerosakan board. Kami akan maklumkan risiko sebelum mula.'),
    @('Berapa lama masa untuk repair motherboard?','Repair board biasanya mengambil masa lebih lama berbanding tukar skrin atau bateri. Kami akan beri anggaran masa selepas diagnosis.'))
  related=@('phone-repair/phone-masuk-air','phone-repair/repair-iphone','phone-repair/tukar-bateri')
}
$PAGES['phone-repair/repair-iphone'] = @{
  sec='phone'; icon='phone'; wa='repair iPhone'
  title='Repair iPhone Telok Panglima Garang | FM Mobile Fix'
  desc='Kedai repair iPhone di Telok Panglima Garang: tukar skrin, tukar bateri, charging port dan repair motherboard (No Service). Waranti 3 bulan untuk bateri &amp; LCD.'
  crumb='Repair iPhone'; eyebrow='Repair Phone &middot; iPhone'
  h1='Repair iPhone di Telok Panglima Garang'
  lead='Dari iPhone lama hingga model Pro Max, kami tukar skrin, bateri dan port charging, serta repair motherboard untuk masalah No Service.'
  hero='01-iphone-x-skrin.jpg'; heroAlt='Before dan after tukar skrin iPhone X'
  facts=@('Waranti 3 bulan bateri &amp; LCD','Repair board','Semakan dulu')
  symTitle='Servis iPhone kami'
  sym=@(
    @('screen','Tukar skrin iPhone','Skrin pecah, bergaris hijau atau touch tak berfungsi.'),
    @('battery','Tukar bateri iPhone','Bateri cepat habis, kembung atau phone mati sendiri.'),
    @('plug','Charging port iPhone','Lambat cas, kabel longgar atau tak masuk cas.'),
    @('chip','No Service &amp; motherboard','Tiada line, mati total atau restart sendiri.'))
  prose=@('Hantar model iPhone dan masalah anda melalui WhatsApp untuk semakan awal. Selepas diagnosis di kedai, kami terangkan penyelesaian dan kos sebelum repair dimulakan.')
  warranty=$true
  photos=@(@('01-iphone-x-skrin.jpg','iPhone X, before &amp; after tukar skrin.'),@('03-iphone-13-pro-max-board.jpg','iPhone 13 Pro Max No Service, siap repair board.'),@('10-bateri-iphone.jpg','Tukar bateri iPhone, siap dan sedia digunakan.'))
  reviews=@('hazril','azzahra','parrahaina')
  faq=@(
    @('Model iPhone apa yang anda repair?','Kebanyakan model iPhone. Hantar model anda melalui WhatsApp supaya kami boleh semak stok alat ganti.'),
    @('Ada waranti untuk repair iPhone?','Tukar bateri dan LCD datang dengan waranti 3 bulan, bergantung pada jenis spare part. Untuk repair lain, kami maklumkan waranti sebelum mula.'),
    @('iPhone saya No Service, boleh repair?','Masalah No Service selalunya melibatkan board. Kami pernah siapkan repair bottom layer untuk iPhone 13 Pro Max. Bawa untuk diagnosis dan kami terangkan pilihannya.'))
  related=@('phone-repair/tukar-skrin','phone-repair/tukar-bateri','phone-repair/motherboard','phone-repair/repair-samsung')
}
$PAGES['phone-repair/repair-samsung'] = @{
  sec='phone'; icon='phone'; wa='repair Samsung'
  title='Repair Samsung Telok Panglima Garang | FM Mobile Fix'
  desc='Repair Samsung Galaxy siri A, S, Note dan Z di Telok Panglima Garang: tukar skrin, tukar bateri, charging port dan motherboard. WhatsApp untuk semakan.'
  crumb='Repair Samsung'; eyebrow='Repair Phone &middot; Samsung'
  h1='Repair Samsung Galaxy di Telok Panglima Garang'
  lead='Siri A, siri S, Note atau phone lipat, kami tukar skrin, bateri dan charging port Samsung, serta repair motherboard.'
  hero='05-samsung-skrin.jpg'; heroAlt='Samsung skrin pecah siap tukar skrin baru'
  facts=@('Waranti 3 bulan bateri &amp; LCD','Termasuk phone lipat','Semakan dulu')
  symTitle='Servis Samsung kami'
  sym=@(
    @('screen','Tukar skrin Samsung','Skrin pecah, garisan hijau atau paparan gelap.'),
    @('battery','Tukar bateri Samsung','Bateri cepat habis atau kembung.'),
    @('plug','Charging port Samsung','Tak boleh charge atau cas perlahan.'),
    @('chip','Motherboard Samsung','Mati total, restart sendiri atau tiada line.'))
  prose=@('Garisan pada skrin Samsung selalunya tanda panel paparan rosak. Hantar gambar skrin melalui WhatsApp untuk semakan awal, kemudian kami sahkan di kedai sebelum repair.')
  warranty=$true
  photos=@(@('05-samsung-skrin.jpg','Samsung skrin pecah teruk, siap tukar skrin baru.'),@('08-phone-flip.jpg','Phone lipat, tukar skrin dalam dan diuji.'))
  reviews=@('amirul','aiman','zuhaidah')
  faq=@(
    @('Model Samsung apa yang anda repair?','Siri Galaxy A, S, Note dan Z. Hantar model anda melalui WhatsApp untuk semak stok alat ganti.'),
    @('Skrin Samsung saya ada garisan hijau, kenapa?','Garisan pada skrin AMOLED biasanya tanda panel paparan rosak dan perlu ditukar. Kami akan sahkan selepas semakan.'),
    @('Ada waranti?','Tukar bateri dan LCD datang dengan waranti 3 bulan, bergantung pada jenis spare part.'))
  related=@('phone-repair/tukar-skrin','phone-repair/tukar-bateri','phone-repair/repair-oppo-vivo-xiaomi')
}
$PAGES['phone-repair/repair-oppo-vivo-xiaomi'] = @{
  sec='phone'; icon='phone'; wa='repair Oppo / Vivo / Xiaomi'
  title='Repair Oppo, Vivo &amp; Xiaomi Telok Panglima Garang'
  desc='Repair phone Oppo, Vivo, Xiaomi (Redmi &amp; Poco), Huawei, Realme dan Honor di Telok Panglima Garang: tukar skrin, bateri, butang dan charging port.'
  crumb='Oppo, Vivo &amp; Xiaomi'; eyebrow='Repair Phone &middot; Android'
  h1='Repair Oppo, Vivo, Xiaomi, Huawei &amp; Realme'
  lead='Phone Android anda rosak? Kami repair jenama popular seperti Oppo, Vivo, Xiaomi (Redmi &amp; Poco), Huawei, Realme dan Honor.'
  hero='02-oppo-n3-flip-lcd.jpg'; heroAlt='Oppo Find N3 Flip masalah LCD, before dan after repair'
  facts=@('Waranti 3 bulan bateri &amp; LCD','Butang &amp; charging port','Semakan dulu')
  symTitle='Masalah phone Android yang kami baiki'
  sym=@(
    @('screen','Skrin &amp; LCD','Skrin pecah, bergaris atau paparan bermasalah.'),
    @('battery','Bateri','Cepat habis, kembung atau phone mati sendiri.'),
    @('wrench','Butang power &amp; volume','Butang tenggelam, patah atau tidak berfungsi.'),
    @('plug','Charging port','Tak boleh charge atau kabel longgar.'))
  prose=@('Spare part untuk sesetengah model mungkin perlu ditempah dahulu. Hantar model phone anda melalui WhatsApp dan kami akan semak stok sebelum anda datang.')
  warranty=$true
  photos=@(@('02-oppo-n3-flip-lcd.jpg','Oppo Find N3 Flip, masalah LCD dibaiki.'),@('07-tukar-skrin-2.jpg','Tukar skrin pecah, touch dan paparan berfungsi semula.'))
  reviews=@('nurhafizah','harraz','syira')
  faq=@(
    @('Butang power atau volume rosak boleh repair?','Boleh. Contohnya, kami pernah baiki butang power dan volume phone Oppo pada hari yang sama.'),
    @('Spare part untuk model saya ada?','Bergantung pada model. Sesetengah spare part perlu ditempah. Hantar model phone anda melalui WhatsApp untuk semakan stok.'),
    @('Ada waranti?','Tukar bateri dan LCD datang dengan waranti 3 bulan, bergantung pada jenis spare part.'))
  related=@('phone-repair/tukar-skrin','phone-repair/tukar-bateri','phone-repair/charging-port','phone-repair/repair-samsung')
}

# ---------------------------- LAPTOP --------------------------------
$PAGES['laptop-repair/tukar-skrin-laptop'] = @{
  sec='laptop'; icon='screen'; wa='tukar skrin laptop'
  title='Tukar Skrin Laptop Telok Panglima Garang | FM Mobile Fix'
  desc='Skrin laptop retak, bergaris, berkelip atau gelap? Tukar skrin laptop ASUS, Acer, Lenovo, HP, Dell, MSI dan MacBook di FM Mobile Fix, Telok Panglima Garang.'
  crumb='Tukar Skrin Laptop'; eyebrow='Repair Laptop &middot; Skrin'
  h1='Tukar Skrin Laptop Pecah, Bergaris &amp; Gelap'
  lead='Skrin laptop retak, ada garisan, berkelip atau gelap? Kami tukar panel skrin untuk ASUS, Acer, Lenovo, HP, Dell, MSI dan MacBook.'
  hero='stock/skrin-laptop-pecah.jpg'; heroAlt='Skrin laptop pecah yang perlu ditukar'
  facts=@('Semakan dulu sebelum repair','Semua jenama utama','Semak stok panel')
  symTitle='Tanda skrin laptop anda perlu ditukar'
  sym=@(
    @('screen','Skrin retak','Retak selepas terjatuh atau tertekan semasa ditutup.'),
    @('scan','Garisan atau berkelip','Garisan menegak atau mendatar, atau paparan berkelip.'),
    @('laptop','Skrin gelap tapi laptop hidup','Lampu dan kipas berfungsi tetapi tiada paparan.'),
    @('spark','Warna pelik atau bertompok','Tompok gelap, cahaya tidak sekata atau warna salah.'))
  prose=@('Skrin gelap tidak semestinya panel yang rosak. Ia juga boleh disebabkan kabel skrin atau masalah pada board. Kami periksa dahulu untuk pastikan punca sebenar sebelum menukar panel.')
  warranty=$false
  photos=@()
  reviews=@('syira','harraz','azzoo')
  faq=@(
    @('Apa yang perlu saya beritahu untuk semak harga skrin?','Hantar jenama dan model laptop anda (biasanya ada pada label di bawah laptop) melalui WhatsApp supaya kami boleh semak panel yang sesuai.'),
    @('Berapa lama masa untuk tukar skrin laptop?','Bergantung pada stok panel. Sesetengah panel perlu ditempah dahulu. Kami akan maklumkan anggaran masa selepas semakan.'),
    @('Ada waranti?','Ada. Tempoh waranti bergantung pada jenis spare part dan akan dimaklumkan sebelum repair.'))
  related=@('laptop-repair/laptop-tak-boleh-on','laptop-repair/upgrade-ssd-ram','laptop-repair/repair-macbook')
}
$PAGES['laptop-repair/upgrade-ssd-ram'] = @{
  sec='laptop'; icon='ssd'; wa='upgrade SSD &amp; RAM laptop'
  title='Upgrade SSD &amp; RAM Laptop Telok Panglima Garang'
  desc='Laptop lambat, selalu hang atau storan penuh? Upgrade SSD dan RAM laptop di FM Mobile Fix, Telok Panglima Garang. Hantar model laptop untuk semak pilihan upgrade.'
  crumb='Upgrade SSD &amp; RAM'; eyebrow='Repair Laptop &middot; Upgrade'
  h1='Upgrade SSD &amp; RAM untuk Laptop Perlahan'
  lead='Laptop lambat buka, selalu hang atau storan penuh? Upgrade SSD dan RAM antara cara paling berbaloi untuk laptop lama terasa laju semula.'
  hero='stock/ram-laptop.jpg'; heroAlt='RAM laptop untuk upgrade'
  facts=@('Semak model dulu','SSD &amp; RAM','Bincang pilihan data')
  symTitle='Tanda laptop anda perlukan upgrade'
  sym=@(
    @('clock','Lambat start up','Laptop mengambil masa lama untuk sampai ke desktop.'),
    @('software','Selalu hang','Laptop tersekat bila buka aplikasi atau banyak tab.'),
    @('ssd','Storan penuh','Ruang storan tidak cukup untuk fail dan update.'),
    @('fan','Perlahan bila multitasking','Laptop jadi perlahan bila buka beberapa aplikasi serentak.'))
  prose=@('Tak semua laptop boleh di-upgrade. Sesetengah model ada RAM atau storan yang dipasang terus pada board. Hantar model laptop anda dan kami akan semak pilihan upgrade yang sesuai.','Jika laptop masih menggunakan hard disk biasa, upgrade ke SSD biasanya memberi perbezaan paling ketara. RAM pula membantu bila anda membuka banyak aplikasi serentak.')
  warranty=$false
  photos=@()
  reviews=@('syira','harraz','amirul')
  faq=@(
    @('Data saya hilang tak bila upgrade SSD?','Beritahu kami fail penting yang perlu disimpan. Kami akan bincang pilihan untuk data anda sebelum kerja dimulakan.'),
    @('SSD atau RAM, mana lebih penting?','Jika laptop masih guna hard disk biasa, SSD biasanya beri perbezaan paling besar. RAM membantu untuk multitasking.'),
    @('Semua laptop boleh upgrade RAM?','Tidak. Sesetengah model ada RAM yang dipasang terus pada board. Hantar model laptop anda untuk semakan.'))
  related=@('laptop-repair/install-windows','laptop-repair/laptop-tak-boleh-on','laptop-repair/repair-macbook')
}
$PAGES['laptop-repair/laptop-tak-boleh-on'] = @{
  sec='laptop'; icon='chip'; wa='laptop tak boleh on'
  title='Laptop Tak Boleh On? Repair di Telok Panglima Garang'
  desc='Laptop mati total, tak boleh charge atau mati sendiri? Diagnosis charger, bateri, DC jack hingga motherboard di FM Mobile Fix, Telok Panglima Garang.'
  crumb='Laptop Tak Boleh On'; eyebrow='Repair Laptop &middot; Motherboard &amp; Charging'
  h1='Laptop Tak Boleh On atau Tak Boleh Charge'
  lead='Tekan butang power tapi tiada apa-apa? Lampu cas tak menyala? Kami diagnosis dari charger, bateri dan DC jack hingga ke motherboard.'
  hero='stock/motherboard-laptop.jpg'; heroAlt='Motherboard laptop dibuka untuk diagnosis'
  facts=@('Diagnosis menyeluruh','Bincang kos dulu','Semua jenama utama')
  symTitle='Masalah kuasa laptop yang kami baiki'
  sym=@(
    @('laptop','Mati total','Tiada lampu, tiada bunyi kipas bila butang power ditekan.'),
    @('screen','Lampu menyala, skrin gelap','Laptop seperti hidup tetapi tiada paparan.'),
    @('plug','Tak boleh charge','Lampu cas tidak menyala atau bateri tidak naik.'),
    @('fan','Mati sendiri bila panas','Laptop tertutup sendiri selepas digunakan sebentar.'))
  prose=@('Laptop yang tidak boleh hidup boleh disebabkan banyak perkara, dari charger yang rosak hingga komponen pada motherboard. Kami periksa satu persatu supaya anda hanya membayar untuk kerosakan sebenar.')
  warranty=$false
  photos=@()
  reviews=@('azzoo','amirul','harraz')
  faq=@(
    @('Laptop saya mati total, boleh repair?','Selalunya boleh diperiksa. Kami diagnosis dahulu dan terangkan punca serta pilihan repair sebelum mula.'),
    @('Perlu bawa charger sekali?','Ya, bawa sekali charger laptop anda supaya kami boleh uji sama ada charger juga bermasalah.'),
    @('Berapa lama masa untuk repair?','Bergantung pada punca kerosakan. Repair motherboard biasanya mengambil masa lebih lama. Kami beri anggaran masa selepas diagnosis.'))
  related=@('laptop-repair/tukar-skrin-laptop','laptop-repair/install-windows','laptop-repair/repair-macbook')
}
$PAGES['laptop-repair/install-windows'] = @{
  sec='laptop'; icon='software'; wa='install Windows / masalah software laptop'
  title='Install Windows Laptop Telok Panglima Garang | FM Mobile Fix'
  desc='Laptop blue screen, tak boleh boot atau asyik restart? Install semula Windows dan selesaikan masalah software laptop di FM Mobile Fix, Telok Panglima Garang.'
  crumb='Install Windows'; eyebrow='Repair Laptop &middot; Software'
  h1='Install Windows &amp; Selesaikan Masalah Software Laptop'
  lead='Laptop asyik restart, blue screen, tak boleh boot atau terlalu perlahan kerana software? Kami bantu install semula Windows dan selesaikan masalah sistem.'
  hero='stock/install-windows-laptop.jpg'; heroAlt='Laptop dengan sistem Windows'
  facts=@('Install Windows','Masalah boot','Bincang backup dulu')
  symTitle='Masalah software yang kami selesaikan'
  sym=@(
    @('software','Blue screen','Laptop keluar skrin biru dan restart sendiri.'),
    @('clock','Tak boleh boot','Tersekat pada logo atau loading tanpa henti.'),
    @('scan','Ralat sistem operasi','Mesej ralat berulang atau update gagal.'),
    @('shield','Perlahan kerana software','Terlalu banyak program atau perisian yang mengganggu.'))
  prose=@('Install semula Windows boleh memadam data dalam drive sistem. Sebelum mula, beritahu kami fail penting yang perlu disimpan dan kami akan bincang pilihan backup bersama anda.')
  warranty=$false
  photos=@()
  reviews=@('syira','harraz','amirul')
  faq=@(
    @('Data saya hilang bila install Windows?','Install semula boleh memadam data dalam drive sistem. Beritahu kami fail penting dan kami bincang pilihan backup sebelum mula.'),
    @('Kenapa laptop saya blue screen?','Blue screen boleh disebabkan masalah software, driver atau hardware seperti RAM dan storan. Kami semak untuk cari punca sebenar.'),
    @('Laptop saya perlahan, perlu install semula?','Belum tentu. Kadang-kadang upgrade ke SSD lebih berkesan. Kami akan cadangkan pilihan terbaik selepas semakan.'))
  related=@('laptop-repair/upgrade-ssd-ram','laptop-repair/laptop-tak-boleh-on')
}
$PAGES['laptop-repair/repair-macbook'] = @{
  sec='laptop'; icon='laptop'; wa='repair MacBook'
  title='Repair MacBook Telok Panglima Garang | FM Mobile Fix'
  desc='MacBook Air atau MacBook Pro bermasalah? Semakan skrin, bateri, keyboard, charging dan macOS di FM Mobile Fix, Telok Panglima Garang. WhatsApp untuk semakan.'
  crumb='Repair MacBook'; eyebrow='Repair Laptop &middot; MacBook'
  h1='Repair MacBook di Telok Panglima Garang'
  lead='MacBook Air atau MacBook Pro bermasalah? Kami semak masalah skrin, bateri, keyboard, charging dan sistem macOS.'
  hero='stock/repair-macbook.jpg'; heroAlt='MacBook dibuka untuk repair'
  facts=@('MacBook Air &amp; Pro','Semakan dulu','Bincang kos dulu')
  symTitle='Masalah MacBook yang kami semak'
  sym=@(
    @('screen','Skrin MacBook','Skrin retak, bergaris atau gelap.'),
    @('battery','Bateri MacBook','Bateri cepat habis atau keluar amaran Service Battery.'),
    @('keyboard','Keyboard &amp; trackpad','Butang tak berfungsi atau trackpad tidak respon.'),
    @('plug','Tak boleh charge atau hidup','MacBook tidak mengecas atau langsung tidak hidup.'))
  prose=@('Hantar model MacBook anda (contohnya MacBook Air M1 atau MacBook Pro 2019) melalui WhatsApp untuk semakan awal. Kami terangkan penyelesaian dan kos sebelum repair dimulakan.')
  warranty=$false
  photos=@()
  reviews=@('azzoo','syira','parrahaina')
  faq=@(
    @('Model MacBook apa yang anda repair?','MacBook Air dan MacBook Pro. Hantar model anda melalui WhatsApp supaya kami boleh semak alat ganti.'),
    @('MacBook saya terkena air, apa perlu buat?','Matikan MacBook, cabut charger dan jangan cuba hidupkan. Bawa ke kedai secepat mungkin untuk diperiksa.'),
    @('Ada waranti?','Tempoh waranti bergantung pada jenis repair dan spare part, dan akan dimaklumkan sebelum repair dimulakan.'))
  related=@('laptop-repair/tukar-skrin-laptop','laptop-repair/laptop-tak-boleh-on','laptop-repair/upgrade-ssd-ram')
}

# Link labels + icons used by footer / related cards
$LABEL = [ordered]@{
  'phone-repair/tukar-skrin'=@('screen','Tukar Skrin Phone')
  'phone-repair/tukar-bateri'=@('battery','Tukar Bateri Phone')
  'phone-repair/phone-masuk-air'=@('water','Phone Masuk Air')
  'phone-repair/charging-port'=@('plug','Charging Port Phone')
  'phone-repair/motherboard'=@('chip','Repair Motherboard Phone')
  'phone-repair/repair-iphone'=@('phone','Repair iPhone')
  'phone-repair/repair-samsung'=@('phone','Repair Samsung')
  'phone-repair/repair-oppo-vivo-xiaomi'=@('phone','Repair Oppo, Vivo &amp; Xiaomi')
  'laptop-repair/tukar-skrin-laptop'=@('screen','Tukar Skrin Laptop')
  'laptop-repair/upgrade-ssd-ram'=@('ssd','Upgrade SSD &amp; RAM')
  'laptop-repair/laptop-tak-boleh-on'=@('chip','Laptop Tak Boleh On')
  'laptop-repair/install-windows'=@('software','Install Windows')
  'laptop-repair/repair-macbook'=@('laptop','Repair MacBook')
}

$AREAS = @(
  @('Telok Panglima Garang','Kedai kami terletak di Jalan Murai, Kampung Batu 9 Kebun Baru. Penduduk Telok Panglima Garang boleh terus singgah dalam waktu operasi.','Telok+Panglima+Garang,+Selangor'),
  @('Jalan Murai &amp; Kebun Baru','Untuk penduduk sekitar Jalan Murai dan Kampung Batu 9 Kebun Baru, kedai kami hanya di kawasan anda sendiri.','Kampung+Batu+9+Kebun+Baru,+Selangor'),
  @('Rimbayu','Penduduk Bandar Rimbayu boleh WhatsApp dahulu untuk semakan awal, kemudian datang ke kedai kami di Telok Panglima Garang.','Bandar+Rimbayu,+Selangor'),
  @('Jalan Kebun','Dari kawasan Jalan Kebun, kedai kami mudah dicapai. Tekan butang di bawah untuk arah dari lokasi anda.','Jalan+Kebun,+Shah+Alam,+Selangor'),
  @('Shah Alam','Pelanggan dari Shah Alam boleh hantar model dan masalah device melalui WhatsApp dahulu sebelum datang ke kedai.','Shah+Alam,+Selangor')
)

. (Join-Path $PSScriptRoot 'tips-data.ps1')

# ---------------------------------------------------------------------
#  Building blocks
# ---------------------------------------------------------------------
function JsonLd($P, $path, $title, $desc, $crumbs, $svcName, $faq, $extra) {
  $url = $SITE + '/' + $path
  $g = New-Object System.Collections.Generic.List[string]
  $g.Add('{"@type":"MobilePhoneStore","@id":"' + $SITE + '/#business","name":"FM MOBILE FIX","url":"' + $SITE + '/","image":"' + $SITE + '/assets/img/og-image.jpg","logo":"' + $SITE + '/assets/img/logo-full.png","telephone":"+601157558115","address":{"@type":"PostalAddress","streetAddress":"Lot 3745, Jalan Murai, Kampung Batu 9 Kebun Baru","addressLocality":"Telok Panglima Garang","addressRegion":"Selangor","postalCode":"42500","addressCountry":"MY"},"geo":{"@type":"GeoCoordinates","latitude":2.9291257,"longitude":101.4977695},"hasMap":"https://www.google.com/maps/place/?q=FM+Mobile+Fix+Telok+Panglima+Garang","areaServed":["Telok Panglima Garang","Kebun Baru","Rimbayu","Jalan Kebun","Shah Alam"],"sameAs":["https://www.facebook.com/fmmobilefix","https://www.instagram.com/fm_gadget89/","https://www.tiktok.com/@fm.mobile.fix"],"openingHoursSpecification":[{"@type":"OpeningHoursSpecification","dayOfWeek":["Monday","Tuesday","Wednesday","Thursday","Saturday"],"opens":"10:00","closes":"21:00"},{"@type":"OpeningHoursSpecification","dayOfWeek":"Sunday","opens":"12:00","closes":"21:00"},{"@type":"OpeningHoursSpecification","dayOfWeek":"Friday","opens":"10:00","closes":"13:00"},{"@type":"OpeningHoursSpecification","dayOfWeek":"Friday","opens":"15:00","closes":"21:00"}]}')
  $g.Add('{"@type":"WebPage","@id":"' + $url + '#webpage","url":"' + $url + '","name":"' + (JsonStr $title) + '","description":"' + (JsonStr $desc) + '","inLanguage":"ms-MY","isPartOf":{"@id":"' + $SITE + '/#website"}}')
  $items = @(); $pos = 1
  foreach ($c in $crumbs) { $items += '{"@type":"ListItem","position":' + $pos + ',"name":"' + (JsonStr $c[0]) + '","item":"' + $SITE + '/' + $c[1] + '"}'; $pos++ }
  if ($items.Count -ge 2) { $g.Add('{"@type":"BreadcrumbList","itemListElement":[' + ($items -join ',') + ']}') }
  if ($svcName) {
    $g.Add('{"@type":"Service","name":"' + (JsonStr $svcName) + '","serviceType":"' + (JsonStr $svcName) + '","provider":{"@id":"' + $SITE + '/#business"},"areaServed":["Telok Panglima Garang","Rimbayu","Jalan Kebun","Shah Alam"],"url":"' + $url + '"}')
  }
  if ($faq -and $faq.Count) {
    $qs = @()
    foreach ($f in $faq) { $qs += '{"@type":"Question","name":"' + (JsonStr $f[0]) + '","acceptedAnswer":{"@type":"Answer","text":"' + (JsonStr $f[1]) + '"}}' }
    $g.Add('{"@type":"FAQPage","mainEntity":[' + ($qs -join ',') + ']}')
  }
  if ($extra) { $g.Add($extra) }
  return '<script type="application/ld+json">' + "`n" + '{"@context":"https://schema.org","@graph":[' + "`n" + ($g -join ",`n") + "`n]}`n</script>"
}

function Head($P, $path, $title, $desc, $ogImg, $ld) {
  $url = $SITE + '/' + $path
@"
<!DOCTYPE html>
<html lang="ms">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>$title</title>
<meta name="description" content="$desc">
<link rel="canonical" href="$url">
<meta name="robots" content="index, follow, max-image-preview:large">
<meta name="theme-color" content="#101014">
<meta name="geo.region" content="MY-10">
<meta name="geo.placename" content="Telok Panglima Garang">
<meta name="geo.position" content="2.9291257;101.4977695">
<meta property="og:type" content="website">
<meta property="og:locale" content="ms_MY">
<meta property="og:site_name" content="FM MOBILE FIX">
<meta property="og:title" content="$title">
<meta property="og:description" content="$desc">
<meta property="og:url" content="$url">
<meta property="og:image" content="$SITE/assets/img/$ogImg">
<meta name="twitter:card" content="summary_large_image">
<link rel="icon" type="image/png" href="${P}assets/img/favicon.png">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@600;700;800&family=Barlow+Condensed:ital,wght@0,800;1,800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${P}assets/css/brand.css">
$ld
</head>
"@
}

function NavHtml($P, $sec) {
  $cp = ''; $cl = ''
  if ($sec -eq 'phone') { $cp = ' aria-current="page"' }
  if ($sec -eq 'laptop') { $cl = ' aria-current="page"' }
  return '<nav class="nav" aria-label="Utama">' +
    '<a href="' + $P + 'phone-repair/"' + $cp + '>' + (I 'phone') + 'Repair Phone</a>' +
    '<a href="' + $P + 'laptop-repair/"' + $cl + '>' + (I 'laptop') + 'Repair Laptop</a>' +
    '<button type="button" data-modal="m-loc" aria-controls="m-loc" aria-expanded="false">' + (I 'pin') + 'Lokasi</button>' +
    '<button type="button" data-modal="m-tips" aria-controls="m-tips" aria-expanded="false">' + (I 'spark') + 'Tips &amp; panduan<svg class="i caret" aria-hidden="true"><use href="#i-down"/></svg></button>' +
    '</nav>'
}

function MenuTipsOpt($P) {
  return '<a class="opt" href="' + $P + 'tips/"><span class="ic ic-purp">' + (I 'spark') + '</span><span><b>Tips &amp; panduan</b><small>Panduan masalah phone &amp; laptop</small></span><svg class="i go" aria-hidden="true"><use href="#i-arrow"/></svg></a>'
}

function TipsModal($P) {
  $items = ''
  foreach ($k in $TIPS.Keys) {
    $t = $TIPS[$k]
    $items += '<a class="opt" href="' + $P + 'tips/' + $k + '/"><img src="' + $P + 'assets/img/' + $t.img + '" alt="" loading="lazy" width="56" height="56"><span><b>' + $t.title + '</b><small>' + $t.cat + '</small></span><svg class="i go" aria-hidden="true"><use href="#i-arrow"/></svg></a>'
  }
  return '<!--mtips--><div class="modal modal-drop" id="m-tips" role="dialog" aria-modal="true" aria-labelledby="m-tips-t" aria-hidden="true"><div class="modal-bg" data-close></div><div class="modal-box tips-pop"><button class="icon-btn modal-x" type="button" data-close aria-label="Tutup">' + (I 'close') + '</button><h2 id="m-tips-t">Tips &amp; panduan</h2><p class="sub">Panduan ringkas untuk masalah phone &amp; laptop.</p><div class="opt-list">' + $items + '</div><a class="btn btn-primary" href="' + $P + 'tips/">Lihat semua tips' + (I 'arrow') + '</a></div></div><!--/mtips-->'
}

function Header($P, $sec) {
  $cp = ''; $cl = ''
  if ($sec -eq 'phone') { $cp = ' aria-current="page"' }
  if ($sec -eq 'laptop') { $cl = ' aria-current="page"' }
@"
<body>
<a class="skip" href="#main">Langkau ke kandungan</a>
<header class="hdr">
 <div class="wrap">
  <a href="$P" class="logo" aria-label="FM Mobile Fix, laman utama"><img src="${P}assets/img/logo-mark.png" alt="" width="53" height="38"><span><b>FM MOB<i>i</i>LE</b> F<i>i</i>X</span></a>
  $(NavHtml $P $sec)
  <div class="hdr-r">
   <span class="badge js-badge"><i></i><span>Semak waktu operasi&hellip;</span></span>
   <a class="icon-btn fb" data-fb href="https://www.facebook.com/fmmobilefix" aria-label="Facebook FM Mobile Fix">$(I 'fb')</a>
   <a class="icon-btn tt" data-tt href="https://www.tiktok.com/@fm.mobile.fix" aria-label="TikTok FM Mobile Fix">$(I 'tt')</a>
   <a class="btn btn-primary btn-sm" data-wa="general" href="https://wa.me/601157558115" aria-label="WhatsApp FM Mobile Fix">$(I 'wa')<span class="lbl">WhatsApp</span></a>
   <button class="icon-btn burger" type="button" data-modal="m-menu" aria-controls="m-menu" aria-expanded="false" aria-label="Buka menu">$(I 'menu')</button>
  </div>
 </div>
</header>
"@
}

function FooterOnly($P) {
  $all = FooterAndModals $P
  return $all.Substring(0, $all.IndexOf('</footer>') + 9)
}

function FooterAndModals($P) {
  $phoneLinks = ''; $laptopLinks = ''
  foreach ($k in $LABEL.Keys) {
    $li = '<li><a href="' + $P + $k + '/">' + $LABEL[$k][1] + '</a></li>'
    if ($k -like 'phone-repair/*') { $phoneLinks += $li } else { $laptopLinks += $li }
  }
@"
<footer class="ftr">
 <div class="wrap">
  <div class="ftr-grid f4">
   <div>
    <img src="${P}assets/img/logo-full.png" alt="FM MOBILE FIX Service &amp; repair" width="400" height="381" loading="lazy">
    <p>Kedai repair phone &amp; laptop di Telok Panglima Garang, Selangor.</p>
    <div class="social"><a class="s-fb" data-fb href="https://www.facebook.com/fmmobilefix" aria-label="Facebook FM Mobile Fix">$(I 'fb')</a><a class="s-ig" data-ig href="https://www.instagram.com/fm_gadget89/" aria-label="Instagram FM Mobile Fix">$(I 'ig')</a><a class="s-tt" data-tt href="https://www.tiktok.com/@fm.mobile.fix" aria-label="TikTok FM Mobile Fix">$(I 'tt')</a><a class="s-wa" data-wa="general" href="https://wa.me/601157558115" aria-label="WhatsApp FM Mobile Fix">$(I 'wa')</a></div>
   </div>
   <div>
    <h4><a href="${P}phone-repair/">Repair Phone</a></h4>
    <ul>$phoneLinks</ul>
   </div>
   <div>
    <h4><a href="${P}laptop-repair/">Repair Laptop</a></h4>
    <ul>$laptopLinks</ul>
   </div>
   <div>
    <h4>Hubungi</h4>
    <ul><li>$ADDR</li><li><a data-wa="general" href="https://wa.me/601157558115">WhatsApp: 011-5755 8115</a></li><li><a href="tel:+601157558115">Telefon: 011-5755 8115</a></li><li><a data-tt href="https://www.tiktok.com/@fm.mobile.fix">TikTok: @fm.mobile.fix</a></li><li><a href="${P}kawasan/">Kawasan servis</a></li><li><a href="${P}tips/">Tips &amp; panduan</a></li></ul>
   </div>
  </div>
  <div class="ftr-bottom">&copy; <span class="js-year">2026</span> FM MOBILE FIX. Hak cipta terpelihara.</div>
 </div>
</footer>

<a class="fab" href="https://wa.me/601157558115" data-modal="m-wa" aria-controls="m-wa" aria-expanded="false" aria-label="WhatsApp FM MOBILE FIX">$(I 'wa')</a>

<div class="modal modal-menu" id="m-menu" role="dialog" aria-modal="true" aria-label="Menu" aria-hidden="true">
 <div class="modal-bg" data-close></div>
 <div class="modal-box">
  <div class="opt-list">
   <a class="opt" href="${P}phone-repair/"><span class="ic">$(I 'phone')</span><span><b>Repair Phone</b><small>Masalah &amp; repair smartphone</small></span><svg class="i go" aria-hidden="true"><use href="#i-arrow"/></svg></a>
   <a class="opt" href="${P}laptop-repair/"><span class="ic ic-pink">$(I 'laptop')</span><span><b>Repair Laptop</b><small>Masalah &amp; repair laptop</small></span><svg class="i go" aria-hidden="true"><use href="#i-arrow"/></svg></a>
   <a class="opt" href="${P}kawasan/"><span class="ic">$(I 'home')</span><span><b>Kawasan servis</b><small>Rimbayu, Jalan Kebun, Shah Alam</small></span><svg class="i go" aria-hidden="true"><use href="#i-arrow"/></svg></a>
   $(MenuTipsOpt $P)
   <button type="button" class="opt" data-modal="m-loc" aria-controls="m-loc"><span class="ic ic-purp">$(I 'pin')</span><span style="text-align:left"><b>Lokasi &amp; waktu operasi</b><small>Telok Panglima Garang, Selangor</small></span><svg class="i go" aria-hidden="true"><use href="#i-arrow"/></svg></button>
  </div>
  <div class="menu-foot">
   <span class="badge js-badge"><i></i><span>Semak&hellip;</span></span>
   <a class="icon-btn fb" data-fb href="https://www.facebook.com/fmmobilefix" aria-label="Facebook FM Mobile Fix" style="margin-left:auto">$(I 'fb')</a>
   <a class="icon-btn tt" data-tt href="https://www.tiktok.com/@fm.mobile.fix" aria-label="TikTok FM Mobile Fix">$(I 'tt')</a>
   <a class="btn btn-primary btn-sm" data-wa="general" href="https://wa.me/601157558115">$(I 'wa')WhatsApp</a>
  </div>
 </div>
</div>

<div class="modal modal-paper" id="m-loc" role="dialog" aria-modal="true" aria-labelledby="m-loc-t" aria-hidden="true">
 <div class="modal-bg" data-close></div>
 <div class="modal-box on-light">
  <button class="icon-btn modal-x" type="button" data-close aria-label="Tutup">$(I 'close')</button>
  <h2 class="h3d" id="m-loc-t">Lokasi &amp; Waktu</h2>
  <p class="sub">Datang ke kedai kami. Digalakkan WhatsApp dahulu.</p>
  <div class="addr-line"><span class="ic">$(I 'pin')</span><p>$ADDR</p></div>
  <table class="hours">
   <tr data-row="norm"><td>Isnin hingga Khamis &amp; Sabtu</td><td>10:00 pagi &ndash; 9:00 malam</td></tr>   <tr data-row="sun"><td>Ahad</td><td>12:00 tengah hari &ndash; 9:00 malam</td></tr>
   <tr data-row="fri"><td>Jumaat</td><td>10:00 pagi &ndash; 1:00 petang<br>3:00 petang &ndash; 9:00 malam</td></tr>
  </table>
  <div class="cta-row" style="margin-top:22px">
   <a class="btn btn-primary btn-sm" href="$MAPDIR" target="_blank" rel="noopener">$(I 'nav')Dapatkan arah</a>
   <a class="btn btn-ghost btn-sm" data-wa="dir" href="https://wa.me/601157558115">$(I 'wa')Tanya arah</a>
  </div>
 </div>
</div>

<div class="modal modal-sheet" id="m-wa" role="dialog" aria-modal="true" aria-labelledby="m-wa-t" aria-hidden="true">
 <div class="modal-bg" data-close></div>
 <div class="modal-box">
  <button class="icon-btn modal-x" type="button" data-close aria-label="Tutup">$(I 'close')</button>
  <h2 id="m-wa-t" style="font-size:1.3rem">WhatsApp kami</h2>
  <p class="sub">Pilih topik dan mesej akan disediakan untuk anda.</p>
  <div class="opt-list">
   <a class="opt" data-wa="problem" href="https://wa.me/601157558115"><span class="ic">$(I 'phone')</span><span><b>Repair phone</b><small>Skrin, bateri, charging&hellip;</small></span><svg class="i go" aria-hidden="true"><use href="#i-arrow"/></svg></a>
   <a class="opt" data-wa="laptopBook" href="https://wa.me/601157558115"><span class="ic ic-pink">$(I 'laptop')</span><span><b>Repair laptop</b><small>Kongsi model &amp; masalah</small></span><svg class="i go" aria-hidden="true"><use href="#i-arrow"/></svg></a>
   <a class="opt" data-wa="dir" href="https://wa.me/601157558115"><span class="ic ic-purp">$(I 'pin')</span><span><b>Arah ke kedai</b><small>Tanya jalan ke kedai</small></span><svg class="i go" aria-hidden="true"><use href="#i-arrow"/></svg></a>
  </div>
 </div>
</div>

$(TipsModal $P)

<script src="${P}assets/js/site.js"></script>
</body>
</html>
"@
}

function Stars { return '<span class="stars" role="img" aria-label="5 bintang">' + ((1..5 | ForEach-Object { '<svg class="i"><use href="#i-star"/></svg>' }) -join '') + '</span>' }

function ReviewCards($keys) {
  $out = ''
  foreach ($k in $keys) {
    $r = $REV[$k]
    $out += '<article class="card rev rv"><svg class="i q" aria-hidden="true"><use href="#i-quote"/></svg>' + (Stars) + '<p>' + $r[2] + '</p><div class="rev-by"><span class="av">' + $r[0] + '</span><span><b>' + $r[1] + '</b><small>' + (I 'google') + 'Review Google</small></span></div></article>'
  }
  return $out
}

function PhotoCards($P, $photos) {
  $out = ''; $i = 0
  foreach ($ph in $photos) {
    $src = $P + 'assets/img/repairs/' + $ph[0]
    $out += '<article class="fbp rv" style="--d:' + ($i * 0.08) + 's"><div class="fbp-h"><img src="' + $P + 'assets/img/logo-mark.png" alt="" width="53" height="38"><span><b>FM MOBILE FIX</b><small>Facebook &middot; Telok Panglima Garang</small></span><a class="fbi" data-fb href="https://www.facebook.com/fmmobilefix" aria-label="Buka Facebook FM Mobile Fix">' + (I 'fb') + '</a></div><p class="fbp-t">' + $ph[1] + '</p><div class="fbp-img"><img class="bg" src="' + $src + '" alt="" loading="lazy" aria-hidden="true"><img src="' + $src + '" alt="' + (Esc $ph[1]) + '" loading="lazy"><span class="fbp-tag">' + (I 'check') + 'Siap repair</span></div><div class="fbp-a" aria-hidden="true"><span>' + (I 'like') + 'Suka</span><span>' + (I 'chat') + 'Komen</span><span>' + (I 'share') + 'Kongsi</span></div></article>'
    $i++
  }
  return $out
}

function LocationSection($P) {
@"
<section class="sec" id="lokasi">
 <div class="wrap">
  <div class="sec-head rv"><span class="eyebrow">Datang ke kedai</span><h2 class="h3d">Lokasi &amp; waktu operasi</h2><p class="lead">Kedai kami di Telok Panglima Garang, dekat dengan Jalan Kebun, Rimbayu dan Shah Alam.</p></div>
  <div class="grid g2">
   <div class="card rv from-l" style="display:flex;flex-direction:column;justify-content:center">
    <span class="ic">$(I 'pin')</span><h3>FM MOBILE FIX</h3>
    <p style="color:#D9D5DE;font-size:1.02rem;margin:8px 0 20px">$ADDR</p>
    <div class="cta-row" style="margin-top:0"><a class="btn btn-primary btn-sm" href="$MAPDIR" target="_blank" rel="noopener">$(I 'nav')Dapatkan arah</a><a class="btn btn-ghost btn-sm" href="tel:+601157558115">Telefon kami</a></div>
   </div>
   <div class="card rv from-r">
    <h3 style="display:flex;align-items:center;gap:10px;margin-bottom:10px">$(I 'clock')Waktu operasi</h3>
    <table class="hours dark-hours">
     <tr data-row="norm"><td>Isnin hingga Khamis &amp; Sabtu</td><td>10:00 pagi &ndash; 9:00 malam</td></tr>     <tr data-row="sun"><td>Ahad</td><td>12:00 tengah hari &ndash; 9:00 malam</td></tr>
     <tr data-row="fri"><td>Jumaat</td><td>10:00 pagi &ndash; 1:00 petang<br>3:00 petang &ndash; 9:00 malam</td></tr>
    </table>
    <div style="margin-top:16px;border-radius:16px;overflow:hidden;border:1px solid var(--line2)"><iframe title="Lokasi FM MOBILE FIX di Google Maps" src="$MAPEMBED" loading="lazy" referrerpolicy="no-referrer-when-downgrade" allowfullscreen style="display:block;width:100%;height:240px;border:0"></iframe></div>
   </div>
  </div>
 </div>
</section>
"@
}

# ---------------------------------------------------------------------
#  Service pages
# ---------------------------------------------------------------------
foreach ($path in $PAGES.Keys) {
  $pg = $PAGES[$path]
  $P = '../../'
  $secPath = if ($pg.sec -eq 'phone') { 'phone-repair/' } else { 'laptop-repair/' }
  $secName = if ($pg.sec -eq 'phone') { 'Repair Phone' } else { 'Repair Laptop' }
  $crumbs = @(@('Utama',''), @($secName, $secPath), @($pg.crumb, $path + '/'))
  $ogImg = if ($pg.hero -like 'stock/*') { $pg.hero } elseif ($pg.hero -and $pg.hero -ne 'laptop') { 'repairs/' + $pg.hero } else { 'og-image.jpg' }
  $ld = JsonLd $P ($path + '/') $pg.title $pg.desc $crumbs ($pg.h1 -replace '&amp;', '&') $pg.faq
  $html = Head $P ($path + '/') $pg.title $pg.desc $ogImg $ld
  $html += Header $P $pg.sec

  # hero media
  if ($pg.hero -eq 'laptop') { $media = '<div class="shero-media rv zoom"><img src="' + $P + 'assets/img/laptop-hero.webp" alt="Servis repair laptop FM Mobile Fix" width="1672" height="941" fetchpriority="high"></div>' }
  elseif ($pg.hero) { $hsrc = if ($pg.hero -like 'stock/*') { 'assets/img/' + $pg.hero } else { 'assets/img/repairs/' + $pg.hero }; $media = '<div class="shero-media rv zoom"><img src="' + $P + $hsrc + '" alt="' + (Esc $pg.heroAlt) + '" fetchpriority="high"></div>' }
  else { $media = '<div class="shero-media icon rv zoom" aria-hidden="true"><span class="ic">' + (I $pg.icon) + '</span></div>' }

  $facts = ($pg.facts | ForEach-Object { '<li>' + (I 'check') + $_ + '</li>' }) -join ''
  $crumbHtml = '<nav class="crumbs" aria-label="Breadcrumb"><a href="' + $P + '">Utama</a><span class="sep">/</span><a href="' + $P + $secPath + '">' + $secName + '</a><span class="sep">/</span><span aria-current="page">' + $pg.crumb + '</span></nav>'
  $sym = ''; $n = 0
  foreach ($s in $pg.sym) { $cls = @('', ' ic-pink', ' ic-purp', '')[$n % 4]; $sym += '<article class="card rv" style="--d:' + ($n * 0.06) + 's"><span class="ic' + $cls + '">' + (I $s[0]) + '</span><h3>' + $s[1] + '</h3><p>' + $s[2] + '</p></article>'; $n++ }
  $prose = ($pg.prose | ForEach-Object { '<p>' + $_ + '</p>' }) -join ''
  $warr = ''
  if ($pg.warranty) { $warr = '<div class="warranty rv"><span class="ic">' + (I 'shield') + '</span><div><b>Waranti</b><p>' + $WARRANTY + '</p></div></div>' }
  $faqHtml = ''; $q = 1
  foreach ($f in $pg.faq) { $faqHtml += '<div class="faq-item rv"><h3><button class="faq-q" type="button" aria-expanded="false" aria-controls="fa' + $q + '" id="fq' + $q + '">' + $f[0] + '<span class="pm" aria-hidden="true">' + (I 'plus') + '</span></button></h3><div class="faq-a" id="fa' + $q + '" role="region" aria-labelledby="fq' + $q + '"><div><p>' + $f[1] + '</p></div></div></div>'; $q++ }
  $rel = ''
  foreach ($r in $pg.related) { $rel += '<a href="' + $P + $r + '/"><span class="ic">' + (I $LABEL[$r][0]) + '</span>' + $LABEL[$r][1] + '<svg class="i go" aria-hidden="true"><use href="#i-arrow"/></svg></a>' }
  $rel += '<a href="' + $P + $secPath + '"><span class="ic ic-pink">' + (I ($(if ($pg.sec -eq 'phone') { 'phone' } else { 'laptop' }))) + '</span>Semua servis ' + $secName + '<svg class="i go" aria-hidden="true"><use href="#i-arrow"/></svg></a>'

  $photosSec = ''
  if ($pg.photos.Count) {
    $photosSec = '<section class="sec"><div class="wrap"><div class="sec-head rv"><span class="eyebrow">Hasil kerja</span><h2 class="h3d">Contoh repair kami</h2></div><div class="fbp-grid">' + (PhotoCards $P $pg.photos) + '</div></div></section>'
  }

  $html += @"
<main id="main">
<section class="shero">
 <div class="wrap">
  <div class="hin">
   $crumbHtml
   <span class="eyebrow">$($pg.eyebrow)</span>
   <h1 class="h3d">$($pg.h1)</h1>
   <p class="lead">$($pg.lead)</p>
   <div class="cta-row">
    <a class="btn btn-primary btn-lg" data-wa-service="$($pg.wa)" href="https://wa.me/601157558115">$(I 'wa')WhatsApp untuk semakan</a>
    <a class="btn btn-ghost btn-lg" href="#lokasi">$(I 'pin')Lokasi kedai</a>
   </div>
   <ul class="facts">$facts</ul>
  </div>
  $media
 </div>
</section>

<section class="sec sec-2">
 <div class="wrap">
  <div class="sec-head rv"><span class="eyebrow">Masalah biasa</span><h2 class="h3d">$($pg.symTitle)</h2></div>
  <div class="grid g4">$sym</div>
  <div class="prose rv" style="margin-top:34px">$prose</div>
  $warr
 </div>
</section>

$photosSec

<section class="sec sec-light">
 <div class="wrap">
  <div class="sec-head rv"><span class="eyebrow">Review Google &middot; 5.0 (68 review)</span><h2 class="h3d">Apa kata pelanggan kami</h2></div>
  <div class="mini-revs">$(ReviewCards $pg.reviews)</div>
  <p class="rv" style="margin-top:10px"><a class="link-arrow" href="$GREVIEWS" target="_blank" rel="noopener">Lihat semua review di Google<svg class="i" aria-hidden="true"><use href="#i-arrow"/></svg></a></p>
 </div>
</section>

<section class="sec">
 <div class="wrap">
  <div class="sec-head center rv"><span class="eyebrow">Soalan lazim</span><h2 class="h3d">Soalan Lazim</h2></div>
  <div class="faq on-light">$faqHtml</div>
 </div>
</section>

<section class="sec sec-2">
 <div class="wrap">
  <div class="sec-head rv"><span class="eyebrow">Servis lain</span><h2 class="h3d">Servis berkaitan</h2></div>
  <div class="related rv">$rel</div>
 </div>
</section>

$(LocationSection $P)
</main>
"@
  $html += FooterAndModals $P
  $dir = Join-Path $ROOT ($path -replace '/', '\')
  New-Item -ItemType Directory -Force $dir | Out-Null
  [IO.File]::WriteAllText((Join-Path $dir 'index.html'), $html, $enc)
  "built  /$path/"
}

# ---------------------------------------------------------------------
#  Area page  /kawasan/
# ---------------------------------------------------------------------
$P = '../'
$path = 'kawasan/'
$title = 'Kedai Repair Phone Dekat Rimbayu &amp; Shah Alam | FM Mobile Fix'
$desc = 'Cari kedai repair phone dan laptop berdekatan? FM Mobile Fix di Telok Panglima Garang melayan pelanggan dari Kebun Baru, Rimbayu, Jalan Kebun dan Shah Alam.'
$areaFaq = @(
  @('Di mana lokasi FM Mobile Fix?','Kedai kami di ' + $ADDR + '.'),
  @('Perlu buat temujanji dulu?','Kami cadangkan anda WhatsApp dahulu supaya kami faham masalah device anda. Selepas itu, anda boleh datang ke kedai dalam waktu operasi.'),
  @('Saya dari Shah Alam, boleh hantar device?','Boleh. Hantar model dan masalah device melalui WhatsApp dahulu untuk semakan awal, kemudian bawa ke kedai kami di Telok Panglima Garang.'))
$ld = JsonLd $P $path $title $desc @(@('Utama',''), @('Kawasan servis', $path)) '' $areaFaq
$html = Head $P $path $title $desc 'og-image.jpg' $ld
$html += Header $P ''
$cards = ''; $n = 0
foreach ($a in $AREAS) {
  $dirUrl = 'https://www.google.com/maps/dir/?api=1&amp;origin=' + $a[2] + '&amp;destination=Lot+3745,+Jalan+Murai,+Kampung+Batu+9+Kebun+Baru,+42500+Telok+Panglima+Garang,+Selangor'
  $cards += '<article class="card rv" style="--d:' + ($n * 0.06) + 's"><h3>' + (I 'pin') + $a[0] + '</h3><p>' + $a[1] + '</p><a class="link-arrow" href="' + $dirUrl + '" target="_blank" rel="noopener">Arah dari ' + $a[0] + '<svg class="i" aria-hidden="true"><use href="#i-arrow"/></svg></a></article>'
  $n++
}
$svcLinks = ''
foreach ($k in $LABEL.Keys) { $svcLinks += '<a href="' + $P + $k + '/"><span class="ic">' + (I $LABEL[$k][0]) + '</span>' + $LABEL[$k][1] + '<svg class="i go" aria-hidden="true"><use href="#i-arrow"/></svg></a>' }
$faqHtml = ''; $q = 1
foreach ($f in $areaFaq) { $faqHtml += '<div class="faq-item rv"><h3><button class="faq-q" type="button" aria-expanded="false" aria-controls="fa' + $q + '" id="fq' + $q + '">' + $f[0] + '<span class="pm" aria-hidden="true">' + (I 'plus') + '</span></button></h3><div class="faq-a" id="fa' + $q + '" role="region" aria-labelledby="fq' + $q + '"><div><p>' + $f[1] + '</p></div></div></div>'; $q++ }
$html += @"
<main id="main">
<section class="shero">
 <div class="wrap">
  <div class="hin">
   <nav class="crumbs" aria-label="Breadcrumb"><a href="$P">Utama</a><span class="sep">/</span><span aria-current="page">Kawasan servis</span></nav>
   <span class="eyebrow">Kawasan servis</span>
   <h1 class="h3d">Kedai Repair Phone &amp; Laptop Berdekatan Anda</h1>
   <p class="lead">FM Mobile Fix terletak di Jalan Murai, Kampung Batu 9 Kebun Baru, Telok Panglima Garang. Pelanggan kami datang dari kawasan sekitar seperti Rimbayu, Jalan Kebun dan Shah Alam.</p>
   <div class="cta-row">
    <a class="btn btn-primary btn-lg" href="$MAPDIR" target="_blank" rel="noopener">$(I 'nav')Dapatkan arah</a>
    <a class="btn btn-ghost btn-lg" data-wa="general" href="https://wa.me/601157558115">$(I 'wa')WhatsApp kami</a>
   </div>
  </div>
  <div class="shero-media rv zoom"><iframe title="Lokasi FM MOBILE FIX di Google Maps" src="$MAPEMBED" loading="lazy" referrerpolicy="no-referrer-when-downgrade" allowfullscreen style="display:block;width:100%;height:100%;border:0"></iframe></div>
 </div>
</section>

<section class="sec sec-2">
 <div class="wrap">
  <div class="sec-head rv"><span class="eyebrow">Kawasan berdekatan</span><h2 class="h3d">Kawasan yang kami layan</h2><p class="lead">Tekan butang pada kawasan anda untuk dapatkan arah Google Maps terus ke kedai kami.</p></div>
  <div class="areas">$cards</div>
 </div>
</section>

<section class="sec">
 <div class="wrap">
  <div class="sec-head rv"><span class="eyebrow">Servis kami</span><h2 class="h3d">Servis repair phone &amp; laptop</h2></div>
  <div class="related rv">$svcLinks</div>
 </div>
</section>

<section class="sec sec-light">
 <div class="wrap">
  <div class="sec-head center rv"><span class="eyebrow">Soalan lazim</span><h2 class="h3d">Soalan Lazim</h2></div>
  <div class="faq">$faqHtml</div>
 </div>
</section>

$(LocationSection $P)
</main>
"@
$html += FooterAndModals $P
New-Item -ItemType Directory -Force (Join-Path $ROOT 'kawasan') | Out-Null
[IO.File]::WriteAllText((Join-Path $ROOT 'kawasan\index.html'), $html, $enc)
"built  /kawasan/"

# Tips & panduan articles
. (Join-Path $PSScriptRoot 'articles.ps1')

# ---------------------------------------------------------------------
#  sitemap.xml + robots.txt
# ---------------------------------------------------------------------
$urls = @('', 'phone-repair/', 'laptop-repair/', 'kawasan/', 'tips/') + ($PAGES.Keys | ForEach-Object { $_ + '/' }) + ($TIPS.Keys | ForEach-Object { 'tips/' + $_ + '/' })
$sm = '<?xml version="1.0" encoding="UTF-8"?>' + "`n" + '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' + "`n"
foreach ($u in $urls) {
  $pr = if ($u -eq '') { '1.0' } elseif ($u -in @('phone-repair/', 'laptop-repair/')) { '0.9' } else { '0.8' }
  $sm += " <url><loc>$SITE/$u</loc><lastmod>$TODAY</lastmod><priority>$pr</priority></url>`n"
}
$sm += '</urlset>' + "`n"
[IO.File]::WriteAllText((Join-Path $ROOT 'sitemap.xml'), $sm, $enc)
[IO.File]::WriteAllText((Join-Path $ROOT 'robots.txt'), "User-agent: *`nAllow: /`nDisallow: /_tools/`n`nSitemap: $SITE/sitemap.xml`n", $enc)
"built  sitemap.xml ($($urls.Count) URLs) + robots.txt"

# ---------------------------------------------------------------------
#  Main pages (home, phone, laptop): SEO head, schema, footer, links
#  Safe to run many times.
# ---------------------------------------------------------------------
$MAIN = @(
  @{ file='index.html'; P=''; path=''; sec='';
     title='Repair Phone &amp; Laptop Telok Panglima Garang | FM Mobile Fix';
     desc='Kedai repair phone dan laptop di Telok Panglima Garang, dekat Rimbayu, Jalan Kebun &amp; Shah Alam. Tukar skrin, bateri dan repair motherboard. Rating 5.0 di Google (68 review).';
     crumbs=@(,@('Utama','')); svc='' },
  @{ file='phone-repair\index.html'; P='../'; path='phone-repair/'; sec='phone';
     title='Kedai Repair Phone Telok Panglima Garang | FM Mobile Fix';
     desc='Kedai repair phone di Telok Panglima Garang: tukar skrin iPhone &amp; Android, tukar bateri, phone masuk air, charging port dan motherboard. Waranti 3 bulan untuk bateri &amp; LCD.';
     crumbs=@(@('Utama',''),@('Repair Phone','phone-repair/')); svc='Repair phone' },
  @{ file='laptop-repair\index.html'; P='../'; path='laptop-repair/'; sec='laptop';
     title='Kedai Repair Laptop Telok Panglima Garang | FM Mobile Fix';
     desc='Repair laptop di Telok Panglima Garang: tukar skrin, bateri, keyboard, motherboard, upgrade SSD &amp; RAM dan install Windows. Dekat Rimbayu, Jalan Kebun &amp; Shah Alam.';
     crumbs=@(@('Utama',''),@('Repair Laptop','laptop-repair/')); svc='Repair laptop' }
)
foreach ($m in $MAIN) {
  $fp = Join-Path $ROOT $m.file
  $h = [IO.File]::ReadAllText($fp)
  $url = $SITE + '/' + $m.path
  # FAQ (laptop page) for FAQPage schema
  $faq = @()
  foreach ($mm in [regex]::Matches($h, '<button class="faq-q"[^>]*>([^<]+)<span[\s\S]*?<div><p>([\s\S]*?)</p></div>')) { $faq += ,@($mm.Groups[1].Value, $mm.Groups[2].Value) }
  $ld = JsonLd $m.P $m.path $m.title $m.desc $m.crumbs $m.svc $faq
  $h = [regex]::Replace($h, '<title>[\s\S]*?</title>', '<title>' + $m.title + '</title>')
  $h = [regex]::Replace($h, '<meta name="description" content="[^"]*">', '<meta name="description" content="' + $m.desc + '">')
  $h = [regex]::Replace($h, '\s*<meta property="og:(title|description|type)" content="[^"]*">', '')
  $seo = '<!--seo--><link rel="canonical" href="' + $url + '"><meta name="robots" content="index, follow, max-image-preview:large"><meta name="geo.region" content="MY-10"><meta name="geo.placename" content="Telok Panglima Garang"><meta name="geo.position" content="2.9291257;101.4977695"><meta property="og:type" content="website"><meta property="og:locale" content="ms_MY"><meta property="og:site_name" content="FM MOBILE FIX"><meta property="og:title" content="' + $m.title + '"><meta property="og:description" content="' + $m.desc + '"><meta property="og:url" content="' + $url + '"><meta property="og:image" content="' + $SITE + '/assets/img/og-image.jpg"><meta name="twitter:card" content="summary_large_image"><!--/seo-->'
  if ($h -match '<!--seo-->') { $h = [regex]::Replace($h, '<!--seo-->[\s\S]*?<!--/seo-->', $seo) }
  else { $h = [regex]::Replace($h, '(<meta name="description" content="[^"]*">)', '$1' + "`n" + $seo) }
  $h = [regex]::Replace($h, '<script type="application/ld\+json">[\s\S]*?</script>', [Text.RegularExpressions.MatchEvaluator]{ param($x) $ld })
  $foot = FooterOnly $m.P
  $h = [regex]::Replace($h, '<footer class="ftr">[\s\S]*?</footer>', [Text.RegularExpressions.MatchEvaluator]{ param($x) $foot })
  # logo text + TikTok next to Facebook (header and mobile menu)
  $h = $h.Replace('<span>FM <b>MOBILE</b> FIX</span>', '<span><b>FM MOB<i>i</i>LE</b> F<i>i</i>X</span>')
  if ($h -notmatch 'class="icon-btn tt"') {
    $ttIcon = '<a class="icon-btn tt" data-tt href="https://www.tiktok.com/@fm.mobile.fix" aria-label="TikTok FM Mobile Fix">' + (I 'tt') + '</a>'
    $h = [regex]::Replace($h, '(<a class="icon-btn fb"[^>]*>(?:(?!</a>).)*</a>)', { param($x) $x.Groups[1].Value + "`n   " + $ttIcon })
  }
  # header nav, mobile-menu Tips option, Tips popup
  $nav = NavHtml $m.P $m.sec
  $h = [regex]::Replace($h, '<nav class="nav" aria-label="Utama">[\s\S]*?</nav>', [Text.RegularExpressions.MatchEvaluator]{ param($x) $nav })
  if ($h -notmatch 'class="opt" href="[^"]*tips/"') { $h = $h.Replace('<button type="button" class="opt" data-modal="m-loc"', (MenuTipsOpt $m.P) + "`n   " + '<button type="button" class="opt" data-modal="m-loc"') }
  $tm = TipsModal $m.P
  if ($h -match '<!--mtips-->') { $h = [regex]::Replace($h, '<!--mtips-->[\s\S]*?<!--/mtips-->', [Text.RegularExpressions.MatchEvaluator]{ param($x) $tm }) }
  else { $fe = $h.IndexOf('</footer>'); $si = $h.IndexOf('<script src=', $fe); $h = $h.Substring(0, $si) + $tm + "`n`n" + $h.Substring($si) }
  [IO.File]::WriteAllText($fp, $h, $enc)
  "updated $($m.file)  (faq in schema: $($faq.Count))"
}
