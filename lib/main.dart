<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
<title>فيديوز</title>

<style>
*{box-sizing:border-box;margin:0;padding:0;font-family:Arial,Tahoma,sans-serif}
html,body{width:100%;height:100%;background:#000;color:#fff;overflow:hidden}
button,input,textarea{font-family:inherit}
button{border:0;cursor:pointer}
.hidden{display:none!important}

#app{width:100%;height:100%;background:#000}

/* Splash */
#splash{position:fixed;inset:0;z-index:99999;background:#000;display:flex;flex-direction:column;align-items:center;justify-content:center;transition:opacity .5s}
.logo{width:95px;height:95px;border-radius:28px;background:linear-gradient(135deg,#ff0050,#00f2ea);display:flex;align-items:center;justify-content:center;font-size:48px;font-weight:bold}
#splash h1{margin-top:18px;font-size:38px}
#splash p{color:#888;margin-top:7px}
.loader{width:150px;height:4px;background:#222;border-radius:20px;margin-top:25px;overflow:hidden}
.loader span{display:block;width:0;height:100%;background:linear-gradient(90deg,#ff0050,#00f2ea);animation:loading 2s forwards}
@keyframes loading{to{width:100%}}

/* Pages */
.page{display:none;width:100%;height:calc(100% - 65px);overflow:hidden}
.page.active{display:block}

/* Feed */
.feed{width:100%;height:100%;overflow-y:auto;scroll-snap-type:y mandatory}
.video{width:100%;height:100%;min-height:100%;position:relative;overflow:hidden;scroll-snap-align:start;background:#111}
.video:nth-child(1){background:radial-gradient(circle,#ff0050,#150007,#000)}
.video:nth-child(2){background:radial-gradient(circle,#00d9df,#001719,#000)}
.video:nth-child(3){background:radial-gradient(circle,#743cff,#10001c,#000)}
.fakeVideo{position:absolute;inset:0;display:flex;align-items:center;justify-content:center;font-size:100px}
.video::after{content:"";position:absolute;inset:0;background:linear-gradient(transparent 35%,transparent 55%,rgba(0,0,0,.9));pointer-events:none}
.videoTop{position:absolute;top:15px;left:0;right:0;z-index:5;text-align:center}
.videoTop span{margin:0 15px;color:#aaa;cursor:pointer}
.videoTop .active{color:#fff;font-weight:bold;border-bottom:2px solid #fff;padding-bottom:7px}
.videoInfo{position:absolute;right:18px;bottom:25px;z-index:6;max-width:75%}
.videoInfo h3{margin-bottom:8px}
.videoInfo p{color:#ddd}
.actions{position:absolute;left:12px;bottom:40px;z-index:7;display:flex;flex-direction:column;gap:14px}
.action{background:none;color:#fff;text-align:center}
.actionIcon{width:48px;height:48px;border-radius:50%;background:#0008;display:flex;align-items:center;justify-content:center;font-size:22px;transition:transform .2s}
.action:active .actionIcon{transform:scale(.9)}
.action small{display:block;margin-top:3px}
.liked{color:#ff0050!important}
.saved{color:#ffd700!important}

/* Bottom Nav */
.bottomNav{position:fixed;left:0;right:0;bottom:0;height:65px;z-index:100;background:#080808;border-top:1px solid #222;display:flex;justify-content:space-around;align-items:center}
.bottomNav button{background:none;color:#888;font-size:11px;padding:5px 10px}
.bottomNav button span{display:block;font-size:23px;margin-bottom:2px}
.bottomNav button.active{color:#fff}
.cameraPlus{width:50px!important;height:36px;border-radius:10px!important;background:#fff!important;color:#000!important;font-size:27px!important;font-weight:bold}

/* Create Screen */
#createScreen{position:fixed;inset:0;z-index:1000;background:#000;display:none;overflow:hidden}
#createScreen.active{display:block}
#cameraVideo{position:absolute;inset:0;width:100%;height:100%;object-fit:cover;background:#111}
.cameraOverlay{position:absolute;inset:0;z-index:3;pointer-events:none}
.cameraOverlay button{pointer-events:auto}
.cameraTop{position:absolute;top:15px;left:15px;right:15px;display:flex;align-items:center;justify-content:space-between;pointer-events:auto;z-index:20}
.cameraClose,.flipCamera{width:43px;height:43px;border-radius:50%;background:#0009;color:#fff;font-size:23px;backdrop-filter:blur(10px)}
.cameraTitle{font-weight:bold;font-size:18px}
.soundButton{position:absolute;top:70px;left:50%;transform:translateX(-50%);z-index:40;min-width:150px;height:42px;padding:0 18px;border-radius:24px;border:1px solid #ffffff35;background:#000a;color:#fff;display:flex;align-items:center;justify-content:center;gap:7px;font-size:14px;font-weight:bold;backdrop-filter:blur(10px)}
.sideTools{position:absolute;right:12px;top:115px;display:flex;flex-direction:column;gap:12px;z-index:10}
.sideTool{width:50px;min-height:50px;border-radius:25px;background:#0009;color:#fff;display:flex;flex-direction:column;align-items:center;justify-content:center;font-size:20px;backdrop-filter:blur(10px)}
.sideTool small{font-size:9px;margin-top:2px}
.sideTool.selected{background:#fff;color:#000}

/* Filters */
.filtersPanel{position:absolute;right:70px;top:110px;width:230px;background:#080808dd;border-radius:18px;padding:12px;z-index:30;backdrop-filter:blur(10px);display:none}
.filtersPanel.active{display:block}
.filtersPanel h3{font-size:14px;margin-bottom:10px}
.filters{display:flex;gap:8px;overflow-x:auto;padding-bottom:5px}
.filter{min-width:50px;height:50px;border-radius:12px;border:2px solid transparent;cursor:pointer;transition:transform .2s}
.filter:active{transform:scale(.9)}
.filter.active{border-color:#fff;transform:scale(1.05)}
.filterNormal{background:linear-gradient(135deg,#222,#777)}
.filterWarm{background:linear-gradient(135deg,#ff5c35,#ffd36a)}
.filterCool{background:linear-gradient(135deg,#00e5ff,#1c3cff)}
.filterPink{background:linear-gradient(135deg,#ff0080,#7d00ff)}
.filterBW{background:linear-gradient(135deg,#000,#fff)}
.filterGreen{background:linear-gradient(135deg,#00ff88,#004422)}

/* Modes */
.createModes{position:absolute;bottom:170px;left:0;right:0;z-index:15;display:flex;justify-content:center;align-items:center;gap:15px;overflow-x:auto;padding:0 15px}
.createMode{color:#aaa;background:none;font-size:13px;white-space:nowrap;padding:5px 10px}
.createMode.active{color:#fff;font-weight:bold}
.durationBar{position:absolute;bottom:130px;left:0;right:0;z-index:15;display:flex;justify-content:center;gap:8px}
.duration{padding:8px 13px;border-radius:20px;background:#0009;color:#aaa;font-size:12px}
.duration.active{background:#fff;color:#000;font-weight:bold}

/* Gallery */
.galleryButton{position:absolute;left:20px;bottom:85px;z-index:20;width:55px;height:55px;border-radius:14px;background:#000a;color:#fff;font-size:25px;backdrop-filter:blur(10px)}
#galleryInput{display:none}

/* Record */
.recordArea{position:absolute;bottom:68px;left:0;right:0;z-index:20;display:flex;justify-content:center;align-items:center}
.recordButton{width:78px;height:78px;border-radius:50%;background:#fff;border:7px solid #bbb;box-shadow:0 0 0 4px #fff5;transition:all .2s}
.recordButton.recording{background:#ff0050;transform:scale(.9)}
.recordButton.recording::after{content:"";display:block;width:25px;height:25px;background:#fff;border-radius:5px;margin:auto}
.recordTimer{position:absolute;top:120px;left:50%;transform:translateX(-50%);z-index:50;background:#ff0050;padding:5px 12px;border-radius:20px;font-size:12px;display:none}

/* Permission */
#cameraPermission{position:absolute;inset:0;z-index:999;display:none;align-items:center;justify-content:center;background:#000;padding:25px;text-align:center}
#cameraPermission.active{display:flex}
.permissionBox{width:100%;max-width:370px;background:#181818;border-radius:25px;padding:28px 22px}
.permissionIcon{font-size:60px;margin-bottom:15px}
.permissionBox p{color:#aaa;line-height:1.8;margin:12px 0 20px}
.permissionButton{width:100%;height:52px;border-radius:14px;background:#ff0050;color:#fff;font-size:17px;font-weight:bold}
.permissionCancel{width:100%;height:45px;margin-top:8px;border-radius:14px;background:#292929;color:#fff}

/* Text Editor */
.textCreator{position:absolute;inset:0;z-index:100;background:#000;display:none;flex-direction:column}
.textCreator.active{display:flex}
.textTop{padding:15px;display:flex;justify-content:space-between;align-items:center}
.textInput{flex:1;height:60%;margin:20px;background:transparent;border:0;outline:0;color:#fff;font-size:32px;text-align:center;resize:none}
.textDone{background:#fff;color:#000;padding:10px 20px;border-radius:20px}

/* Preview */
.previewScreen{position:absolute;inset:0;z-index:200;background:#000;display:none;flex-direction:column}
.previewScreen.active{display:flex}
.previewHeader{height:60px;display:flex;align-items:center;justify-content:space-between;padding:10px 15px}
.previewMedia{flex:1;display:flex;align-items:center;justify-content:center;overflow:hidden}
.previewMedia video,.previewMedia img{max-width:100%;max-height:100%;object-fit:contain}
.previewBottom{padding:15px;display:flex;gap:10px}
.publishButton{flex:1;height:50px;border-radius:12px;background:#ff0050;color:#fff;font-weight:bold}
.backButton{width:100px;height:50px;border-radius:12px;background:#222;color:#fff}

/* Sound Panel */
.soundPanel{position:absolute;inset:0;z-index:150;background:#080808;display:none;flex-direction:column}
.soundPanel.active{display:flex}
.soundHeader{height:65px;display:flex;align-items:center;justify-content:space-between;padding:10px 15px;border-bottom:1px solid #222}
.soundClose{width:40px;height:40px;border-radius:50%;background:#222;color:#fff;font-size:20px}
.soundSearch{margin:12px;padding:13px;border-radius:13px;background:#191919;border:1px solid #333;color:#fff;outline:none}
.soundList{flex:1;overflow-y:auto;padding:0 12px 30px}
.soundCategory{margin:15px 5px 8px;color:#aaa;font-size:12px}
.soundItem{width:100%;min-height:65px;background:#171717;color:#fff;border-radius:14px;margin-bottom:8px;display:flex;align-items:center;gap:12px;padding:10px 13px;text-align:right}
.soundIcon{width:43px;height:43px;border-radius:12px;background:linear-gradient(135deg,#ff0050,#7b00ff);display:flex;align-items:center;justify-content:center;font-size:21px;flex-shrink:0}
.soundItem b{display:block}
.soundItem small{color:#888;display:block;margin-top:3px}

/* Simple Pages */
.simplePage{padding:25px 20px;overflow:auto;height:100%}
.searchInput{width:100%;padding:14px;border-radius:13px;background:#191919;border:1px solid #333;color:#fff;outline:none}
.card{background:#171717;border-radius:15px;padding:18px;margin-top:15px}

/* Profile */
.profile{text-align:center;padding:25px 18px 100px;overflow:auto;height:100%}
.avatar{width:105px;height:105px;border-radius:50%;margin:20px auto 12px;background:linear-gradient(135deg,#ff0050,#00f2ea);display:flex;align-items:center;justify-content:center;overflow:hidden;font-size:40px;border:2px solid #fff}
.avatar img{width:100%;height:100%;object-fit:cover}
.profile h2{margin-top:8px}
.username{color:#888;margin-top:5px}
.bio{color:#ddd;margin:12px auto;max-width:350px}
.stats{display:flex;justify-content:center;gap:35px;margin:25px 0}
.stats b{display:block;font-size:20px}
.stats span{color:#888;font-size:11px}
.editButton{background:#222;color:#fff;border-radius:10px;padding:12px 40px}
.socials{display:flex;flex-wrap:wrap;justify-content:center;gap:8px;margin-top:20px}
.social{background:#191919;color:#fff;text-decoration:none;padding:9px 13px;border-radius:20px;font-size:12px}

/* Modal */
.modal{position:fixed;inset:0;z-index:3000;background:#000c;display:none;align-items:flex-end}
.modal.active{display:flex}
.loginBox{width:100%;max-width:500px;max-height:92%;overflow:auto;background:#151515;border-radius:27px 27px 0 0;padding:25px 20px 35px;margin:0 auto}
.close{float:left;width:35px;height:35px;border-radius:50%;background:#292929;color:#fff;font-size:20px}
.loginLogo{width:65px;height:65px;border-radius:19px;background:linear-gradient(135deg,#ff0050,#00f2ea);display:flex;align-items:center;justify-content:center;margin:10px auto 15px;font-size:32px;font-weight:bold}
.loginBox h2{text-align:center}
.subtitle{text-align:center;color:#888;font-size:13px;margin:8px 0 20px}
.loginButton{width:100%;height:52px;border-radius:11px;margin-bottom:10px;font-weight:bold}
.phoneLogin{background:#ff0050;color:#fff}
.googleLogin{background:#fff;color:#222}
.facebookLogin{background:#1877f2;color:#fff}
.input{width:100%;padding:14px;background:#222;border:1px solid #333;color:#fff;border-radius:10px;outline:none;margin-bottom:12px}
.continue{width:100%;height:50px;border-radius:10px;background:#ff0050;color:#fff;font-weight:bold}
.back{width:100%;height:45px;background:none;color:#888}

/* Edit Box */
.editBox{width:100%;max-width:500px;max-height:94%;overflow:auto;background:#151515;border-radius:25px 25px 0 0;padding:25px 20px 35px;margin:0 auto}
.editBox h2{text-align:center;margin-bottom:20px}
.editAvatar{width:95px;height:95px;border-radius:50%;margin:0 auto 10px;background:#222;display:flex;align-items:center;justify-content:center;overflow:hidden;font-size:35px}
.editAvatar img{width:100%;height:100%;object-fit:cover}
.changePhoto{display:block;margin:0 auto 20px;background:none;color:#00e5ff}
.saveButton{width:100%;height:50px;background:#ff0050;color:#fff;border-radius:10px;font-weight:bold}

/* Toast */
.toast{position:fixed;z-index:10000;left:50%;bottom:85px;transform:translateX(-50%);background:#fff;color:#000;padding:12px 20px;border-radius:25px;white-space:nowrap;opacity:0;transition:opacity .3s}
.toast.show{opacity:1}
</style>
</head>

<body>

<!-- Splash -->
<div id="splash">
  <div class="logo">ف</div>
  <h1>فيديوز</h1>
  <p>شاهد • شارك • استمتع</p>
  <div class="loader"><span></span></div>
</div>

<div id="app">

<!-- Home -->
<section class="page active" id="home">
  <div class="feed">
    <div class="video">
      <div class="fakeVideo">🎬</div>
      <div class="videoTop">
        <span onclick="switchFeed(this)">المتابَعون</span>
        <span class="active" onclick="switchFeed(this)">لك</span>
      </div>
      <div class="videoInfo">
        <h3>@videoz</h3>
        <p>أهلاً بكم في فيديوز ❤️</p>
      </div>
      <div class="actions">
        <button class="action" onclick="like(this)">
          <div class="actionIcon">♥</div>
          <small>1.2K</small>
        </button>
        <button class="action" onclick="comment()">
          <div class="actionIcon">💬</div>
          <small>235</small>
        </button>
        <button class="action" onclick="saveVideo(this)">
          <div class="actionIcon">🔖</div>
          <small>80</small>
        </button>
        <button class="action" onclick="shareVideo()">
          <div class="actionIcon">↗</div>
          <small>مشاركة</small>
        </button>
      </div>
    </div>

    <div class="video">
      <div class="fakeVideo">🔥</div>
      <div class="videoInfo">
        <h3>@creator</h3>
        <p>فيديو جديد 🔥 #ترند</p>
      </div>
      <div class="actions">
        <button class="action" onclick="like(this)">
          <div class="actionIcon">♥</div>
          <small>5.8K</small>
        </button>
        <button class="action" onclick="comment()">
          <div class="actionIcon">💬</div>
          <small>400</small>
        </button>
        <button class="action" onclick="saveVideo(this)">
          <div class="actionIcon">🔖</div>
          <small>90</small>
        </button>
        <button class="action" onclick="shareVideo()">
          <div class="actionIcon">↗</div>
          <small>مشاركة</small>
        </button>
      </div>
    </div>

    <div class="video">
      <div class="fakeVideo">😎</div>
      <div class="videoInfo">
        <h3>@user</h3>
        <p>شوفوا الفيديو الجديد 😍</p>
      </div>
      <div class="actions">
        <button class="action" onclick="like(this)">
          <div class="actionIcon">♥</div>
          <small>2.1K</small>
        </button>
        <button class="action" onclick="comment()">
          <div class="actionIcon">💬</div>
          <small>210</small>
        </button>
        <button class="action" onclick="saveVideo(this)">
          <div class="actionIcon">🔖</div>
          <small>42</small>
        </button>
        <button class="action" onclick="shareVideo()">
          <div class="actionIcon">↗</div>
          <small>مشاركة</small>
        </button>
      </div>
    </div>
  </div>
</section>

<!-- Search -->
<section class="page" id="searchPage">
  <div class="simplePage">
    <h2>اكتشاف</h2>
    <br>
    <input class="searchInput" placeholder="ابحث عن حساب أو هاشتاج" oninput="searchItems(this.value)">
    <div id="searchResults">
      <div class="card">🔥 #ترند</div>
      <div class="card">🎵 #موسيقى</div>
      <div class="card">😂 #مضحك</div>
    </div>
  </div>
</section>

<!-- Messages -->
<section class="page" id="messagesPage">
  <div class="simplePage">
    <h2>الوارد</h2>
    <div class="card">👋 مرحباً بك في فيديوز</div>
  </div>
</section>

<!-- Profile -->
<section class="page" id="profilePage">
  <div class="profile">
    <h2>الحساب</h2>
    <div class="avatar" id="profileAvatar">👤</div>
    <h2 id="profileName">زائر</h2>
    <div class="username" id="profileUsername">لم تسجل الدخول</div>
    <div class="bio" id="profileBio"></div>
    <div class="stats">
      <div><b>0</b><span>متابعون</span></div>
      <div><b>0</b><span>متابَعون</span></div>
      <div><b>0</b><span>إعجابات</span></div>
    </div>
    <button class="editButton" id="profileButton" onclick="profileAction()">تسجيل الدخول</button>
    <div class="socials" id="socials"></div>
  </div>
</section>

<!-- Bottom Nav -->
<nav class="bottomNav">
  <button class="active" onclick="openPage('home',this)"><span>⌂</span>الرئيسية</button>
  <button onclick="openPage('searchPage',this)"><span>🔍</span>اكتشاف</button>
  <button class="cameraPlus" onclick="openCreate()">+</button>
  <button onclick="openPage('messagesPage',this)"><span>✉</span>الوارد</button>
  <button onclick="openPage('profilePage',this)"><span>👤</span>حسابي</button>
</nav>

</div>

<!-- Create Screen -->
<div id="createScreen">
  <video id="cameraVideo" autoplay playsinline muted></video>

  <div class="cameraOverlay">
    <div class="cameraTop">
      <button class="cameraClose" onclick="closeCreate()">✕</button>
      <div class="cameraTitle">إنشاء</div>
      <button class="flipCamera" onclick="flipCamera()">🔄</button>
    </div>

    <button class="soundButton" onclick="openSoundPanel()">
      🎵 <span id="selectedSound">إضافة صوت</span>
    </button>

    <div class="sideTools">
      <button class="sideTool" onclick="toggleFilters()">
        ✨<small>فلاتر</small>
      </button>
      <button class="sideTool" onclick="openTextCreator()">
        Aa<small>نص</small>
      </button>
    </div>

    <div class="filtersPanel" id="filtersPanel">
      <h3>الفلاتر</h3>
      <div class="filters">
        <div class="filter filterNormal active" onclick="applyFilter('normal',this)"></div>
        <div class="filter filterWarm" onclick="applyFilter('warm',this)"></div>
        <div class="filter filterCool" onclick="applyFilter('cool',this)"></div>
        <div class="filter filterPink" onclick="applyFilter('pink',this)"></div>
        <div class="filter filterBW" onclick="applyFilter('bw',this)"></div>
        <div class="filter filterGreen" onclick="applyFilter('green',this)"></div>
      </div>
    </div>

    <div class="createModes">
      <button class="createMode active" onclick="setMode(this)">60 ثانية</button>
      <button class="createMode" onclick="setMode(this)">3 دقائق</button>
      <button class="createMode" onclick="setMode(this)">10 دقائق</button>
      <button class="createMode" onclick="setMode(this)">قالب</button>
    </div>

    <div class="durationBar">
      <button class="duration active" onclick="setDuration(this)">15ث</button>
      <button class="duration" onclick="setDuration(this)">30ث</button>
      <button class="duration" onclick="setDuration(this)">60ث</button>
    </div>

    <button class="galleryButton" onclick="openGallery()">🖼</button>
    <input type="file" id="galleryInput" accept="video/*,image/*" onchange="loadGallery(event)">

    <div class="recordArea">
      <button class="recordButton" id="recordButton" onclick="toggleRecord()"></button>
    </div>

    <div class="recordTimer" id="recordTimer">00:00</div>
  </div>

  <!-- Permission -->
  <div id="cameraPermission">
    <div class="permissionBox">
      <div class="permissionIcon">📷</div>
      <h2>الوصول للكاميرا</h2>
      <p>للسماح بتصوير الفيديوهات، نحتاج الوصول إلى الكاميرا والميكروفون.</p>
      <button class="permissionButton" onclick="requestCamera()">السماح</button>
      <button class="permissionCancel" onclick="closeCreate()">إلغاء</button>
    </div>
  </div>

  <!-- Text Creator -->
  <div class="textCreator" id="textCreator">
    <div class="textTop">
      <button class="cameraClose" onclick="closeTextCreator()">✕</button>
      <button class="textDone" onclick="closeTextCreator()">تم</button>
    </div>
    <textarea class="textInput" placeholder="اكتب نصاً..."></textarea>
  </div>

  <!-- Preview -->
  <div class="previewScreen" id="previewScreen">
    <div class="previewHeader">
      <button class="cameraClose" onclick="closePreview()">✕</button>
      <div>معاينة</div>
      <div style="width:43px"></div>
    </div>
    <div class="previewMedia" id="previewMedia"></div>
    <div class="previewBottom">
      <button class="backButton" onclick="closePreview()">رجوع</button>
      <button class="publishButton" onclick="publishVideo()">نشر</button>
    </div>
  </div>

  <!-- Sound Panel -->
  <div class="soundPanel" id="soundPanel">
    <div class="soundHeader">
      <button class="soundClose" onclick="closeSoundPanel()">✕</button>
      <h3>اختر صوتاً</h3>
      <div style="width:40px"></div>
    </div>
    <input class="soundSearch" placeholder="ابحث عن صوت..." oninput="searchSounds(this.value)">
    <div class="soundList" id="soundList">
      <div class="soundCategory">مقترحة</div>
      <button class="soundItem" onclick="selectSound('صوت 1')">
        <div class="soundIcon">🎵</div>
        <div><b>صوت 1</b><small>فيروسي</small></div>
      </button>
      <button class="soundItem" onclick="selectSound('صوت 2')">
        <div class="soundIcon">🎶</div>
        <div><b>صوت 2</b><small>موسيقى</small></div>
      </button>
      <button class="soundItem" onclick="selectSound('صوت 3')">
        <div class="soundIcon">🎤</div>
        <div><b>صوت 3</b><small>تسجيل</small></div>
      </button>
    </div>
  </div>
</div>

<!-- Login Modal -->
<div class="modal" id="loginModal">
  <div class="loginBox">
    <button class="close" onclick="closeLogin()">✕</button>
    <div class="loginLogo">ف</div>
    <h2>تسجيل الدخول إلى فيديوز</h2>
    <p class="subtitle">اختر طريقة تسجيل الدخول</p>
    <button class="loginButton phoneLogin" onclick="fakeLogin('مستخدم الهاتف')">📱 الهاتف</button>
    <button class="loginButton googleLogin" onclick="fakeLogin('مستخدم Google')">Google</button>
    <button class="loginButton facebookLogin" onclick="fakeLogin('مستخدم Facebook')">Facebook</button>
    <button class="back" onclick="closeLogin()">لاحقاً</button>
  </div>
</div>

<!-- Edit Profile Modal -->
<div class="modal" id="editModal">
  <div class="editBox">
    <h2>تعديل الحساب</h2>
    <div class="editAvatar" id="editAvatar">👤</div>
    <button class="changePhoto" onclick="changePhoto()">تغيير الصورة</button>
    <input class="input" id="editName" placeholder="الاسم">
    <input class="input" id="editUsername" placeholder="اسم المستخدم">
    <textarea class="input" id="editBio" placeholder="نبذة" rows="3"></textarea>
    <button class="saveButton" onclick="saveProfile()">حفظ</button>
    <button class="back" onclick="closeEdit()">رجوع</button>
  </div>
</div>

<!-- Toast -->
<div class="toast" id="toast"></div>

<script>
/* ============ Splash ============ */
window.addEventListener('load', () => {
  setTimeout(() => {
    const splash = document.getElementById('splash');
    splash.style.opacity = '0';
    setTimeout(() => splash.style.display = 'none', 500);
  }, 2000);
});

/* ============ State ============ */
let currentStream = null;
let mediaRecorder = null;
let recordedChunks = [];
let recordingStartTime = 0;
let recordingTimer = null;
let facingMode = 'user';
let currentFilter = 'normal';
let selectedSoundName = '';

/* ============ Nav ============ */
function openPage(id, btn) {
  document.querySelectorAll('.page').forEach(p => p.classList.remove('active'));
  document.getElementById(id).classList.add('active');
  document.querySelectorAll('.bottomNav button').forEach(b => b.classList.remove('active'));
  if (btn) btn.classList.add('active');
}

/* ============ Home ============ */
function switchFeed(el) {
  document.querySelectorAll('.videoTop span').forEach(s => s.classList.remove('active'));
  el.classList.add('active');
  showToast('تم التبديل');
}

function like(btn) {
  btn.classList.toggle('liked');
  const icon = btn.querySelector('.actionIcon');
  icon.textContent = btn.classList.contains('liked') ? '❤' : '♥';
}

function comment() { showToast('💬 التعليقات قريباً'); }

function saveVideo(btn) {
  btn.classList.toggle('saved');
  showToast(btn.classList.contains('saved') ? 'تم الحفظ 🔖' : 'تم الإزالة');
}

function shareVideo() {
  if (navigator.share) {
    navigator.share({ title: 'فيديوز', text: 'شاهد هذا الفيديو!' }).catch(()=>{});
  } else {
    showToast('↗ تم نسخ الرابط');
  }
}

/* ============ Search ============ */
function searchItems(q) {
  const results = document.getElementById('searchResults');
  const items = ['#ترند', '#موسيقى', '#مضحك', '#رياضة', '#طبخ', '#سفر'];
  results.innerHTML = items
    .filter(i => i.includes(q))
    .map(i => `<div class="card">${i}</div>`)
    .join('');
}

/* ============ Create ============ */
async function openCreate() {
  document.getElementById('createScreen').classList.add('active');
  document.getElementById('cameraPermission').classList.add('active');
}

function closeCreate() {
  document.getElementById('createScreen').classList.remove('active');
  document.getElementById('cameraPermission').classList.remove('active');
  document.getElementById('previewScreen').classList.remove('active');
  document.getElementById('soundPanel').classList.remove('active');
  document.getElementById('textCreator').classList.remove('active');
  document.getElementById('filtersPanel').classList.remove('active');
  stopCamera();
}

async function requestCamera() {
  try {
    currentStream = await navigator.mediaDevices.getUserMedia({
      video: { facingMode: facingMode },
      audio: true
    });
    const video = document.getElementById('cameraVideo');
    video.srcObject = currentStream;
    document.getElementById('cameraPermission').classList.remove('active');
    applyFilterToVideo();
  } catch (err) {
    showToast('تعذر الوصول للكاميرا: ' + err.message);
  }
}

function stopCamera() {
  if (currentStream) {
    currentStream.getTracks().forEach(t => t.stop());
    currentStream = null;
  }
}

async function flipCamera() {
  facingMode = facingMode === 'user' ? 'environment' : 'user';
  stopCamera();
  await requestCamera();
}

/* ============ Filters ============ */
function toggleFilters() {
  document.getElementById('filtersPanel').classList.toggle('active');
}

function applyFilter(name, el) {
  currentFilter = name;
  document.querySelectorAll('.filter').forEach(f => f.classList.remove('active'));
  if (el) el.classList.add('active');
  applyFilterToVideo();
}

function applyFilterToVideo() {
  const video = document.getElementById('cameraVideo');
  const filters = {
    normal: 'none',
    warm: 'sepia(0.5) saturate(1.4) hue-rotate(-15deg)',
    cool: 'saturate(1.3) hue-rotate(180deg)',
    pink: 'saturate(1.5) hue-rotate(280deg)',
    bw: 'grayscale(1) contrast(1.2)',
    green: 'hue-rotate(90deg) saturate(1.3)'
  };
  video.style.filter = filters[currentFilter] || 'none';
}

/* ============ Text Creator ============ */
function openTextCreator() {
  document.getElementById('textCreator').classList.add('active');
}
function closeTextCreator() {
  document.getElementById('textCreator').classList.remove('active');
}

/* ============ Modes & Duration ============ */
function setMode(el) {
  document.querySelectorAll('.createMode').forEach(m => m.classList.remove('active'));
  el.classList.add('active');
}
function setDuration(el) {
  document.querySelectorAll('.duration').forEach(d => d.classList.remove('active'));
  el.classList.add('active');
}

/* ============ Gallery ============ */
function openGallery() {
  document.getElementById('galleryInput').click();
}

function loadGallery(e) {
  const file = e.target.files[0];
  if (!file) return;
  const url = URL.createObjectURL(file);
  const media = document.getElementById('previewMedia');
  if (file.type.startsWith('video')) {
    media.innerHTML = `<video src="${url}" controls autoplay loop></video>`;
  } else {
    media.innerHTML = `<img src="${url}" alt="preview">`;
  }
  document.getElementById('previewScreen').classList.add('active');
}

function closePreview() {
  document.getElementById('previewScreen').classList.remove('active');
  document.getElementById('previewMedia').innerHTML = '';
}

function publishVideo() {
  showToast('✅ تم النشر بنجاح');
  closePreview();
  closeCreate();
}

/* ============ Record ============ */
function toggleRecord() {
  const btn = document.getElementById('recordButton');
  if (!btn.classList.contains('recording')) {
    startRecording();
  } else {
    stopRecording();
  }
}

function startRecording() {
  if (!currentStream) {
    showToast('الرجاء السماح بالوصول للكاميرا أولاً');
    return;
  }
  recordedChunks = [];
  try {
    mediaRecorder = new MediaRecorder(currentStream, { mimeType: 'video/webm' });
  } catch (e) {
    showToast('التسجيل غير مدعوم في هذا المتصفح');
    return;
  }
  mediaRecorder.ondataavailable = e => {
    if (e.data.size > 0) recordedChunks.push(e.data);
  };
  mediaRecorder.onstop = () => {
    const blob = new Blob(recordedChunks, { type: 'video/webm' });
    const url = URL.createObjectURL(blob);
    const media = document.getElementById('previewMedia');
    media.innerHTML = `<video src="${url}" controls autoplay loop style="filter:${document.getElementById('cameraVideo').style.filter}"></video>`;
    document.getElementById('previewScreen').classList.add('active');
  };
  mediaRecorder.start();
  document.getElementById('recordButton').classList.add('recording');
  recordingStartTime = Date.now();
  document.getElementById('recordTimer').style.display = 'block';
  recordingTimer = setInterval(() => {
    const s = Math.floor((Date.now() - recordingStartTime) / 1000);
    const m = String(Math.floor(s / 60)).padStart(2, '0');
    const sec = String(s % 60).padStart(2, '0');
    document.getElementById('recordTimer').textContent = `${m}:${sec}`;
  }, 200);
}

function stopRecording() {
  if (mediaRecorder && mediaRecorder.state !== 'inactive') {
    mediaRecorder.stop();
  }
  document.getElementById('recordButton').classList.remove('recording');
  document.getElementById('recordTimer').style.display = 'none';
  clearInterval(recordingTimer);
}

/* ============ Sound ============ */
function openSoundPanel() {
  document.getElementById('soundPanel').classList.add('active');
}
function closeSoundPanel() {
  document.getElementById('soundPanel').classList.remove('active');
}
function selectSound(name) {
  selectedSoundName = name;
  document.getElementById('selectedSound').textContent = name;
  closeSoundPanel();
}
function searchSounds(q) {
  document.querySelectorAll('#soundList .soundItem').forEach(item => {
    item.style.display = item.textContent.includes(q) ? 'flex' : 'none';
  });
}

/* ============ Profile ============ */
let user = null;

function profileAction() {
  if (user) {
    openEdit();
  } else {
    openLogin();
  }
}

function openLogin() { document.getElementById('loginModal').classList.add('active'); }
function closeLogin() { document.getElementById('loginModal').classList.remove('active'); }

function fakeLogin(name) {
  user = { name: name, username: '@' + name.replace(/\s/g, '_'), bio: 'مستخدم جديد في فيديوز' };
  updateProfileUI();
  closeLogin();
  showToast('✅ تم تسجيل الدخول');
}

function updateProfileUI() {
  const btn = document.getElementById('profileButton');
  if (user) {
    document.getElementById('profileName').textContent = user.name;
    document.getElementById('profileUsername').textContent = user.username;
    document.getElementById('profileBio').textContent = user.bio;
    btn.textContent = 'تعديل الحساب';
  } else {
    document.getElementById('profileName').textContent = 'زائر';
    document.getElementById('profileUsername').textContent = 'لم تسجل الدخول';
    document.getElementById('profileBio').textContent = '';
    btn.textContent = 'تسجيل الدخول';
  }
}

function openEdit() {
  document.getElementById('editName').value = user.name;
  document.getElementById('editUsername').value = user.username;
  document.getElementById('editBio').value = user.bio;
  document.getElementById('editModal').classList.add('active');
}
function closeEdit() { document.getElementById('editModal').classList.remove('active'); }

function saveProfile() {
  user.name = document.getElementById('editName').value || user.name;
  user.username = document.getElementById('editUsername').value || user.username;
  user.bio = document.getElementById('editBio').value || user.bio;
  updateProfileUI();
  closeEdit();
  showToast('✅ تم الحفظ');
}

function changePhoto() {
  const input = document.createElement('input');
  input.type = 'file';
  input.accept = 'image/*';
  input.onchange = e => {
    const file = e.target.files[0];
    if (!file) return;
    const url = URL.createObjectURL(file);
    document.getElementById('editAvatar').innerHTML = `<img src="${url}">`;
    document.getElementById('profileAvatar').innerHTML = `<img src="${url}">`;
  };
  input.click();
}

/* ============ Toast ============ */
function showToast(msg) {
  const t = document.getElementById('toast');
  t.textContent = msg;
  t.classList.add('show');
  clearTimeout(t._timer);
  t._timer = setTimeout(() => t.classList.remove('show'), 2000);
}
</script>

</body>
</html>