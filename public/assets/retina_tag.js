var RetinaTag=RetinaTag||{};RetinaTag.init=function(){window.matchMedia("(-webkit-device-pixel-ratio:1)").addListener(RetinaTag.updateImages),document.addEventListener("page:load",RetinaTag.updateImages),document.addEventListener("retina_tag:refresh",RetinaTag.updateImages)},RetinaTag.updateImages=function(){for(var e=document.getElementsByTagName("img"),t=0;t<e.length;t++)e[t].getAttribute("data-lazy-load")||RetinaTag.refreshImage(e[t])},RetinaTag.refreshImage=function(e){var t=e.getAttribute("data-lazy-load"),a=e.src,i=e.getAttribute("hidpi_src"),d=e.getAttribute("lowdpi_src");i&&(t&&e.removeAttribute("data-lazy-load"),window.devicePixelRatio>1&&a!=i?(d||e.setAttribute("lowdpi_src",a),e.src=i):(!window.devicePixelRatio||window.devicePixelRatio<=1)&&(a==i||d&&a!=d)&&(e.src=d))},void 0!==window.devicePixelRatio&&(RetinaTag.init(),$(document).ready(RetinaTag.updateImages));