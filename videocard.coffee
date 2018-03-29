###
Video card modules
-
Filename: videocard.coffee
-
Author: Hugo Magalhães
Version: 1.0
Updated: 28-March-2018
###


###  ===================================================================
     1 || GLOBAL VARIABLES ||
==================================================================== ###

###
↳ Global variables structure:
	a. Color palette
	b. Typographic settings
  c.Card sizes (Small, Medium and Large)
###


#--> Color Palette
color_grey = "#979797"
color_black = "#000000"
overlay_opacity = "rgba(0,0,0,0.4)"


#--> Typographic settings
RetinaFont = "retina"
RetinaFont_Bold = 700
RetinaFont_Medium = 500
RetinaFont_Regular = 100


### ::::::::::::::::::::::::::::::::::::::::::::::::::
    VIDEO CARD SIZES
    * (Small, Medium and Large)
:::::::::::::::::::::::::::::::::::::::::::::::::: ###

#--> Small card size
SmallCardWidth = 216
SmallCardHeight = 216
SmallCardPlayButton = 50

SmallCardTextPadding = [10, 16, 11] # Padding -> (Top, Right/Left, Bottom)
SmallCardText_source = 10 # Text (Font-size, Line-Height)
SmallCardText_header = [13, 1.5]


#--> Medium card size
MediumCardWidth = 296
MediumCardHeight = 284
MediumCardPlayButton = 70

MediumCardTextPadding = [16, 16, 16]
MediumCardText_source = 12
MediumCardText_header = [16, 1.4]


#--> Large card size
LargeCardWidth = 456
LargeCardHeight = 408
LargeCardPlayButton = 90

LargeCardTextPadding = [16, 16, 16]
LargeCardText_source = 13
LargeCardText_header = [22, 1.5]

LargeCardTest = 100


#--> Automatically assigns a height based on a AspectRatio of a component
AspectRatio = (value) ->
  Math.ceil( (value / 16) * 9 )


###  ===================================================================
     2 || VIDEOCARD CLASS ||
==================================================================== ###

