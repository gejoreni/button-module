class Button extends Layer			
	#--------------------------------------------
	# # FUNCTIONS
	#--------------------------------------------
	#buttonStyle ->	
	buttonStyle = (options = {}) ->
		backgroundColor: options.backgroundColor
		borderRadius: options.borderRadius
		width: options.width
		height: options.height
		borderColor: options.borderColor
		borderWidth: options.borderWidth
		brightness: options.brightness
		shadows: options.shadows
	# labelStyle ->	
	labelStyle = (options = {}) ->
		labelCss = options.styledTextOptions.blocks[0].inlineStyles[0].css
		fontSize: options.fontSize
		point: Align.center
		textAlign: "center"
		color: options.color
		padding: 8
		fontFamily: labelCss.fontFamily
		fontWeight: labelCss.fontWeight
	
	#--------------------------------------------
	# # CONSTRUCTOR
	#--------------------------------------------
	constructor: (options = {}) ->
		@bactive = options.active
		@bhover = options.hover
		@bdown = options.down
		@bdisabled = options.disabled
		
		#--------------------------------------------
		# # SET BUTTON DEFAULT
		#-------------------------------------------
		super(buttonStyle(@bactive))
		
		#--------------------------------------------
		# # SET LABEL TEXT
		#--------------------------------------------
		@lactive = @bactive.children[0].props
		@lhover = @bhover.children[0].props
		@ldown = @bdown.children[0].props
		@ldisabled = @bdisabled.children[0].props

		#--------------------------------------------
		# # SET TEXT DEFAULT
		#--------------------------------------------

		labelCss = @lactive.styledTextOptions.blocks[0].inlineStyles[0].css
		#---- not sure why but many of the same styles return null when you read them from the design tab.
	
		@label = new TextLayer
			parent: this
			fontSize: @lactive.fontSize
			point:Align.center
			textAlign: "center"
			padding: 8
			color: @lactive.color
			fontFamily: labelCss.fontFamily
			fontWeight: labelCss.fontWeight
			text: options.label
	
		#--------------------------------------------
		# # STATES
		#--------------------------------------------
		@states =
			Bactive: buttonStyle(@bactive)
			Bhover: buttonStyle(@bhover)
			Bdown:	buttonStyle(@bdown)
			Bdisabled: buttonStyle(@bdisabled)
		
		@label.states =
			lactive: labelStyle @lactive
			lhover: labelStyle @lhover
			ldown: labelStyle @ldown
			ldisabled: labelStyle @ldisabled
		
		# #--------------------------------------------
		# # EVENTS
		# #--------------------------------------------
		@onClick ->
			@stateCycle("Bhover")
			@label.stateCycle("lhover")
		
		@onMouseOver ->
			@stateCycle("Bhover")
			@label.stateCycle("lhover")
			#- this is prob hacky I assume there should be somthing listening for an animation change but- oh well.
			@label.animationOptions = @animationOptions
			
		@onMouseDown ->
			@stateCycle("Bdown")
			@label.stateCycle("ldown")
		
		@onMouseOut ->
			@stateCycle("Bactive")
			@label.stateCycle("lactive")
			
	#---- this keeps stuff looking right when you resize
		@on "change:frame", ->
			@label.point = Align.center
			
		@label.on "change:text", ->
			@.point = Align.center
		
		@disable = () ->
				@ignoreEvents = true
				@stateCycle("Bdisabled")
				@label.stateCycle("ldisabled")
		
		@enable = () ->
				@ignoreEvents = false
				@stateCycle("Bactive")
				@label.stateCycle("lactive")

# #--------------------------------------------
# # BUTTON ANIMATIONS
# #--------------------------------------------
# setting some defaults

	@animationOptions =
			curve: Bezier.linear
			time: 0.1

exports.Button = Button
# newbutton = new button
# 	active: b_active
# 	hover: b_hover
# 	down: b_down
# 	disabled: b_disabled
# 	label: "FART"
# 
# newbutton.animationOptions = 
# 	time: 1

