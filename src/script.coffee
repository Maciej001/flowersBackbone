
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
	id: 'people' # optional

	events: 
		'click':					'alertTest'
		'click .edit':		'editPerson'
		'click .delete':	'deletePerson'
	
	initialize: ->
		@render()		# render is an optional function that defines the logic for rendering a template

	render: -> 
		# @$el.text 
		console.log "my name is " + @get('name')

$ ->
	person = new Person
	person.work()
	personView = new PersonView