class VideoCard extends Layer
    constructor: (@options={}) ->


      #--> Immutable defaults
      @options.shadowY = 2
      @options.shadowBlur = 4
      @options.shadowColor = "rgba(0,0,0,0.1)"
      @options.borderRadius = 4
      @options.clip = true

      #--> Custom defaults
      _.defaults @options,
        width: SmallCardWidth
        height: SmallCardHeight
        backgroundColor: "white"
        format: "small"

      ### ::::::::::::::::::::::::::::::::::::::::::::::::::
          UI COMPONENTS CREATION
          * Creates the UI components within the class
      :::::::::::::::::::::::::::::::::::::::::::::::::: ###

      ###
      ↳ Global variables structure:
    	   a. Thumbnail
            - Video
            - Overlay
            - Play button
            - Timestamp
            - Watch later
    	    b. Label
            - Source
            - header
        ###

      @thumbnail = new Layer
        name: "thumbnail"
        clip: true
        backgroundColor: "transparent"

      @video = new VideoLayer
        name: "video"
        video: "http://hugomagalhaes.design/framer/videos/neymar_inGame.mp4"
      @video.player.muted = true

      @overlay = new Layer
        name: "overlay"
        backgroundColor: "transparent"

      @playButton = new Layer
        name: "playButton"
        backgroundColor: "transparent"
        image: "http://hugomagalhaes.design/framer/images/playButton_loader.gif"
        opacity: 0

      @timestamp = new TextLayer
        name: "timestamp"
        text: @options.timestamp || "0:08"

        backgroundColor: "rgba(0,0,0,0.9)"
        borderRadius: 2
        padding: 5

        fontFamily: RetinaFont
        fontWeight: RetinaFont_Medium
        color: "white"

      @watchLater = new SVGLayer
      	svg:
        """
      	<svg viewBox="0 0 16 16">
      	  <path
      	  d="M8,14.7181009 L8,16 C3.58814634,16 0,12.4118537 0,8 C0,3.58814634 3.58814634,0 8,0 C12.4118537,0 16,3.58814634 16,8 C16,12.4118537 12.4118537,16 8,16 L8,14.7181009 C11.7038803,14.7181009 14.7181009,11.7038803 14.7181009,8 C14.7181009,4.29611967 11.7038803,1.28189911 8,1.28189911 C4.29611967,1.28189911 1.28189911,4.29611967 1.28189911,8 C1.28189911,11.7038803 4.29611967,14.7181009 8,14.7181009 Z M8.27058824,7.63820091 L11.1183104,9.79034662 L10.3522369,10.8040161 L7.03329787,8.29575163 L7,8.29575163 L7,4 L8.27058824,4 L8.27058824,7.63820091">
          </path>
        </svg>
        """
      	fill: "white"

      @label = new Layer
        name: "label"
        backgroundColor: "transparent"

      @labelInner = new Layer
        name: "labelInner"
        backgroundColor: "transparent"

      @source = new TextLayer
        name: "source"
        text: @options.source || "Source"

        fontFamily: RetinaFont
        fontWeight: RetinaFont_Bold
        lineHeight: 1
        letterSpacing: .5
        textTransform: "uppercase"
        color: color_grey

      @header = new TextLayer
        name: "header"
        text: @options.header || "Video header"

        fontFamily: RetinaFont
        fontWeight: RetinaFont_Medium
        color: color_black
        lineHeight: 1.5

      # Initiates component
      super @options


      #--> Animation defaults
      @animationOptions =
        curve: "bezier-curve"
        curveOptions: [0.65, 0, 1.35, 1.5]
        time: .5

      ### ::::::::::::::::::::::::::::::::::::::::::::::::::
          COMPONENTS SPECIFICATION
          * After the components are created, it assigns them a particular an hierarchical structure and a set of styles
          * Default size: Small
          * Medium and large sizes are defined within a conditional statement
      :::::::::::::::::::::::::::::::::::::::::::::::::: ###

      #--> Thumbnail | Small
      @thumbnail.parent = @
      @thumbnail.width = @width
      @thumbnail.height = AspectRatio(@width)
      @thumbnail.backgroundColor = "lightgrey"

      #--> Video | Small
      @video.parent = @.thumbnail
      @video.width = @.thumbnail.width
      @video.y = -38

      #--> Overlay | Small
      @overlay.parent = @.thumbnail
      @overlay.width = @.thumbnail.width
      @overlay.height = @.thumbnail.height

      #--> Play Button | Small
      @playButton.parent = @.thumbnail
      @playButton.size = SmallCardPlayButton
      @playButton.point = Align.center

      #--> Timestamp | Small
      @timestamp.parent = @.thumbnail
      @timestamp.fontSize = 10
      @timestamp.x = Align.right(-8)
      @timestamp.y = Align.bottom(-8)

      #--> Watch later | Small
      @watchLater.parent = @.thumbnail
      @watchLater.size = 16
      @watchLater.x = Align.right(-8)
      @watchLater.y = 8
      @watchLater.opacity = 0

      #--> Label | Small
      @label.parent = @
      @label.width = @width
      @label.height = @height - @.thumbnail.height
      @label.y = Align.bottom

      #--> LabelInner | Small
      @labelInner.parent = @.label
      @labelInner.width = @.label.width - (SmallCardTextPadding[1] * 2)
      @labelInner.height = @.label.height - (SmallCardTextPadding[0] + SmallCardTextPadding[2])
      @labelInner.point = Align.center

      # Uncomment line to see the label inner padding
      # @labelInner.backgroundColor = "rgba(43,114,255,.25)"

      #--> Source | Small
      @source.parent = @.labelInner
      @source.fontSize = SmallCardText_source
      @source.width = @.labelInner.width

      #--> Header | Small
      @header.parent = @.labelInner
      @header.fontSize = SmallCardText_header[0]
      @header.width = @.labelInner.width
      @header.y = @.source.maxY
      @header.height = @.labelInner.height - @.source.height
      @header.padding =
        top: 4
      @header.textOverflow = "ellipsis"

      ### ---------------------------
      |||--> Medium video card <--||||
      ---------------------------- ###
      if @options.format is "medium"
        @.width = MediumCardWidth
        @.height = MediumCardHeight

        #--> Thumbnail | Medium
        @.thumbnail.width = MediumCardWidth
        @.thumbnail.height = AspectRatio(@width)

        #--> Video | Medium
        @video.width = @.thumbnail.width
        @video.y = -16

        #--> Overlay | Medium
        @overlay.width = @.thumbnail.width
        @overlay.height = @.thumbnail.height

        #--> Play Button | Medium
        @playButton.size = MediumCardPlayButton
        @playButton.point = Align.center

        #--> Timestamp | Medium
        @timestamp.x = Align.right(-8)
        @timestamp.y = Align.bottom(-8)

        #--> Watch later | Medium
        @watchLater.x = Align.right(-8)
        @watchLater.y = 8

        #--> Label | Medium
        @label.width = @width
        @label.height = @height - @.thumbnail.height
        @label.y = Align.bottom

        #--> LabelInner | Medium
        @labelInner.width = @.label.width - (MediumCardTextPadding[1] * 2)
        @labelInner.height = @.label.height - (MediumCardTextPadding[0] + MediumCardTextPadding[2])
        @labelInner.point = Align.center

        #--> Source | Medium
        @source.fontSize = MediumCardText_source
        @source.width = @.labelInner.width

        #--> Header | Medium
        @header.fontSize = MediumCardText_header[0]
        @header.lineHeight = MediumCardText_header[1]
        @header.width = @.labelInner.width
        @header.y = @.source.maxY
        @header.height = @.labelInner.height - @.source.height
        @header.padding =
          top: 4
        @header.textOverflow = "ellipsis"


      ### ---------------------------
      |||--> Large video card <--||||
      ---------------------------- ###

      if @options.format is "large"
        @.width = LargeCardWidth
        @.height = LargeCardHeight

        #--> Thumbnail | Large
        @.thumbnail.width = LargeCardWidth
        @.thumbnail.height = AspectRatio(@width)

        #--> Video | Medium
        @video.width = @.thumbnail.width
        @video.height = @.thumbnail.height
        @video.y = 0

        #--> Overlay | Medium
        @overlay.width = @.thumbnail.width
        @overlay.height = @.thumbnail.height

        #--> Play Button | Large
        @playButton.size = LargeCardPlayButton
        @playButton.point = Align.center

        #--> Timestamp | Large
        @timestamp.x = Align.right(-8)
        @timestamp.y = Align.bottom(-8)

        #--> Watch later | Large
        @watchLater.size = 24
        @watchLater.x = Align.right(-8)
        @watchLater.y = 8

        #--> Label | Large
        @label.width = @width
        @label.height = @height - @.thumbnail.height
        @label.y = Align.bottom

        #--> LabelInner | Large
        @labelInner.width = @.label.width - (LargeCardTextPadding[1] * 2)
        @labelInner.height = @.label.height - (LargeCardTextPadding[0] + LargeCardTextPadding[2])
        @labelInner.point = Align.center

        #--> Source | Large
        @source.fontSize = LargeCardText_source
        @source.width = @.labelInner.width

        #--> Header | Large
        @header.fontSize = LargeCardText_header[0]
        @header.lineHeight = LargeCardText_header[1]
        @header.width = @.labelInner.width
        @header.y = @.source.maxY
        @header.height = @.labelInner.height - @.source.height
        @header.padding =
          top: 4
        @header.textOverflow = "ellipsis"


      ### ::::::::::::::::::::::::::::::::::::::::::::::::::
          EVENTS
      :::::::::::::::::::::::::::::::::::::::::::::::::: ###

      @.onMouseOver @PreviewON
      @.onMouseOut @PreviewOFF

    ###
    ↳ Getters & setter:
    	a. Format
    	b. Sub-item 2
    ###
    @define 'format',
      get: ->
        @options.format
      set: (value) ->
        @options.format = value

        if @options.format is "small"
          @.width = SmallCardWidth
          @.height = SmallCardHeight

        if @options.format is "medium"
          @.width = MediumCardWidth
          @.height = MediumCardHeight

        else if @options.format is "large"
          @.width = LargeCardWidth
          @.height = LargeCardHeight


    #--> Event functions
    PreviewON: =>
        @animate
          y: @y - 10
          shadowY: 7
          shadowBlur: 10
          shadowSpread: 3

        @video.animate
          scale: 1.05

        @overlay.animate
          backgroundColor: overlay_opacity

        @playButton.animate
          opacity: 1

        @watchLater.animate
          opacity: 1
          options:
            delay: .25

        Utils.delay .1,  =>
          @.video.player.play()
          @.video.player.loop = true

    PreviewOFF: =>
      @animate
        y: @y + 10
        shadowY: 2
        shadowBlur: 4
        shadowSpread: 0

      @video.animate
        scale: 1

      @overlay.animate
        backgroundColor: "transparent"

      @playButton.animate
        opacity: 0

      @watchLater.animate
        opacity: 0

      @.video.player.pause()
      @.video.player.loop = false

      Utils.delay .25, =>
        @.video.player.currentTime = 0

        # ###--> Assigns a random number and tricks the page
    		# # into reloading the same component each time it plays ###
        @.playButton.image = "http://hugomagalhaes.design//framer/videos/playButton_loader.gif" + "?a=" + Math.random()

# Export the module
module.exports = VideoCard
