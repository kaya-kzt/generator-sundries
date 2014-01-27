'use strict';
var util = require('util');
var path = require('path');
var yeoman = require('yeoman-generator');

var web, you;
var year = new Date().getFullYear();

var SundriesGenerator = module.exports = function SundriesGenerator(args, options, config) {
  yeoman.generators.Base.apply(this, arguments);

  this.on('end', function () {
    this.installDependencies({ skipInstall: options['skip-install'] });
  });

  this.indexPkg = JSON.parse(this.readFileAsString(path.join(__dirname, '../package.json')));
};

util.inherits(SundriesGenerator, yeoman.generators.Base);

SundriesGenerator.prototype.askFor = function askFor() {
  var cb = this.async();

  // have Yeoman greet the user.
  console.log(this.yeoman);

  var prompts = [{
    name: 'websiteName',
    message: 'What is a website name you created for?',
    default: 'web'
  },
  {
    name: 'circleName',
    message: 'What is company name?',
    default: 'company'
  },
  {
    name: 'yourName',
    message: 'What is your name?',
    default: 'user'
  }
  ];

  this.prompt(prompts, function (props) {
    // this.someOption = props.someOption;
    this.websiteName = props.websiteName;
    this.circleName = props.circleName;
    this.yourName = props.yourName;
    // 無理矢理代入.
    web = props.websiteName;
    you = props.yourName;
    this.year = year;
    cb();
  }.bind(this));
};

SundriesGenerator.prototype.app = function app() {
  // this.mkdir('app');
  // this.mkdir('app/templates');
  // Create Project Folders and move setting files.
  this.mkdir('release');
  this.mkdir('develop');
  this.mkdir('develop/sass');
  this.mkdir('develop/coffee');
  this.mkdir('develop/css');
  this.mkdir('develop/js');
  this.mkdir('develop/img');

  this.mkdir('Library');

  this.copy('main.scss', 'develop/sass/main.scss');
  this.copy('_preload.scss', 'develop/sass/_preload.scss');
  this.copy('_mixin.scss', 'develop/sass/_mixin.scss');
  this.copy('main.coffee', 'develop/coffee/main.coffee');
  this.copy('main.css', 'develop/css/' + this._.dasherize(web) + '.css');
  this.copy('main.js', 'develop/js/' + this._.dasherize(web) + '.js');

  this.copy('Gruntfile.coffee', 'Gruntfile.coffee');
  this.template('index.html', 'develop/index.html');

  this.template('_bower.json', 'bower.json');
  this.template('_config.json', 'config.json');
  this.template('_package.json', 'package.json');

  this.template('config.rb', 'config.rb');
  this.template('sftp-config.json', 'sftp-config.json');

  this.copy('bowerrc', '.bowerrc');
  this.copy('gitignore', '.gitignore');
  this.copy('csscombrc', '.csscombrc');
};

SundriesGenerator.prototype.projectfiles = function projectfiles() {
  this.copy('editorconfig', '.editorconfig');
  this.copy('jshintrc', '.jshintrc');
};
