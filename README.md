# generator-sundries [![Built with Grunt](https://cdn.gruntjs.com/builtwith.png)](http://gruntjs.com/)
generator-sundries is a supporting tool for making simple webpage.  
A generator for [Yeoman](http://yeoman.io).  

![generator-sundries](http://kakurezatou.com/wordpress/wp-content/themes/kakurezatou/images/works/generator-sundries_logo.png)

generator-sundries has a some useful function. Auto compile SASS and Coffeescript, auto combine files, auto minimize and automatic browser reflesh when some files are changed. These fuction will help you create a simple HTML pages example for mini-blog or single page.

## Features

* Auto compile SASS & Coffeescript
* CSS files are automatically mixed
* Launch localserver
* Browser is automatically reloaded when file are changed
* Minimize CSS and Javascript files automatially
* Download your favorite library or script using bower

## Getting Started

- Install: node.js
- Install basic packages: 'npm install -g bower grunt-cli yo'
- Install needed packages: 'npm install -g coffee-script coffeelint csscomb csslint jshint node-sass'
- Install this package: 'npm install -g generator-sundries'
- Input Website name, Company name, Your name following instruct on console
- Write 'grunt -v' on project root folder. if no error occured, generator-suncries is installed successfully

## Usage

* Your website placed under the /develop directory. Your should change or add files under the develop folder.
* 'grunt' is a basic command for development. Automatically open localhost:9001 and start watching files.
* During watching, changing or adding files are automatically detected. Browser is reloaded after a suitable processing.
* 'grunt release' is a command for making release build under the /release directory. CSS and js files are combine and minimized.

## More useful grunt command
See the under of Gruntfile.coffee.


## License

[MIT License](http://en.wikipedia.org/wiki/MIT_License)
