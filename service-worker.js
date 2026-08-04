const CACHE = "bold-dragoon-hub-v12-1";
const ASSETS = [
  "./",
  "./index.html",
  "./manifest.webmanifest",
  "./bold-dragoon-logo.png",
  "./icon-192.png",
  "./icon-512.png"
];

self.addEventListener("install", event => {
  event.waitUntil(caches.open(CACHE).then(cache => cache.addAll(ASSETS)));
  self.skipWaiting();
});

self.addEventListener("activate", event => {
  event.waitUntil(
    caches.keys().then(keys =>
      Promise.all(keys.filter(key => key !== CACHE).map(key => caches.delete(key)))
    )
  );
  self.clients.claim();
});

self.addEventListener("fetch",event=>{
  const url=new URL(event.request.url);
  const isDynamic=event.request.mode==="navigate" || url.pathname.startsWith("/.netlify/functions/");
  if(isDynamic){
    event.respondWith(
      fetch(event.request).then(response=>{
        if(event.request.mode==="navigate"){
          const copy=response.clone();
          caches.open(CACHE).then(cache=>cache.put("./index.html",copy));
        }
        return response;
      }).catch(()=>caches.match("./index.html"))
    );
    return;
  }
  event.respondWith(
    caches.match(event.request).then(cached=>cached||fetch(event.request))
  );
});