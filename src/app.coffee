# MODEL
class Person extends Backbone.Model
	defaults: 
		name: "Guest User"
		age: 23
		occupation: "Worker"

	validate: (attrs, options) ->
		return 'Age must be positive.' if attrs.age < 0
		return 'Person must have a name' if !attrs.name

	work: ->
		console.log @get('name') + ' is working.'  # get is a backbone function


# VIEW

class PersonView extends Backbone.View	
	tagName: 'li'	 # defaults to div if not specified
	className: 'person'  # optional, can also set multiple like 'person european'

	events: 
		'click':					'alertTest'
	
	initialize: (options) ->
		@render()		# render is an optional function that defines the logic for rendering a template

	render: -> 
		@$el
			.html @model.get('name') + ' is ' + @model.get('age') + ' years old and works as ' + @model.get('occupation') 
			.appendTo $('#container')

	alertTest: ->
		alert 'klikles!'

$ ->
	person = new Person
	personView = new PersonView model: person

	newperson = new Person

