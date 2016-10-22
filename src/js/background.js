/* eslint-env es6 browser */

// This is wired but is related to:
// https://github.com/CreateJS/PreloadJS/issues/85
window.createjs = window.createjs || {}
require('createjs-easeljs')

const createjs = window.createjs

class Background{

  constructor(){
    this.canvas = document.getElementById("bg")

    this.canvas.width = window.innerWidth
    this.canvas.height = window.innerHeight
    this.stage = new createjs.Stage("bg")

    this.circles = []
    this.circleCount = 1000
    this.fps = 32
    this.mouse = {x: 1, y: 1}

    for (let i = 0; i < this.circleCount; i++) {
      this.createParticle()
    }

    createjs.Ticker.addEventListener("tick", ()=>{ this.tick() });
    createjs.Ticker.setFPS(this.fps);

    window.addEventListener('mousemove', p => this.setMouse(p) , false);
  }

  setMouse(p){
    this.mouse = {x: p.clientX-window.innerWidth/2, y: p.clientY-window.innerHeight/2};
  }

  createParticle(){
    let circle = new createjs.Shape();
    let grey = Math.ceil(Math.random()*30)+200
    let color = `rgba(${grey}, ${grey}, ${grey}, 1)`;

    circle._size = (Math.random() * 10);
    circle.graphics.beginFill(color).drawCircle(0, 0, circle._size);
    circle.x = Math.random() * this.stage.canvas.width;
    circle.y = Math.random() * this.stage.canvas.height;

    this.stage.addChild(circle);
    this.circles.push(circle);
  }

  tick(){
    for (let i = this.circles.length - 1; i >= 0; i--) {

      let circle = this.circles[i]
      circle.x += Math.floor(this.mouse.x) * 0.0001 * circle._size
      circle.y += Math.floor(this.mouse.y) * 0.0001 * circle._size

      let margin = 10;

      if (circle.x <= 0-margin) {
        circle.x = this.stage.canvas.width+margin;
      }
      if (circle.y <= 0-margin) {
        circle.y = this.stage.canvas.height+margin;
      }
      if (circle.x > this.stage.canvas.width+margin) {
        circle.x = 0-margin;
      }
      if (circle.y > this.stage.canvas.height+margin) {
        circle.y = 0-margin;
      }
    }

    this.stage.update();
  }
}

export default Background
