/* =========================================================
   FM MOBILE FIX: shared site script
   ========================================================= */

/* ---------------------------------------------------------
   1) WHATSAPP SETTINGS: change the number here only.
      Format: country code + number, no "+", spaces or dashes.
   --------------------------------------------------------- */
window.FM = {
  whatsapp: '601157558115',
  messages: {
    // Phone Repair page (Malay)
    main:    'Hai FM MOBILE FIX, saya nak tanya tentang servis repair phone.',
    problem: 'Hai FM MOBILE FIX, phone saya ada masalah. Boleh semak?\n\nModel phone: \nMasalah: ',
    tech:    'Hai FM MOBILE FIX, saya nak berbincang dengan technician tentang masalah phone saya.',
    dir:     'Hai FM MOBILE FIX, boleh tolong bagi arah ke kedai?',

    // Laptop Repair page
    laptop:      'Hai FM MOBILE FIX, saya nak tanya tentang servis repair laptop.',
    laptopBook:  'Hai FM MOBILE FIX, saya nak tempah repair laptop.\n\nJenama & model laptop: \nMasalah: ',
    laptopCta:   'Hai FM MOBILE FIX, saya ingin bertanya tentang servis repair laptop.',

    // General
    general: 'Hai FM MOBILE FIX, saya nak tanya tentang servis repair phone / laptop.'
  },
  // Social pages: change here only
  facebook: 'https://www.facebook.com/fmmobilefix',
  instagram: 'https://www.instagram.com/fm_gadget89/',
  tiktok: 'https://www.tiktok.com/@fm.mobile.fix',

  /* 2) GOOGLE ANALYTICS 4 + GOOGLE ADS conversion tracking.
        Leave empty until you have the IDs. Once filled in, every click on
        WhatsApp / call / directions / Facebook / Instagram is sent as an event,
        and WhatsApp clicks are also reported as a Google Ads conversion.
        ga4:  'G-XXXXXXXXXX'
        ads:  'AW-XXXXXXXXXX'
        adsWhatsappLabel: 'xxxxxxxxxxxxxxxxx'  (from Google Ads > Conversions) */
  analytics: { ga4: '', ads: '', adsWhatsappLabel: '' },
  // Used by data-wa-service="..." buttons (e.g. each laptop service card)
  serviceMessage: function (service, lang) {
    return lang === 'ms'
      ? 'Hai FM MOBILE FIX, saya nak tanya tentang servis ' + service + '.'
      : 'Hi FM Mobile Fix, I would like to enquire about ' + service + '.';
  },
  link: function (text) {
    return 'https://wa.me/' + this.whatsapp + '?text=' + encodeURIComponent(text);
  }
};

