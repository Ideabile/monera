import BG from './background'
import commands from './make-commands'
import Vue from 'vue/dist/vue'

new BG()


Vue.component('cmd-item', {
  props: ['cmd', 'active', 'index'],
  template: '<li v-bind:class="{ active: cmd.active }"><pre>{{ cmd.name }}</pre><div>{{cmd.desc}}</div></li>'
})

const Cmds = Vue.extend({
  template: `<div class="cmds"><pre>monera</pre><ol><cmd-item v-for="(cmd, i) in cmds.list" v-bind:active="cmds.active" v-bind:index="i" v-bind:cmd="cmd"></cmd-item></ol></div>`,
  methods: {
    switchCmd: function(){
      this.cmds.list[this.cmds.active].active = false
      if(this.cmds.active < this.cmds.list.length-1){
        this.cmds.active++
      }else{
        this.cmds.active = 0
      }
      this.cmds.list[this.cmds.active].active = true
    }
  },
  created: function(){
    setInterval(()=>{
      this.switchCmd()
    }, 7000);
  }
})

new Cmds({
  el: '#cmds',
  data: {
    cmds: {
      active: 0,
      list: commands.map((cmd, i) => {
        cmd.active = false;
        if( i === 0) cmd.active = true;
        return cmd;
      })
    }
  }
})
