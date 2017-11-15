class Button extends Layer				
	#--------------------------------------------
	# # CONSTRUCTOR
	#--------------------------------------------
	constructor: (options = {}) ->
		
		#--------------------------------------------
		# # SET bprops
		#--------------------------------------------
		@active = options.active.props
		@hover = options.hover.props
		@down = options.down.props
		@disabled = options.disabled.props
		super(options)
		#--------------------------------------------
		# # SET label properties
		#--------------------------------------------
		@active.lprops = options.active.children[0].props
		@hover.lprops = options.hover.children[0].props
		@down.lprops = options.down.children[0].props
		@disabled.lprops = options.disabled.children[0].props
		
		#--------------------------------------------
		# # FUNCTIONS
		#--------------------------------------------
		#bprops ->	
		bprops = (props = {}) ->
			backgroundColor: options.backgroundcolor || props.backgroundColor
			borderRadius: options.borderRadius || props.borderRadius
			width: options.width || props.width
			height: options.height || props.height
			borderColor: options.borderColor || props.borderColor
			borderWidth: options.borderWidth || props.borderWidth
			brightness: options.brightness || props.brightness
			shadows: options.shadows || props.shadows
		# lprops ->	
		lprops = (props = {}) ->
			fontSize: props.fontSize
			point: Align.center
			textAlign: "center"
			color: props.color
			padding: options.padding || 8
			fontFamily: lpropsCss.fontFamily
			fontWeight: lpropsCss.fontWeight
		
		#--------------------------------------------
		# # SET BUTTON DEFAULT
		#-------------------------------------------
		@props = bprops(@active)
		# make the first state button active

		#--------------------------------------------
		# # SET CSS FOR MISSING STYLES
		#--------------------------------------------
		lpropsCss = @active.lprops.styledTextOptions.blocks[0].inlineStyles[0].css
		#---- not sure why but many of the same styles return null when you read them from the design tab.
	
		#--------------------------------------------
		# # CREATE LABEL
		#--------------------------------------------
		@buttonLabel = new TextLayer
			parent: this
			fontSize: @active.lprops.fontSize
			point:Align.center
			textAlign: "center"
			padding: 8
			color: @active.lprops.color
			fontFamily: lpropsCss.fontFamily
			fontWeight: lpropsCss.fontWeight
			text: options.buttonLabel

		#--------------------------------------------
		# # STATES
		#--------------------------------------------
		@states =
			active: bprops(@active)
			hover: bprops(@hover)
			down:	bprops(@down)
			disabled: bprops(@disabled)
		
		@buttonLabel.states =
			lactive: lprops @active.lprops
			lhover: lprops @hover.lprops
			ldown: lprops @down.lprops
			ldisabled: lprops @disabled.lprops
		
		# #--------------------------------------------
		# # EVENTS
		# #--------------------------------------------
		@onClick ->
			@stateCycle("hover")
			@buttonLabel.stateCycle("lhover")
		
		@onMouseOver ->
			@stateCycle("hover")
			@buttonLabel.stateCycle("lhover")
			#- this is prob hacky I assume there should be somthing listening for an animation change but- oh well.
			@buttonLabel.animationOptions = @animationOptions
			
		@onMouseDown ->
			@stateCycle("down")
			@buttonLabel.stateCycle("ldown")
		
		@onMouseOut ->
			@stateCycle("active")
			@buttonLabel.stateCycle("lactive")
			
	#---- this keeps stuff looking right when you resize
		@on "change:frame", ->
			@buttonLabel.point = Align.center
			
		@buttonLabel.on "change:text", ->
			@point = Align.center
		
		@disable = () ->
				@ignoreEvents = true
				@stateCycle("disabled")
				@buttonLabel.stateCycle("ldisabled")
		
		@enable = () ->
				@ignoreEvents = false
				@stateCycle("active")
				@buttonLabel.stateCycle("lactive")

exports.Button = Button
