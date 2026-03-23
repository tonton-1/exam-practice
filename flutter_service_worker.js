'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "62ec3b6df26e4106d86e974939d9f46e",
"assets/AssetManifest.bin.json": "3f66414c1b554fc4d992dc102dbb1ee6",
"assets/AssetManifest.json": "3d1d03e9e6e8d1a4e4ccfc9e22e81f43",
"assets/assets/images/eng2566M3/10.png": "edfd647af9ac10a4fd1cdf2a49d60c47",
"assets/assets/images/eng2566P6/1.png": "8a8b3e9e944eedcad04f33df130cc4ec",
"assets/assets/images/eng2566P6/15.png": "1664eb0af93d5a476f056afd6c274dc7",
"assets/assets/images/eng2566P6/20.png": "67fb8ec5e0de3d67faa13e45549f6b4c",
"assets/assets/images/eng2566P6/22.png": "3df8dfd9d7af31d370ee506544f76139",
"assets/assets/images/eng2566P6/24.png": "3e43d2d1b01ec949e1f5b67d9e51ade3",
"assets/assets/images/eng2566P6/28.png": "1193287421e3a0d79ecd16df6298de02",
"assets/assets/images/eng2566P6/32.png": "d016c950ddb378be55d71850f09b0225",
"assets/assets/images/eng2566P6/4.png": "e61883f3917f11588b28b99f7ea61f01",
"assets/assets/images/eng2566P6/6.png": "29c95c42b62bfdf4b3ce5648f215c3b9",
"assets/assets/images/eng2566P6/7.png": "0dd43d33af8abb4887175bbea5ea576d",
"assets/assets/images/eng2566P6/9.png": "2687c723113b14dc11298673970f7ea4",
"assets/assets/images/eng2567P6/animal_lifespan.png": "c6ea47e622008215fa0c00fdd8ae1086",
"assets/assets/images/eng2567P6/beach_clean.png": "3f0f298874996ef0514d0bca30e37852",
"assets/assets/images/eng2567P6/drugstore.png": "8231c63dabb05e8e816571c0ca736dee",
"assets/assets/images/eng2567P6/footbridge.png": "0a5db28d73123c70c250af74c5b34493",
"assets/assets/images/eng2567P6/map_direction.png": "6ac5c74918ae729399df24302b676f14",
"assets/assets/images/eng2567P6/Onahotelroomdoor.png": "eb7914d9a4d108df01f58060833a2d1b",
"assets/assets/images/eng2567P6/padthai_coupon.png": "2464db19d4fe5b2503fdaae8e6d43d9e",
"assets/assets/images/eng2567P6/shapes.png": "07d338efe6e05a6b0528d4d483bfe677",
"assets/assets/images/eng2567P6/weather_forecast.png": "fee016dbf2b3ff494a42e8410708a82a",
"assets/assets/images/math2563M6/13.png": "084d3f82ea465c87d65dfc09ebe8bba4",
"assets/assets/images/math2563M6/14.png": "9b22c36de4c51a5dbd77688d315f05cd",
"assets/assets/images/math2563M6/17.png": "a76dedd139776d46f40ef80abe79302d",
"assets/assets/images/math2563M6/18.png": "939dd031ed37e93e548776d78586440b",
"assets/assets/images/math2563M6/19.png": "03ca0d7aed8db44f32e992414acb573b",
"assets/assets/images/math2563M6/20.png": "4a26f333704157ec86b993a29ce85049",
"assets/assets/images/math2564M6/14.png": "d29c8a2899ab0e009fc0bd7b4340ef2c",
"assets/assets/images/math2564M6/16.png": "0a91a777a497e7b48d04f226397fa876",
"assets/assets/images/math2564M6/17.png": "774e3c0467189bb0d240b38f13ff2ca2",
"assets/assets/images/math2566M3/10.png": "bf855b2adfc0f3de6430454f0672998d",
"assets/assets/images/math2566M3/11.png": "d9931221dc10558116c222a4f57aeed4",
"assets/assets/images/math2566M3/14.png": "da97fbf4d84bee8860baaea921f5b326",
"assets/assets/images/math2566M3/3.png": "335b3a1e8ce0fb3c108019ea02505af8",
"assets/assets/images/math2566M3/4.png": "6bfc165a4202e655bf9740f78f9383e7",
"assets/assets/images/math2566M3/5.png": "59999d35662b1e8ade858e97aa2987f9",
"assets/assets/images/math2566M3/6.png": "b14e1b5486638a7915e0806ac1750e96",
"assets/assets/images/math2566M3/9.png": "ff1f8a97e520e4b4f0d2320a5faed4db",
"assets/assets/images/math2566P6/11.png": "c163ceb0a7d07860be4c3d080d02935c",
"assets/assets/images/math2566P6/14.png": "a089d6c57fca47439085250fffb0cdde",
"assets/assets/images/math2566P6/15.png": "fb96c7ce7e0557eca75dfaee2bb11b2f",
"assets/assets/images/math2566P6/8.png": "d3fb40a992b4c239372266d46db136de",
"assets/assets/images/math2566P6/9.png": "ae481a3688f348e2493e40a29efab216",
"assets/assets/images/math2567P6/11.png": "2c3f55b95abdd09800b7a4a3e95c054b",
"assets/assets/images/math2567P6/8.png": "c077671a58e17bf4a9f23cb90d63cc62",
"assets/assets/images/math2567P6/9.png": "6e7084e350fdc0da2c0ec90f101edc31",
"assets/assets/images/science2564M6/01.png": "66dc32a126be8de5324e91ef238a3a99",
"assets/assets/images/science2564M6/02.png": "6ed4b17240089beaa56710ff76f2b5ff",
"assets/assets/images/science2564M6/03.png": "8f5c7bf510fa2a180ae5c39aada05d9f",
"assets/assets/images/science2564M6/04.png": "548a8d6f1abcf6b20f094b11558d2e6f",
"assets/assets/images/science2564M6/05.png": "e729885983e097099743aaa0995c45e6",
"assets/assets/images/science2564M6/06.png": "84afb7dfa2365b65f783710d163d2d01",
"assets/assets/images/science2564M6/07.png": "770fdc403cd9a98dbf7980d41f171478",
"assets/assets/images/science2564M6/08.png": "d66bc302033ec42b77aacf5011e5f516",
"assets/assets/images/science2564M6/09.png": "84aeff60f96f7600a43aa205a7558720",
"assets/assets/images/science2566P6/11.png": "7d47e70cdd804f179082352afff91136",
"assets/assets/images/science2566P6/14.png": "095ea781610e63135fed6fc106d22026",
"assets/assets/images/science2566P6/15.png": "45ca4d60d5ef7b65dbc124ee2424d0c7",
"assets/assets/images/science2566P6/16.png": "9ee30f9d7202fd22919ea106649dfe76",
"assets/assets/images/science2566P6/17.png": "afb3377903998dee446d4a4a06fd2394",
"assets/assets/images/science2566P6/2.png": "6fa6220f993252efb700707315aa0082",
"assets/assets/images/science2566P6/4.png": "6662a133821c15d56b87952a002a4b4c",
"assets/assets/images/science2566P6/7.png": "dadf96e09f4529afed57a946ad30e358",
"assets/assets/images/science2567M3/1.png": "993cc8fb56bcbd59edb85659016df3cf",
"assets/assets/images/science2567M3/12.png": "4ecccacf17bb2bbdba88c8f689ba10f8",
"assets/assets/images/science2567M3/15.png": "7b07ffbedb50238824e2c0537075ce67",
"assets/assets/images/science2567M3/16.png": "368e2293620177e5d773a49101c66be5",
"assets/assets/images/science2567M3/17.png": "320fe66875eeee4452fe570836ad075f",
"assets/assets/images/science2567M3/20.png": "60ccfd542eafceff4dbeb50b434a6d0e",
"assets/assets/images/science2567M3/23.png": "ee05c9eade24b5480844294f9ad3b6c2",
"assets/assets/images/science2567M3/26.png": "67024413ab1512ff4411e0624ae3b4e4",
"assets/assets/images/science2567M3/31.png": "39a410c2385c7ba6472133880aefa3d1",
"assets/assets/images/science2567M3/6.png": "47b0a5702503828762c1eb90f5ab1cbf",
"assets/assets/images/science2567M3/8.png": "e6f72adfa75f4786d7d40f71749cd231",
"assets/assets/images/science2567P6/11.png": "ceeb79fed38992445937f31a4eebfb5d",
"assets/assets/images/science2567P6/14.png": "1491e05a5cc30b29800a40cd71d8ef9b",
"assets/assets/images/science2567P6/16.png": "9b849a2f1202050181ca24c1b6d502de",
"assets/assets/images/science2567P6/4.png": "3181902d85bc7fddf4de228dd6949a9b",
"assets/assets/images/science2567P6/8.png": "cd8c12391250302f87b43cccb9a23b4a",
"assets/assets/images/thai2566M3/1.png": "50329266592e67e2375ee0d7675da830",
"assets/assets/images/thai2566M3/11.png": "31918974d0a4ea7cf5c37a2ee75d6934",
"assets/assets/images/thai2566M3/12.png": "67fc364325f38a7b9c5dc2261c67720a",
"assets/assets/images/thai2566M3/15.png": "4a30bdf4be4c68e285fdc7a66b61959f",
"assets/assets/images/thai2566M3/16.png": "b7bb5570162e31b1901db17672d065b2",
"assets/assets/images/thai2566M3/17.png": "afdea00dc94c1154cd4b19d57190245f",
"assets/assets/images/thai2566M3/18.png": "c2ffb563af9fb071ce1eb884a9ce5474",
"assets/assets/images/thai2566M3/19.png": "7a4149ef954d21449ae72f385ac69332",
"assets/assets/images/thai2566M3/2.png": "7e08314fc4b0e115a38338ad1230d97f",
"assets/assets/images/thai2566M3/23.png": "f96c9b759cda38bf3ef4f63a77377621",
"assets/assets/images/thai2566M3/25.png": "723aa882b7063bc3d892e87d49163a9c",
"assets/assets/images/thai2566M3/3.png": "3fdeb97c8f0474469d5888096525e438",
"assets/assets/images/thai2566M3/5.png": "43484a5b93d05002ad0b80dbc6a56c95",
"assets/assets/images/thai2566M3/6.png": "df22bb9cc566501a44b5bac35b290daf",
"assets/assets/images/thai2566M3/7.png": "1ed5ea2a9160ea8891fd69d8418ac9bd",
"assets/assets/images/thai2566M3/8.png": "a25520841c02e1ab3cb7bcde24dac64b",
"assets/assets/images/thai2566M3/9.png": "b4974e3b4d5ca7b40bb40fbc5b682b9e",
"assets/assets/images/thai2566P6/16.png": "7e96300b8516ebbc17ccc028964b8041",
"assets/assets/images/thai2566P6/3.png": "e643863004583f80691b70331658b4e8",
"assets/assets/images/thai2566P6/4.png": "4c4bac60c40745a8e34a49df5c3fa87f",
"assets/assets/images/thai2566P6/5.png": "fecd4022bdf1ab2f47c6e9a791b9d6bc",
"assets/assets/images/thai2566P6/6.png": "05ce6aa72633f51ee1a678eac08997c7",
"assets/assets/images/thai2566P6/7.png": "97f4e04412f101083486666dc7e299f4",
"assets/assets/images/thai2566P6/8.png": "e6817da251f4d48b4b76bbd9cbb82b8c",
"assets/assets/images/thai2566P6/9.png": "00339a4e7c1d24c70f0455c35b0675f4",
"assets/assets/images/thai2567P6/11.png": "355f0643f56627f396d64bd022b3a36a",
"assets/assets/images/thai2567P6/6.png": "f5e532878787d4f0ba88d1a7e09b1f80",
"assets/assets/images/thai2567P6/7.png": "02796cc027ae82b2a36ba7003e4cb3b1",
"assets/assets/images/thai2567P6/8.png": "42e353f6ec7460d47491833ce14f9d0b",
"assets/assets/images/thai2567P6/9.png": "deb9b898b2a50c87d7208fa442080102",
"assets/assets/logo.png": "8846d6cb168a0316c5a7a0a7077f0365",
"assets/assets/onboardingscreenimage/1.png": "73cea7132d32b1c85f8d9238cafe6162",
"assets/assets/onboardingscreenimage/2.png": "5642278093a007494da198d36c6aa1c2",
"assets/assets/onboardingscreenimage/3.png": "5615fe29ddc267051546f753afba040b",
"assets/assets/onboardingscreenimage/4.png": "ec6157f4043bd51d8592ad9a4ec1a642",
"assets/assets/register.png": "2f18f04b12e6f491707cf1f60d7ce744",
"assets/FontManifest.json": "7920de41c58b42dbd3b2fdc96094529a",
"assets/fonts/MaterialIcons-Regular.otf": "f94416931189f8052b0e430d706bedb1",
"assets/M32565/M3English2565.json": "3ec264026a3c8b087bb4949c12f045cb",
"assets/M32565/M3Math2565.json": "2f3f1ed28c21cf0b9a708ad58a537119",
"assets/M32565/M3Science2565.json": "846c4c00e3a6c2481193c3642fc30305",
"assets/M32565/M3Thai2565.json": "34f998f88af4594e4f9ffe7753327c96",
"assets/M32566/M3English2566.json": "9f8a840fb678e040b1f4357a3c2030ba",
"assets/M32566/M3Math2566.json": "ffcef2bb1a8e88da93f8171f4d9a98c9",
"assets/M32566/M3Science2566.json": "25d1700a1ebbff7da29efb01e529b9e7",
"assets/M32566/M3Thai2566.json": "09e822e057115284f197278bf769b55a",
"assets/M32567/M3English2567.json": "0ff92413e646bff336751e0412131c46",
"assets/M32567/M3Math2567.json": "d6746935df77f39de39e097aa31e78c7",
"assets/M32567/M3Science2567.json": "d9627aee8f28c3f4f49d0f0cb13bb3c0",
"assets/M32567/M3Thai2567.json": "182293171984aa07e83341052395d4e4",
"assets/M62563/M6Math2563.json": "5bad4bd420796df3342f3811d6b3cde9",
"assets/M62563/M6Social2563.json": "6d5d76eb251352c2630223fb3990f2f3",
"assets/M62563/M6Thai2563.json": "29d33ff465cfc8209a011bf0c300a982",
"assets/M62564/M6Math2564.json": "9e925f3f552a65796a306ee1568f904d",
"assets/M62564/M6Science2564.json": "aa64527c6602f08f40d3476f22338a03",
"assets/M62564/M6Social2564.json": "f68198101f94c89d87f7be6d55d8f2d5",
"assets/M62564/M6Thai2564.json": "a0a0f9b64466c18b2f47854e7e0acf47",
"assets/NOTICES": "caecc59e051446c32ac6144bcc28b8a5",
"assets/P62566/P6English2566.json": "cce99f8114898424a938a792d179dd5d",
"assets/P62566/P6Math2566.json": "6f4217d568dbf92f56f219c580b7f443",
"assets/P62566/P6Science2566.json": "d4651ba7a303593e884cfdf3308780fa",
"assets/P62566/P6Thai2566.json": "2c603994a61552031eb76e72a18fe2d6",
"assets/P62567/P6English2567.json": "2c6fcecf577a034513093e25f930c6f0",
"assets/P62567/P6Math2567.json": "da2a622b470ad235517583977087dc2d",
"assets/P62567/P6Science2567.json": "aa0c543e7ed87c885ee7f19403048fee",
"assets/P62567/P6Thai2567.json": "41d1d9ed6f2cfb11130a57d2decee6ec",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "15d54d142da2f2d6f2e90ed1d55121af",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "8be0604bc5f1081da01f4bcab5d66468",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "de83ff0a875ba978513bcc5210fdb382",
"assets/packages/iconsax_flutter/fonts/FlutterIconsax.ttf": "cc0500ba509f30a11708c5d3a43f39a4",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "aac5136dcebd4ebb10905c8c174ec634",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "05a6c57be6e8ff6847f056b81a895c8a",
"/": "05a6c57be6e8ff6847f056b81a895c8a",
"main.dart.js": "5fceba4b112782d2642f06ef0fec690a",
"manifest.json": "3d8004282ed7a8f208d92f9e203d4bc4",
"version.json": "0210c52890e68f495722f15b37933d9b"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
