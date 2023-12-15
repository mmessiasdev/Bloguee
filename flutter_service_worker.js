'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "9148a7c2a4ea7e4a3d593a5cc14121b0",
".git/config": "abad52165f8e608e1f20b6204c48a7e0",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "80d5d51bc5fe5ff6c88c6b1e04dae457",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "697c88e950c416010bbbee07af7002c9",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "d6f94c6a415dc218d3ab5a2c45d5d6e3",
".git/logs/refs/heads/webdeploy": "680ab912320b6eab7019ed25995b53b9",
".git/logs/refs/remotes/origin/webdeploy": "842f8da49d9322b0a3577121028544af",
".git/objects/03/9fe084a9aa7e477c663172ceaf79a4d6a2fa5c": "350fbdf7d3707e124bf0957585c66e35",
".git/objects/04/e5efc15dc0c60ea2ffcc37c5bf25e96689f44d": "978222f47488835b92838c74cb5c684c",
".git/objects/0a/2ad3a8946718e5da80b8b36f3a970f9203bb41": "493becadfb3c0f3d60727bde4e9f1614",
".git/objects/0d/427f002fcfb2a2fa26c54152094c42ee6fe3ed": "10af7d3655ab10c56575cb7d30c802f7",
".git/objects/15/f4a4678d9afc1bf88aaee90c7fba3b09b3a554": "67555cb57fa41d9359a7d4490f77710c",
".git/objects/1b/427b43a7c8332ce0485804199257b1cabe6029": "61b378758c4538032423874042689d9e",
".git/objects/20/1afe538261bd7f9a38bed0524669398070d046": "82a4d6c731c1d8cdc48bce3ab3c11172",
".git/objects/20/e8682a5ebdcc3a327042e16ded52e37ad5adf0": "1e671416889954bba9fe18719f62eb6d",
".git/objects/21/0345f5bc112dafb46d0781ecd150f822fcba2a": "b7e415e3dd5c1e19772b3b8269e3c869",
".git/objects/28/f3fa6f17dc60f12a935c43fad5d140de414a41": "dea7fab14efd90675846e30f289d430a",
".git/objects/29/81032a828a3b1f8f36d21088b805f3c1f2f7a7": "725a79a664e10e8cfad45364e2524fd8",
".git/objects/2b/1542bd7393ef97cc5f61627cb0bdc9f85db4b8": "4c037ccdad75584421756c3256545a9d",
".git/objects/2b/66598a8f0159af8c3a2d3901f62c1fbcc32c89": "75be93bc1b71dfb8102693b3d82df6c3",
".git/objects/2d/f592c928ed97ca20ad07f28bc203dc983ea4e2": "590d3825d6fed16d2812a6ec7924fdff",
".git/objects/39/0d080c923df14d04f223ba026a1424f8205697": "2fecd98345f3842f83d3c6778f3ec7e6",
".git/objects/3a/efcd6f551cfd01f34cbe6a178e10c36f314508": "75dbb07109fe3aeaf416664c42beb917",
".git/objects/3d/245a78e40b6013ddbeb7c3cab3055b51ddd9ea": "f273b736ba4ca930c96d21cf696dd265",
".git/objects/3e/08cb07566ebae7a342eb1e2fb5923a6d08536e": "473798eff4327ca90adcc4d60c3ab57b",
".git/objects/3e/c02d3cfadbfa0c7266cb28773078fcee950b5c": "6ff5dcc4caadc0639ba40cb178b30f87",
".git/objects/3f/595fcc13a68600f2546c2e00d37088a0b6f80d": "c73538f1e4cdb792f8f14eb579fa6655",
".git/objects/40/12225c0b220d0e1d67001daa7e01bba3df6953": "62a756494cd4486a4ac4ba6c10ccb080",
".git/objects/43/e946e398d96aee466fa0aabb625f0889c3a4bd": "ac34520dee747f675e6e0a15c0bbd2be",
".git/objects/48/33fcf9ba677d3df448c90e63368e50f8bfc8d6": "a5b926fccf641f8e2a09e52478c0d37a",
".git/objects/4c/9f7feb9911781afc05df81f3c535036ffce3fe": "f6ed505fec5565973a7a8b7c17125a56",
".git/objects/4f/d0e51f345ee398d4c56c9a2a36514cfdc54f3e": "d8e976b7b97437231f01681fc40815a3",
".git/objects/53/7807567919e88db2866b7825339c57e94c24d8": "970aec5149a3dbe9370a9dc982cdd022",
".git/objects/57/44f00c184b1a6529bd768489a676931b301084": "a6d4e18daa962097954546955a60f921",
".git/objects/59/5821c7ad3f8428f344effe5fc408f3f3293f6f": "4b20f6d71f195c809b777d7873628293",
".git/objects/64/71ef9c30cac57f0b5e27cd620a6359255425c2": "065639ebdb161e7e19ea65b4f30bc578",
".git/objects/6e/de577ba7cb8ffc6330474f7fc382feff4b9786": "5351a3ee6c744abf67bb70abf8d515ea",
".git/objects/73/1ab05e3068cdebe66fc0e35e6f997618317a0e": "56e23c542612a76794e76dd6e9ddb80a",
".git/objects/79/ff68d64ac9017e295df63687e6459a624ec8cc": "9817eaa53552bd5a613a8936fadf415a",
".git/objects/7a/089957aac3933379e2d1ce9aec9cc403961bfb": "e296dc1b8b61dedfb04631b00e5f461c",
".git/objects/80/6412ee2a0f81caa384a784aaa2eee65f831cde": "f9bdd00b762472fe323aa7d02cf5627c",
".git/objects/9d/38f13ee0af90302b8ac8cdbab7fb2940483104": "01f6b0aacb076e817bb3596e6cdcc2ef",
".git/objects/9e/271887ed48f519f68ff80f2e3df772305bc3c0": "2ca0060dfc2645531825e1333b7d2168",
".git/objects/a0/3c06c7b6279286367ff86c6a42e6443c5043cf": "6646d355dd666faf1c2c4b6f2acc98fe",
".git/objects/a3/504173f56d5c6f5974d8ebd6a3d59b6477a3ee": "d6f3cc4ee682d198311a83d6100be775",
".git/objects/a5/70f9e7cf2874e126baccf4f0508f8102410c6d": "f88d453848c5008a693f1a0ff803cfbb",
".git/objects/b0/df0c4ddb8763f130edb989157f707db686bc4a": "576ae4df77b13c01244489650b903bb0",
".git/objects/b9/b2cf3af7fadff052afbd70354b32b29d0d674b": "afdd0b8cb76a73adb5a909e16c516807",
".git/objects/ba/8cb00dd5231f1a55de0205c16445926a696526": "be8592f9341c9b01b70890c8614c6cf7",
".git/objects/bb/3085876799532613a08c7ebe43f24f0cc46864": "1b6aa21800d948d5513c15e54d131215",
".git/objects/be/c0f08d0dfc4350990faaeb995a0da433bafea8": "81d6b404bcb669ecec912343a0263a56",
".git/objects/c3/be4a7aaa66edfa8b6b79125b8e4effcd0c15ac": "3b36f700f151a5d3dbac1e47519c9022",
".git/objects/cc/7aee497fc81ef681994b04a1148d12d4595c3d": "977d5820941c0ef160afbcd6db2af996",
".git/objects/cc/f9d42cf69f18495ac33c4bf497e3f4c00951a3": "7460f0a110c065f0ccf5401ba2521e25",
".git/objects/cd/c2a13868f58523a9e61c6bc741e75367bd3b5f": "533b158901e990007035af533d59d12b",
".git/objects/d6/acd859f5fd0d44b47481e50318fb4acc78c5c5": "f544d7d921fb73e0fb1e17cdb1052a6c",
".git/objects/d7/2c11112c7cb4e2ce754bc41470f9b829a2d00a": "d7280a766a5d6033f187d874a92b5ad6",
".git/objects/d9/5cf798fd40ca3d175dba80cf1b9faddd6d2a8a": "48b0d46c882a3b12a3da8ccc7281f1d4",
".git/objects/db/0c71c95b78d29629f0468329f2d4dade87fe8c": "faa946ef34afb307c1a0ab80b2930999",
".git/objects/df/7d2dcb89ab89da87467c0e1059b38c8d8f9296": "a44162ff357b024e4638ab18a9bb01c7",
".git/objects/e6/b745f90f2a4d1ee873fc396496c110db8ff0f3": "2933b2b2ca80c66b96cf80cd73d4cd16",
".git/objects/e7/d7fd794113bfcad194c675ac36e071e28c539e": "1a704cd49ae7f06c886517bdb89f0f12",
".git/objects/f3/639797c5f09879db09568c1aeef2cf7519b2d5": "ef87da442393ab2ce1962fe7475d8d79",
".git/objects/fa/aea520913fa2bd191fc03e201bbda19505b644": "4b3a62e01fd6e0846217b256915f7320",
".git/refs/heads/webdeploy": "8aea6cbfc335c5a59333d5c66c038a51",
".git/refs/remotes/origin/webdeploy": "8aea6cbfc335c5a59333d5c66c038a51",
".github/workflows/flutterweb.yml": "d37f583ba87884cca7f04a6c3e6acf39",
"assets/AssetManifest.bin": "f2aa21e752cb05c7344b4aeb856ee95b",
"assets/AssetManifest.bin.json": "c9b2aa546c53094fde67876165a4ef39",
"assets/AssetManifest.json": "e8d7f19c5dfa330dc510cbea88e4f991",
"assets/assets/fonts/Montserrat-Medium.ttf": "bdb7ba651b7bdcda6ce527b3b6705334",
"assets/assets/images/branco.png": "5a3b90cbc2230fe48db3d45c64c2d922",
"assets/assets/images/preto.png": "70712ad1762d84f2e0db7b69627f590a",
"assets/FontManifest.json": "e3cf42ab6f022780a9756fc6ebe31762",
"assets/fonts/MaterialIcons-Regular.otf": "d2c7712894446b317d7e895b1b589dc9",
"assets/NOTICES": "68554bc7f1f27634222e19945e5e03cb",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "64edb91684bdb3b879812ba2e48dd487",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "f87e541501c96012c252942b6b75d1ea",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "4124c42a73efa7eb886d3400a1ed7a06",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "b4c301865ff9d95ee69469d9624514f5",
"flutter.js": "59a12ab9d00ae8f8096fffc417b6e84f",
"icons/Icon-192.png": "246f9a52e060fb2a49ade16760e68b4a",
"icons/Icon-512.png": "f4679aa24fca54eef5374ef4e5cb4c80",
"icons/Icon-maskable-192.png": "246f9a52e060fb2a49ade16760e68b4a",
"icons/Icon-maskable-512.png": "f4679aa24fca54eef5374ef4e5cb4c80",
"index.html": "c87285c646d54c1f40aef6f91e47de7a",
"/": "c87285c646d54c1f40aef6f91e47de7a",
"main.dart.js": "7a04e03b9711456d41273534e0d3c0f6",
"manifest.json": "9d91237e18477442712d925b3e374a2e",
"splash/img/dark-1x.png": "6768dbc658e789a403b8ebc64258cbcb",
"splash/img/dark-2x.png": "ac97b9cf2fcfd04cb7a42eeae5b61cc6",
"splash/img/dark-3x.png": "cf8c107e44443477e146e1671038b6c0",
"splash/img/light-1x.png": "6768dbc658e789a403b8ebc64258cbcb",
"splash/img/light-2x.png": "ac97b9cf2fcfd04cb7a42eeae5b61cc6",
"splash/img/light-3x.png": "cf8c107e44443477e146e1671038b6c0",
"splash/style.css": "86126e7e4072786170390b7ceee604b3",
"version.json": "d00997b4df7b70fe2372a4462ab93016"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
