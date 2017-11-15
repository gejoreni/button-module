{Button} = require "buttonModule"

newButton = new Button
	active: b_active
	hover: b_hover
	down: b_down
	disabled: b_disabled
	buttonLabel: "Hello World"
	parent: body
# 	x: Align.center #not working right
# 	y: Align.center #not working right

newButton.x = Align.center
newButton.y = Align.center



