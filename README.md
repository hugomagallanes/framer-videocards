# VideoCard components

[![license](https://img.shields.io/github/license/bpxl-labs/RemoteLayer.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](.github/CONTRIBUTING.md)
[![Maintenance](https://img.shields.io/maintenance/yes/2017.svg)]()


The VideoCard modules allows you to instantly generate an video cards. 

<img src="https://user-images.githubusercontent.com/935/28138062-118c3a22-6715-11e7-81a7-1ef1c9cf81ef.gif" width="500" style="display: block; margin: auto" alt="StatusBarLayer preview" />

### Installation

#### Manual installation

Copy or save the `VideoCards.coffee` file into your project's `modules` folder.

### Adding It to Your Project

In your Framer project, add the following:

```coffeescript
# If you manually installed
VideoCards = require "VideoCards"
```

### API

#### `new StatusBarLayer`

Instantiates a new instance of StatusBarLayer.

#### Available options

```coffeescript
myStatusBar = new StatusBarLayer
	# iOS version
	version: <number> (10 || 11)
	
	# Content
	video: <url>
	source: <string> 
	description: <string>	
```
	
### Example project


---
