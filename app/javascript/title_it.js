const timer = document.getElementById('timer');
const start = document.getElementById("start");
const stop = document.getElementById("stop");
let startTime;

//startボタンを押した時にイベントが起動
start.addEventListener('click', () => {
 startTime = Date.now();
//  console.log(startTime);
//  console.log(new Date(startTime))
 countUp();
});

stop.addEventListener('click',() =>{
  countStop();
});
//coutUp()関数の中身
function countUp() {
 const d=new Date(Date.now()-startTime);
 const m=String(d.getMinutes()).padStart(2,"0");
 const s=String(d.getSeconds()).padStart(2,"0");
 timer.textContent = `${m}:${s}`;

 setTimeout(() => {
   countUp();
 }, 10);
}

function countStop() {
  console.log("stop")
}