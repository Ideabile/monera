import commander from 'commander'
import inquirer from 'inquirer'
import child_process from 'child_process'

let program = commander;

class Command {
  constructor(){
    this.prompt = inquirer.prompt;
  }

  action(){}
}

class BuildContainers extends Command {
  constructor(){
    super();
    this.containers = ['es6', 'browserify', 'uglify']
    this.path = './containers'

    program
      .command('build')
      .option('-c, --container [name]', 'Compile a contaner')
      .action(this.action)
  }

  action(cmd, options){
    let containers = options.container || 'all';
    if(containers === 'all') containers = [];
    if(containers.indexOf(',')) containers = containers.split(',')
    if(typeof containers === 'string') containers = [containers];

    for(let k in containers){
      this.build(containers[k]);
    }
  }

  build(container){
    console.log('SUCA!')
    child_process.spawnSync('docker', ['build', '-t', `monera-${container}`, '-f', `${this.path}/${container}`], {cwd: process.env.PWD} );
  }
}

class App {
  __constructor(){
    new BuildContainers()
  }
}

new App()


console.log('SUCA!');
