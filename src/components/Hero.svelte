<script>
    import { onMount } from 'svelte';

    onMount(() => {
        console.log('mounted hero');
        var TxtRotate = function(el, toRotate, period) {
  this.toRotate = toRotate;
  this.el = el;
  this.loopNum = 0;
  this.period = parseInt(period, 10) || 2000;
  this.txt = '';
  this.tick();
  this.isDeleting = false;
};

TxtRotate.prototype.tick = function() {
  var i = this.loopNum % this.toRotate.length;
  var fullTxt = this.toRotate[i];

  if (this.isDeleting) {
    this.txt = fullTxt.substring(0, this.txt.length - 1);
  } else {
    this.txt = fullTxt.substring(0, this.txt.length + 1);
  }

  this.el.innerHTML = '<span class="wrap">'+this.txt+'</span>';

  var that = this;
  var delta = 300 - Math.random() * 100;

  if (this.isDeleting) { delta /= 2; }

  if (!this.isDeleting && this.txt === fullTxt) {
    delta = this.period;
    this.isDeleting = true;
  } else if (this.isDeleting && this.txt === '') {
    this.isDeleting = false;
    this.loopNum++;
    delta = 500;
  }

  setTimeout(function() {
    that.tick();
  }, delta);
};

  var elements = document.getElementsByClassName('txt-rotate');
  for (var i=0; i<elements.length; i++) {
    var toRotate = elements[i].getAttribute('data-rotate');
    var period = elements[i].getAttribute('data-period');
    if (toRotate) {
      new TxtRotate(elements[i], JSON.parse(toRotate), period);
    }
  }
  // INJECT CSS
  var css = document.createElement("style");
  css.type = "text/css";
  css.innerHTML = ".txt-rotate > .wrap { border-right: 0.08em solid hsl(var(--pc)) }";
  document.body.appendChild(css);
    });
</script>


<div class="flex flex-col xl:flex-row gap-8 gap-x-8 w-4/6 h-screen p-8 mx-auto beforeemoji mb-16">
    <div class="mt-16 lg:m-0 xl:m-0 slide flex max-w-prose flex-col justify-center items-center w-3/4 h-full text-primary-content z-10">
        <h1 class="text-base-content text-5xl md:text-6xl xl:text-8xl font-medium antialiased">Hi. I'm Nitro. I'm a <span class='txt-rotate' data-period="2000" data-rotate='[ "Webdev.", "Student.", "Trader." ]'></span></h1>
        <p class=" mt-8 text-base-content text-3xl font-light antialiased">I am also interested smart contract development and everything revolving around blockchain.</p>
    </div>
    <div class="max-w-prose flex items-center w-full h-full text-primary-content z-10">
        <img src="./opening.png" alt="opening" class="float max-w-full xl:max-w-3xl 2xl:max-w-4xl rounded-xl shadow-2xl h-fit shadow-2xl rounded-3xl mx-auto">
    </div>
</div>
    

<style>
    @keyframes appear {
        0% {
            opacity: 0;
        }
        100% {
            opacity: 1;
        }
    }

    @keyframes float {
        0% {
            transform: translateY(7px);
        }
        50% {
            transform: translateY(-15px);
        }
        100% {
            transform: translateY(7px);
        }
    }
    .slide{
        animation: appear 1s ease-in-out;
    }
    .card{
        transition: background-color 0.5s ease-in-out;
    }
    .float{
        animation: float 4s ease-in-out infinite;
        animation-play-state: running;
    }
    .text-5xl::before{
    height: 300px;
    font-size: 300px;
    content: "Ξ";
    font-weight: 300;
    z-index: -2;
    user-select: none;
    transform: translateY(-5%) translate(97%);
    -webkit-text-stroke: 2px white;
    color: transparent;
    opacity: .5;
    position: absolute;
    left:15%;
    top:80%;
    rotate: 30deg;
    animation: float 7s ease-in-out infinite;
    }
    .beforeemoji::after{
    height: 200px;
    font-size: 300px;
    content: "◈";
    font-weight: 300;
    z-index: 2;
    user-select: none;
    transform: translateY(-5%) translate(97%);
    -webkit-text-stroke: 2px white;
    color: transparent;
    opacity: .6;
    position: absolute;
    left:85%;
    top:7%;
    rotate: 70deg;
    animation: float 7s ease-in-out infinite;
  }
        

</style>