(function () {
  'use strict';
  var doc = document.documentElement;
  doc.classList.add('js');
  var LANG = (doc.lang || 'en').slice(0, 2);
  var RM = matchMedia('(prefers-reduced-motion: reduce)').matches;

  /* ---------- Icon sprite ---------- */
  var ICONS = {
    phone:'<rect x="7" y="2" width="10" height="20" rx="2.5"/><path d="M11 18.5h2"/>',
    laptop:'<rect x="4" y="4.5" width="16" height="10.5" rx="1.5"/><path d="M2 18.5h20"/><path d="M10 15v1.5h4V15"/>',
    screen:'<rect x="3" y="4" width="18" height="12" rx="1.5"/><path d="M8 20h8M12 16v4"/><path d="m13.5 4-2.5 4 3 2-2.5 4"/>',
    battery:'<rect x="2" y="7" width="17" height="10" rx="2"/><path d="M22 11v2M6 10v4M9.5 10v4"/>',
    plug:'<path d="M9 2v5M15 2v5"/><path d="M6 7h12v4a6 6 0 0 1-12 0z"/><path d="M12 17v5"/>',
    water:'<path d="M12 2.5s6.5 6.6 6.5 11.3a6.5 6.5 0 0 1-13 0C5.5 9.1 12 2.5 12 2.5z"/><path d="M9 14.5a3 3 0 0 0 3 3"/>',
    chip:'<rect x="6" y="6" width="12" height="12" rx="1.5"/><rect x="9.5" y="9.5" width="5" height="5" rx=".5"/><path d="M9 2v4M15 2v4M9 18v4M15 18v4M2 9h4M2 15h4M18 9h4M18 15h4"/>',
    mic:'<rect x="9" y="2" width="6" height="12" rx="3"/><path d="M5 11a7 7 0 0 0 14 0M12 18v4"/>',
    search:'<circle cx="11" cy="11" r="7"/><path d="m20 20-4-4"/>',
    user:'<circle cx="12" cy="8" r="4"/><path d="M4 21a8 8 0 0 1 16 0"/>',
    receipt:'<path d="M6 2h12v20l-3-2-3 2-3-2-3 2z"/><path d="M9 7h6M9 11h6M9 15h4"/>',
    shield:'<path d="M12 2 4 5v6c0 5 3.4 9.3 8 11 4.6-1.7 8-6 8-11V5z"/><path d="m9 12 2 2 4-4"/>',
    keyboard:'<rect x="2" y="6" width="20" height="12" rx="2"/><path d="M6 10h.01M10 10h.01M14 10h.01M18 10h.01M7 14h10"/>',
    fan:'<circle cx="12" cy="12" r="2"/><path d="M12 10c0-4 1-7 4-7s3 4 0 6M14 12c4 0 7 1 7 4s-4 3-6 0M12 14c0 4-1 7-4 7s-3-4 0-6M10 12c-4 0-7-1-7-4s4-3 6 0"/>',
    ssd:'<rect x="3" y="5" width="18" height="14" rx="2"/><path d="M7 9h6M7 13h10M7 16h4M17 9h.01"/>',
    software:'<rect x="3" y="4" width="18" height="15" rx="2"/><path d="M3 8h18"/><path d="m7 12 2.5 2L7 16M12 16h5"/>',
    chat:'<path d="M21 12a8.5 8.5 0 0 1-12.3 7.6L3 21l1.5-5.2A8.5 8.5 0 1 1 21 12z"/><path d="M8.5 12h.01M12 12h.01M15.5 12h.01"/>',
    wrench:'<path d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.8-3.8a6 6 0 0 1-7.9 7.9l-6.9 6.9a2.1 2.1 0 0 1-3-3l6.9-6.9a6 6 0 0 1 7.9-7.9z"/>',
    check:'<path d="m5 12.5 4.5 4.5L19 7.5"/>',
    pin:'<path d="M12 22s7-6.2 7-12a7 7 0 0 0-14 0c0 5.8 7 12 7 12z"/><circle cx="12" cy="10" r="2.5"/>',
    clock:'<circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 2"/>',
    arrow:'<path d="M5 12h14M13 6l6 6-6 6"/>',
    down:'<path d="m6 9 6 6 6-6"/>',
    menu:'<path d="M4 7h16M4 12h16M4 17h16"/>',
    close:'<path d="M6 6l12 12M18 6 6 18"/>',
    plus:'<path d="M12 5v14M5 12h14"/>',
    smile:'<circle cx="12" cy="12" r="9"/><path d="M8.5 14a4 4 0 0 0 7 0M9 9.5h.01M15 9.5h.01"/>',
    spark:'<path d="M12 3l2.2 5.6 5.8.9-4.4 3.8L17 19l-5-3-5 3 1.4-5.7L4 9.5l5.8-.9z"/>',
    scan:'<path d="M4 8V5a1 1 0 0 1 1-1h3M16 4h3a1 1 0 0 1 1 1v3M20 16v3a1 1 0 0 1-1 1h-3M8 20H5a1 1 0 0 1-1-1v-3M4 12h16"/>',
    pulse:'<path d="M3 12h4l2-5 4 10 2-5h6"/>',
    nav:'<path d="M3 11 21 3l-8 18-2-8z"/>',
    tt:'<path class="i-fill" d="M12.525.02c1.31-.02 2.61-.01 3.91-.02.08 1.53.63 3.09 1.75 4.17 1.12 1.11 2.7 1.62 4.24 1.79v4.03c-1.44-.05-2.89-.35-4.2-.97-.57-.26-1.1-.59-1.62-.93-.01 2.92.01 5.84-.02 8.75-.08 1.4-.54 2.79-1.35 3.94-1.31 1.92-3.58 3.17-5.91 3.21-1.43.08-2.86-.31-4.08-1.03-2.02-1.19-3.44-3.37-3.65-5.71-.02-.5-.03-1-.01-1.49.18-1.9 1.12-3.72 2.58-4.96 1.66-1.44 3.98-2.13 6.15-1.72.02 1.48-.04 2.96-.04 4.44-.99-.32-2.15-.23-3.02.37-.63.41-1.11 1.04-1.36 1.75-.21.51-.15 1.07-.14 1.61.24 1.64 1.82 3.02 3.5 2.87 1.12-.01 2.19-.66 2.77-1.61.19-.33.4-.67.41-1.06.1-1.79.06-3.57.07-5.36.01-4.03-.01-8.05.02-12.07z"/>',
    ig:'<rect x="3" y="3" width="18" height="18" rx="5"/><circle cx="12" cy="12" r="4"/><path d="M17.5 6.5h.01"/>',
    home:'<path d="M3 11 12 3l9 8"/><path d="M5 9.5V21h14V9.5"/>',
    trackpad:'<rect x="4" y="5" width="16" height="14" rx="2.5"/><path d="M4 14.5h16M12 14.5V19"/>',
    fb:'<path class="i-fill" d="M13.6 21.9v-8.1h2.7l.4-3.2h-3.1V8.6c0-.9.3-1.5 1.6-1.5h1.7V4.3c-.3 0-1.3-.1-2.5-.1-2.4 0-4.1 1.5-4.1 4.2v2.3H7.6v3.2h2.7v8.1z"/>',
    star:'<path class="i-fill" d="M12 2.8l2.8 5.8 6.3.8-4.6 4.4 1.2 6.2L12 17l-5.7 3 1.2-6.2L2.9 9.4l6.3-.8z"/>',
    quote:'<path class="i-fill" d="M4 18v-5.5C4 8.6 6 6 9.6 5l.7 1.6C8.3 7.4 7.3 9 7.2 11H10v7zm9.5 0v-5.5c0-3.9 2-6.5 5.6-7.5l.7 1.6c-2 .8-3 2.4-3.1 4.4h2.8v7z"/>',
    google:'<path stroke="none" d="M21.6 12.2c0-.7-.1-1.4-.2-2H12v3.9h5.4a4.6 4.6 0 0 1-2 3v2.5h3.2c1.9-1.7 3-4.3 3-7.4z" fill="#4285F4"/><path stroke="none" d="M12 22c2.7 0 5-.9 6.6-2.4l-3.2-2.5c-.9.6-2 1-3.4 1-2.6 0-4.8-1.8-5.6-4.1H3.1v2.6A10 10 0 0 0 12 22z" fill="#34A853"/><path stroke="none" d="M6.4 14a6 6 0 0 1 0-3.9V7.5H3.1a10 10 0 0 0 0 9z" fill="#FBBC05"/><path stroke="none" d="M12 6c1.5 0 2.8.5 3.8 1.5l2.9-2.9A10 10 0 0 0 3.1 7.5l3.3 2.6C7.2 7.8 9.4 6 12 6z" fill="#EA4335"/>',
    like:'<path d="M7 11v10H4V11zM7 11l4-8c1.7 0 2.5 1 2.2 2.6L12.6 9H19a2 2 0 0 1 2 2.3l-1.2 7.4A2.6 2.6 0 0 1 17.2 21H7"/>',
    share:'<path d="M14 4l7 7-7 7v-4c-5 0-8 1.5-10 5 .5-5.5 3-10 10-11z"/>',
    wa:'<path class="i-fill" d="M12.04 2a9.9 9.9 0 0 0-8.5 14.9L2 22l5.25-1.38A9.93 9.93 0 1 0 12.04 2zm5.8 14.12c-.25.7-1.45 1.34-2 1.4-.52.06-1.17.09-1.9-.12a17 17 0 0 1-1.72-.64c-3.03-1.31-5-4.37-5.16-4.57-.15-.2-1.24-1.65-1.24-3.15s.78-2.23 1.06-2.53c.27-.3.6-.38.8-.38h.57c.18 0 .43-.07.67.51.25.6.85 2.1.93 2.25.07.15.12.33.02.52-.1.2-.15.32-.3.5l-.45.52c-.15.15-.3.31-.13.6.17.3.77 1.27 1.65 2.05 1.13 1 2.09 1.31 2.39 1.46.3.15.47.12.65-.07.17-.2.75-.87.95-1.17.2-.3.4-.25.67-.15.27.1 1.73.82 2.03.97.3.15.5.22.57.35.07.12.07.72-.18 1.42z"/>'
  };
  var sprite = '<svg xmlns="http://www.w3.org/2000/svg" style="display:none" aria-hidden="true">';
  Object.keys(ICONS).forEach(function (k) { sprite += '<symbol id="i-' + k + '" viewBox="0 0 24 24">' + ICONS[k] + '</symbol>'; });
  document.body.insertAdjacentHTML('afterbegin', sprite + '</svg>');

  /* ---------- Opening local folder (file://) ? make folder links work ---------- */
  if (location.protocol === 'file:') {
    document.querySelectorAll('a[href]').forEach(function (a) {
      var h = a.getAttribute('href');
      if (h && h.charAt(0) !== '#' && /^(\.{1,2}\/)*([a-z0-9-]+\/)*(#.*)?$/i.test(h)) {
        a.setAttribute('href', h.replace(/\/(#.*)?$/, '/index.html$1'));
      }
    });
  }

  /* ---------- WhatsApp links ---------- */
  document.querySelectorAll('[data-wa]').forEach(function (a) {
    var key = a.dataset.wa;
    var msg = FM.messages[key] || FM.messages.general;
    a.href = FM.link(msg);
    a.target = '_blank';
    a.rel = 'noopener';
  });
  document.querySelectorAll('[data-fb]').forEach(function (a) {
    a.href = FM.facebook;
    a.target = '_blank';
    a.rel = 'noopener';
  });
  document.querySelectorAll('[data-tt]').forEach(function (a) {
    a.href = FM.tiktok;
    a.target = '_blank';
    a.rel = 'noopener';
  });
  document.querySelectorAll('[data-ig]').forEach(function (a) {
    a.href = FM.instagram;
    a.target = '_blank';
    a.rel = 'noopener';
  });

  /* ---------- Analytics / Google Ads conversions ---------- */
  var AN = FM.analytics || {};
  if (AN.ga4 || AN.ads) {
    var gs = document.createElement('script');
    gs.async = true;
    gs.src = 'https://www.googletagmanager.com/gtag/js?id=' + (AN.ga4 || AN.ads);
    document.head.appendChild(gs);
    window.dataLayer = window.dataLayer || [];
    window.gtag = function () { dataLayer.push(arguments); };
    gtag('js', new Date());
    if (AN.ga4) gtag('config', AN.ga4);
    if (AN.ads) gtag('config', AN.ads);
  }
  function track(name, label) {
    if (!window.gtag) return;
    gtag('event', name, { link_text: label, page_path: location.pathname });
    if (name === 'whatsapp_click' && AN.ads && AN.adsWhatsappLabel) {
      gtag('event', 'conversion', { send_to: AN.ads + '/' + AN.adsWhatsappLabel });
    }
  }
  document.addEventListener('click', function (e) {
    var a = e.target.closest && e.target.closest('a[href]');
    if (!a) return;
    var h = a.href, t = (a.textContent || a.getAttribute('aria-label') || '').trim().slice(0, 60);
    if (h.indexOf('wa.me/') > -1) track('whatsapp_click', t);
    else if (h.indexOf('tel:') === 0) track('call_click', t);
    else if (/google\.[a-z.]+\/maps/.test(h)) track('directions_click', t);
    else if (h.indexOf('facebook.com') > -1) track('facebook_click', t);
    else if (h.indexOf('instagram.com') > -1) track('instagram_click', t);
    else if (h.indexOf('tiktok.com') > -1) track('tiktok_click', t);
  }, true);
  document.querySelectorAll('[data-wa-service]').forEach(function (a) {
    a.href = FM.link(FM.serviceMessage(a.dataset.waService, LANG));
    a.target = '_blank';
    a.rel = 'noopener';
  });

  /* ---------- 3D headline: copy text into data-text for the extrusion layer ---------- */
  document.querySelectorAll('.h3d').forEach(function (h) { h.setAttribute('data-text', h.textContent.trim()); });
  // titles use Barlow Condensed: once it has loaded, repaint each title so no layer keeps the old font
  if (document.fonts && document.fonts.load) {
    document.fonts.load('italic 800 1em "Barlow Condensed"').then(function () {
      document.querySelectorAll('h1.h3d').forEach(function (h) {
        var t = h.getAttribute('data-text'); h.removeAttribute('data-text'); void h.offsetWidth; h.setAttribute('data-text', t);
        h.style.display = 'none'; void h.offsetWidth; h.style.display = '';
      });
    }).catch(function () {});
  }

  /* ---------- Header shadow on scroll ---------- */
  var hdr = document.querySelector('.hdr');
  function onScrollHdr() { if (hdr) hdr.classList.toggle('scrolled', scrollY > 8); }
  onScrollHdr();
  addEventListener('scroll', onScrollHdr, { passive: true });

  /* ---------- Modals (popups, menu, WhatsApp panel) ---------- */
  var openModal = null, lastFocus = null;
  var FOCUSABLE = 'a[href],button:not([disabled]),input,select,textarea,iframe,[tabindex]:not([tabindex="-1"])';
  function showModal(id, trigger) {
    var m = document.getElementById(id);
    if (!m) return;
    if (openModal) hideModal(true);
    lastFocus = trigger || document.activeElement;
    m.classList.add('open');
    m.setAttribute('aria-hidden', 'false');
    document.querySelectorAll('[aria-controls="' + id + '"]').forEach(function (b) { b.setAttribute('aria-expanded', 'true'); });
    openModal = m;
    document.body.style.overflow = 'hidden';
    setTimeout(function () {
      var f = m.querySelector('[data-autofocus]') || m.querySelector(FOCUSABLE);
      if (f) f.focus({ preventScroll: true });
    }, 60);
  }
  function hideModal(silent) {
    if (!openModal) return;
    var m = openModal;
    m.classList.remove('open');
    m.setAttribute('aria-hidden', 'true');
    document.querySelectorAll('[aria-controls="' + m.id + '"]').forEach(function (b) { b.setAttribute('aria-expanded', 'false'); });
    openModal = null;
    document.body.style.overflow = '';
    if (!silent && lastFocus && lastFocus.focus) lastFocus.focus({ preventScroll: true });
  }
  window.FM.openModal = showModal;
  window.FM.closeModal = hideModal;

  document.addEventListener('click', function (e) {
    var t = e.target.closest('[data-modal]');
    if (t) {
      e.preventDefault();
      var id = t.dataset.modal;
      if (openModal && openModal.id === id) hideModal(); else showModal(id, t);
      return;
    }
    if (e.target.closest('[data-close]')) { hideModal(); return; }
    // following a link inside a modal closes it (e.g. in-page anchors in the menu)
    var link = e.target.closest('.modal a[href]');
    if (link && openModal) hideModal(true);
  });
  document.addEventListener('keydown', function (e) {
    if (!openModal) return;
    if (e.key === 'Escape') { hideModal(); return; }
    if (e.key === 'Tab') {
      var f = Array.prototype.filter.call(openModal.querySelectorAll(FOCUSABLE), function (el) { return el.offsetParent !== null; });
      if (!f.length) return;
      var first = f[0], last = f[f.length - 1];
      if (e.shiftKey && document.activeElement === first) { e.preventDefault(); last.focus(); }
      else if (!e.shiftKey && document.activeElement === last) { e.preventDefault(); first.focus(); }
    }
  });
  addEventListener('resize', function () {
    if (openModal && openModal.classList.contains('modal-menu') && innerWidth > 1180) hideModal(true);
  });

  /* ---------- FAQ accordion ---------- */
  document.querySelectorAll('.faq-q').forEach(function (q) {
    q.addEventListener('click', function () {
      var item = q.closest('.faq-item');
      var open = !item.classList.contains('open');
      item.classList.toggle('open', open);
      q.setAttribute('aria-expanded', open ? 'true' : 'false');
    });
  });

  /* ---------- Opening hours badge (Malaysia time) ---------- */
  var T = LANG === 'ms'
    ? { openUntil: 'Kedai buka · tutup ', closedReopen: 'Kedai tutup · buka semula ', closedTomorrow: 'Kedai tutup · buka esok ', am: 'pagi', pm: 'petang', eve: 'malam' }
    : { openUntil: 'Open now · closes ', closedReopen: 'Closed · opens ', closedTomorrow: 'Closed · opens tomorrow ', am: 'am', pm: 'pm', eve: 'pm' };
  function klNow() {
    var p = new Intl.DateTimeFormat('en-GB', { timeZone: 'Asia/Kuala_Lumpur', weekday: 'short', hour: '2-digit', minute: '2-digit', hour12: false }).formatToParts(new Date()), o = {};
    p.forEach(function (x) { o[x.type] = x.value; });
    return { fri: o.weekday === 'Fri', sun: o.weekday === 'Sun', sat: o.weekday === 'Sat', m: (+o.hour % 24) * 60 + +o.minute };
  }
  function fmt(m) {
    var h = Math.floor(m / 60);
    var ap = LANG === 'ms' ? (h >= 18 ? T.eve : h >= 13 ? T.pm : h === 12 ? 'tengah hari' : T.am) : (h >= 12 ? T.pm : T.am);
    h = h % 12 || 12;
    return h + ':00 ' + ap;
  }
  function updateHours() {
    var t = klNow(), s = t.fri ? [[600, 780], [900, 1260]] : t.sun ? [[720, 1260]] : [[600, 1260]], open = false, msg = '';
    for (var i = 0; i < s.length; i++) if (t.m >= s[i][0] && t.m < s[i][1]) { open = true; msg = T.openUntil + fmt(s[i][1]); }
    if (!open) {
      var nx = null;
      for (var j = 0; j < s.length; j++) if (t.m < s[j][0]) { nx = s[j][0]; break; }
      msg = nx !== null ? T.closedReopen + fmt(nx) : T.closedTomorrow + fmt(t.sat ? 720 : 600);
    }
    document.querySelectorAll('.js-badge').forEach(function (b) {
      b.classList.toggle('open', open);
      var sp = b.querySelector('span'); if (sp) sp.textContent = msg;
      b.setAttribute('data-short', open ? (LANG === 'ms' ? 'Kedai Buka' : 'Open') : (LANG === 'ms' ? 'Kedai Tutup' : 'Closed'));
      b.setAttribute('title', msg);
    });
    document.querySelectorAll('[data-row]').forEach(function (r) {
      r.classList.toggle('today', r.dataset.row === (t.fri ? 'fri' : t.sun ? 'sun' : 'norm'));
    });
  }
  updateHours();
  setInterval(updateHours, 60000);
  // header status chip opens the Location & hours popup
  document.querySelectorAll('.hdr .js-badge').forEach(function (b) {
    if (!document.getElementById('m-loc')) return;
    b.setAttribute('role', 'button');
    b.setAttribute('tabindex', '0');
    b.setAttribute('aria-label', 'Waktu operasi dan lokasi');
    b.addEventListener('click', function () { showModal('m-loc', b); });
    b.addEventListener('keydown', function (e) { if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); showModal('m-loc', b); } });
  });

  /* ---------- Card spotlight (follows the pointer) ---------- */
  if (matchMedia('(hover:hover)').matches) {
    document.addEventListener('pointermove', function (e) {
      var c = e.target.closest && e.target.closest('.card');
      if (!c) return;
      var r = c.getBoundingClientRect();
      c.style.setProperty('--mx', (e.clientX - r.left) + 'px');
      c.style.setProperty('--my', (e.clientY - r.top) + 'px');
    }, { passive: true });
  }

  /* ---------- Reveal on scroll ---------- */
  var rvEls = document.querySelectorAll('.rv');
  if ('IntersectionObserver' in window && !RM) {
    var io = new IntersectionObserver(function (es) {
      es.forEach(function (e) {
        if (!e.isIntersecting) return;
        var el = e.target;
        el.classList.add('in');
        io.unobserve(el);
        setTimeout(function () { el.classList.add('done'); }, 1400);
      });
    }, { threshold: 0.12, rootMargin: '0px 0px -40px 0px' });
    rvEls.forEach(function (el) { io.observe(el); });
  } else {
    rvEls.forEach(function (el) { el.classList.add('in', 'done'); });
  }

  /* ---------- Timelines: progress line fills as you scroll ---------- */
  var tls = document.querySelectorAll('.tl');
  var parallax = document.querySelectorAll('[data-parallax]');
  var ticking = false;
  function frame() {
    ticking = false;
    var vh = innerHeight;
    tls.forEach(function (tl) {
      var r = tl.getBoundingClientRect();
      var p = RM ? 1 : Math.min(1, Math.max(0, (vh * 0.72 - r.top) / (r.height * 0.85)));
      tl.style.setProperty('--p', p.toFixed(3));
      var steps = tl.querySelectorAll('.tl-step');
      steps.forEach(function (s, i) {
        var at = steps.length > 1 ? i / (steps.length - 1) : 0;
        s.classList.toggle('on', p >= at - 0.02);
      });
      // vertical layouts: line runs from the first number to the LAST number only
      var dots = tl.querySelectorAll('.tl-dot');
      if (dots.length > 1) {
        var c = [], top = r.top;
        dots.forEach(function (d) { var b = d.getBoundingClientRect(); c.push(b.top + b.height / 2 - top); });
        var len = c[c.length - 1] - c[0];
        if (len > 4) {
          var pos = p * (c.length - 1), k = Math.min(c.length - 2, Math.floor(pos)), fr = pos - k;
          tl.style.setProperty('--y0', c[0].toFixed(1) + 'px');
          tl.style.setProperty('--len', len.toFixed(1) + 'px');
          tl.style.setProperty('--fy', (c[k] + (c[k + 1] - c[k]) * fr - c[0]).toFixed(1) + 'px');
          tl.classList.add('tl-measured');
        } else tl.classList.remove('tl-measured');
      }
    });
    if (!RM) parallax.forEach(function (el) {
      var host = el.closest('section') || el.parentElement;
      var r = host.getBoundingClientRect();
      if (r.bottom < 0 || r.top > vh) return;
      var k = parseFloat(el.dataset.parallax) || 0.15;
      el.style.setProperty('--py', (-(r.top) * k).toFixed(1) + 'px');
    });
  }
  function req() { if (!ticking) { ticking = true; requestAnimationFrame(frame); } }
  if (tls.length || parallax.length) {
    frame();
    addEventListener('scroll', req, { passive: true });
    addEventListener('resize', req);
  }

  /* ---------- Brand logos: crop each SVG to its real shape ---------- */
  document.querySelectorAll('.blogo svg').forEach(function (svg) {
    try {
      var b = svg.getBBox();
      if (b.width && b.height) svg.setAttribute('viewBox', [b.x, b.y, b.width, b.height].map(function (n) { return +n.toFixed(2); }).join(' '));
    } catch (err) { /* keep default viewBox */ }
  });

  /* ---------- Phone layout: carousels, compact grids, bottom bar ---------- */
  var SMALL = matchMedia('(max-width: 760px)');
  // 1) No swipe carousels any more: everything stacks vertically.
  //    Card grids get the "stack" class → compact one-column cards on phones (see CSS).
  var cars = [];
  document.querySelectorAll('.grid').forEach(function (g) {
    if (g.classList.contains('g3') || g.classList.contains('g4')) g.classList.add('stack');
  });
  cars.forEach(function (el) {
    var items = Array.prototype.filter.call(el.children, function (c) { return !c.classList.contains('tl-track') && !c.classList.contains('tl-fill'); });
    if (items.length < 2) return;
    el.classList.add('x-car');
    if (el.classList.contains('info')) el.classList.add('narrow');
    var dots = document.createElement('div');
    dots.className = 'x-dots';
    dots.setAttribute('aria-hidden', 'true');
    for (var k = 0; k < items.length; k++) dots.appendChild(document.createElement('i'));
    var hint = document.createElement('span'); hint.textContent = LANG === 'ms' ? 'Geser untuk lagi' : 'Swipe for more';
    dots.appendChild(hint);
    el.parentNode.insertBefore(dots, el.nextSibling);
    function mark() {
      var first = items[0]; if (!first) return;
      var step = first.getBoundingClientRect().width + 14;
      var idx = Math.round(el.scrollLeft / step);
      var ds = dots.querySelectorAll('i');
      for (var j = 0; j < ds.length; j++) ds[j].classList.toggle('on', j === idx);
      if (el.scrollLeft > 20) hint.style.display = 'none';
    }
    el.addEventListener('scroll', mark, { passive: true });
    mark();
  });

  // 2) sticky bottom bar on phones: Phone / Laptop / WhatsApp
  var logo = document.querySelector('.hdr .logo');
  if (logo) {
    var home = logo.getAttribute('href') || './';
    var pre = home === './' ? '' : home;
    var waBtn = document.querySelector('.hdr a[href*="wa.me"]');
    var path = location.pathname;
    var bar = document.createElement('nav');
    bar.className = 'mbar';
    bar.setAttribute('aria-label', 'Pilihan pantas');
    bar.innerHTML =
      '<a href="' + pre + 'phone-repair/"' + (/\/phone-repair\//.test(path) ? ' class="on" aria-current="page"' : '') + '><svg class="i" aria-hidden="true"><use href="#i-phone"/></svg>Repair Phone</a>' +
      '<a href="' + pre + 'laptop-repair/"' + (/\/laptop-repair\//.test(path) ? ' class="on" aria-current="page"' : '') + '><svg class="i" aria-hidden="true"><use href="#i-laptop"/></svg>Repair Laptop</a>' +
      '<a class="wa" href="' + (waBtn ? waBtn.href : FM.link(FM.messages.general)) + '" target="_blank" rel="noopener"><svg class="i" aria-hidden="true"><use href="#i-wa"/></svg>WhatsApp</a>';
    document.body.appendChild(bar);
    if (location.protocol === 'file:') {
      bar.querySelectorAll('a[href$="/"]').forEach(function (a) { a.setAttribute('href', a.getAttribute('href') + 'index.html'); });
    }
  }

  /* ---------- Year in footer ---------- */
  document.querySelectorAll('.js-year').forEach(function (y) { y.textContent = new Date().getFullYear(); });
})();
