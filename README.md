# button-module Working WIP
a simple framer module for creating buttons from the design tab

![alt text](https://github.com/gejoreni/button-module/blob/master/button-module.png?raw=true "Header Image")


![alt text](https://github.com/gejoreni/button-module/blob/master/button-gif.gif?raw=true "Header gif")

So, first things first - i'm not a developer, not even close. This is just an example of how i'd like to take advantage of the design tab inside of the code tab. Don't judge me  - and if you don't like it, leave it - I won't judge you ;)

## How to:

#### 1. Design 4 button state layers in the design tab. 
- Active
- Hover
- Down
- Disabled

Call them whatever you want just make sure they are all targeted and available in the code tab. In the following example I call them b_active, b_hover, b_down, b_disabled.

#### NOTE: Each button needs to have a child textLayer. The module will take on the style of each and animate it across the different states.

The button class doesn't really have any validation so if a button doesn't have a text layer inside of it - stuff will break. 

#### 2. Create a new Button using the button Module

```
newButton = new Button
	active: b_active # takes in a layer with a textLayer inside.
	hover: b_hover  # takes in a layer with a textLayer inside.
	down: b_down # takes in a layer with a textLayer inside.
	disabled: b_disabled # takes in a layer with a textLayer inside.
	buttonLabel: "Hello World" # this is the text that shows on the button
 
 ```
#### 3. work with the new button like you would any other layer.

You can change animations etc via newButton.animationOptions it will automatically update the label animations to match.
Use newButton.label to edit and change the textLayer. I don't really know what else to say. This is my first time uploading something like this. Enjoy. 


#### other stuff

please feel free to modify or change this in any way if you like. 
