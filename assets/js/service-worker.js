var staticCacheName = "beam-counter-pwa";

self.addEventListener("install", function (e) {
  console.log("installing pwa and caching all the things...");
});

self.addEventListener("fetch", function (event) {
  event.respondWith(
    caches.match(event.request).then(function (response) {
      return response || fetch(event.request);
    })
  );
});
