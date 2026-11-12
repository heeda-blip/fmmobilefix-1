# FM MOBILE FIX - article page builder (data is in tips-data.ps1)
# ---------------------------------------------------------------------
#  Build article pages
# ---------------------------------------------------------------------
function TipCard($P, $slug, $t) {
  return '<a class="card tip-card rv" href="' + $P + 'tips/' + $slug + '/"><span class="thumb"><img src="' + $P + 'assets/img/' + $t.img + '" alt="' + (Esc $t.imgAlt) + '" loading="lazy"></span><span class="body"><span class="cat">' + $t.cat + '</span><h3>' + $t.title + '</h3><p>' + $t.desc + '</p><span class="link-arrow">Baca tips<svg class="i" aria-hidden="true"><use href="#i-arrow"/></svg></span></span></a>'
}

$tipKeys = @($TIPS.Keys)
foreach ($slug in $tipKeys) {
  $t = $TIPS[$slug]
  $P = '../../'
  $path = 'tips/' + $slug + '/'
  $words = ([regex]::Replace($t.body, '<[^>]+>', ' ') -split '\s+' | Where-Object { $_ }).Count
  $mins = [math]::Max(2, [math]::Round($words / 200))
  $art = '{"@type":"BlogPosting","headline":"' + (JsonStr $t.title) + '","description":"' + (JsonStr $t.desc) + '","image":"' + $SITE + '/assets/img/' + $t.img + '","datePublished":"' + $PUBDATE + '","dateModified":"' + $PUBDATE + '","inLanguage":"ms-MY","author":{"@id":"' + $SITE + '/#business"},"publisher":{"@id":"' + $SITE + '/#business"},"mainEntityOfPage":"' + $SITE + '/' + $path + '"}'
  $ld = JsonLd $P $path $t.title $t.desc @(@('Utama',''), @('Tips', 'tips/'), @($t.title, $path)) '' $null $art
  $html = Head $P $path $t.title $t.desc $t.img $ld
  $html += Header $P ''
  $body = $t.body.Replace('{P}', $P)
  $others = ''; $n = 0
  foreach ($o in $tipKeys) { if ($o -ne $slug -and $n -lt 3) { $others += TipCard $P $o $TIPS[$o]; $n++ } }
  $html += @"
<main id="main">
<section class="shero" style="padding-bottom:20px">
 <div class="wrap" style="display:block">
  <div class="post-head hin">
   <nav class="crumbs" aria-label="Breadcrumb"><a href="$P">Utama</a><span class="sep">/</span><a href="${P}tips/">Tips</a><span class="sep">/</span><span aria-current="page">$($t.cat)</span></nav>
   <span class="eyebrow">Tips &amp; panduan &middot; $($t.cat)</span>
   <h1 class="h3d">$($t.title)</h1>
   <div class="post-meta"><span>$(I 'user')FM Mobile Fix</span><span>$(I 'clock')$mins minit bacaan</span><span>$PUBTEXT</span></div>
  </div>
  <div class="post-cover rv zoom"><img src="${P}assets/img/$($t.img)" alt="$(Esc $t.imgAlt)" fetchpriority="high"></div>
 </div>
</section>

<section class="sec" style="padding-top:30px">
 <div class="wrap">
  <article class="post">
$body
  </article>
  <div class="post-cta rv">
   <h2 class="h3d" style="margin:0 auto 8px">Ada masalah ni? Kami boleh tolong.</h2>
   <p>WhatsApp model device dan masalahnya. Kami semak dulu dan terangkan penyelesaian sebelum repair.</p>
   <div class="cta-row">
    <a class="btn btn-primary" data-wa-service="$($t.wa)" href="https://wa.me/601157558115">$(I 'wa')WhatsApp kami</a>
    <a class="btn btn-ghost" href="${P}$($t.svc)/">$($t.svcLabel)$(I 'arrow')</a>
   </div>
  </div>
 </div>
</section>

<section class="sec sec-2">
 <div class="wrap">
  <div class="sec-head rv"><span class="eyebrow">Baca lagi</span><h2 class="h3d">Tips lain</h2></div>
  <div class="tips-grid">$others</div>
 </div>
</section>

$(LocationSection $P)
</main>
"@
  $html += FooterAndModals $P
  $dir = Join-Path $ROOT ('tips\' + $slug)
  New-Item -ItemType Directory -Force $dir | Out-Null
  [IO.File]::WriteAllText((Join-Path $dir 'index.html'), $html, $enc)
  "built  /$path  ($words patah perkataan)"
}

# ---- Tips index /tips/
$P = '../'
$path = 'tips/'
$title = 'Tips Repair Phone &amp; Laptop | FM Mobile Fix'
$desc = 'Tips dan panduan mudah tentang masalah phone dan laptop: phone masuk air, bateri cepat habis, skrin bergaris, laptop lembab dan banyak lagi.'
$coll = '{"@type":"CollectionPage","name":"Tips Repair Phone & Laptop","url":"' + $SITE + '/tips/"}'
$ld = JsonLd $P $path $title $desc @(@('Utama',''), @('Tips', $path)) '' $null $coll
$html = Head $P $path $title $desc 'og-image.jpg' $ld
$html += Header $P ''
$cards = ''
foreach ($slug in $tipKeys) { $cards += TipCard $P $slug $TIPS[$slug] }
$html += @"
<main id="main">
<section class="shero" style="padding-bottom:30px">
 <div class="wrap" style="display:block">
  <div class="post-head hin">
   <nav class="crumbs" aria-label="Breadcrumb"><a href="$P">Utama</a><span class="sep">/</span><span aria-current="page">Tips</span></nav>
   <span class="eyebrow">Tips &amp; panduan</span>
   <h1 class="h3d">Tips Repair Phone &amp; Laptop</h1>
   <p class="lead">Panduan ringkas dari team FM Mobile Fix untuk masalah phone dan laptop yang selalu jadi. Baca dulu, kalau masih tak settle, WhatsApp je kami.</p>
  </div>
 </div>
</section>
<section class="sec" style="padding-top:20px">
 <div class="wrap"><div class="tips-grid">$cards</div></div>
</section>
$(LocationSection $P)
</main>
"@
$html += FooterAndModals $P
New-Item -ItemType Directory -Force (Join-Path $ROOT 'tips') | Out-Null
[IO.File]::WriteAllText((Join-Path $ROOT 'tips\index.html'), $html, $enc)
"built  /tips/"

# ---- Home page: "Tips terkini" block (between markers)
$homeFile = Join-Path $ROOT 'index.html'
$hh = [IO.File]::ReadAllText($homeFile)
$latest = ''; $n = 0
foreach ($slug in $tipKeys) { if ($n -lt 3) { $latest += TipCard '' $slug $TIPS[$slug]; $n++ } }
$block = '<!--tips--><section class="sec sec-light"><div class="wrap"><div class="sec-head center rv"><span class="eyebrow">Tips &amp; panduan</span><h2 class="h3d">Tips terkini</h2><p class="lead">Panduan ringkas untuk masalah phone dan laptop yang selalu jadi.</p></div><div class="tips-grid">' + $latest + '</div><p class="rv" style="text-align:center;margin-top:26px"><a class="btn btn-ghost" href="tips/">Lihat semua tips' + (I 'arrow') + '</a></p></div></section><!--/tips-->'
if ($hh -match '<!--tips-->') { $hh = [regex]::Replace($hh, '<!--tips-->[\s\S]*?<!--/tips-->', [Text.RegularExpressions.MatchEvaluator]{ param($x) $block }) }
else { $hh = $hh.Replace(' <!-- HASIL KERJA', $block + "`n`n" + ' <!-- HASIL KERJA') }
[IO.File]::WriteAllText($homeFile, $hh, $enc)
"updated index.html (tips block)"
