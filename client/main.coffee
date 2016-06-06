AutoForm.setDefaultTemplate('materialize')

FlowRouter.route "/sign-in",
	name: "signIn"
	action: ->
		BlazeLayout.render "signIn"

Template.registerHelper	"getEmail", ->
	Meteor.user()?.emails?[0]?.address

Template.registerHelper	"formatDate", (date)->
	moment(date).calendar()

Template.header.events
	"click .sign-out": ->
		Accounts.logout()

FlowRouter.route "/",
	name: "home"
	action: ->
		BlazeLayout.render "home"
	subscriptions: (params) ->
		@register 'chatRooms', Meteor.subscribe "chatRooms"

Template.home.helpers
	chatRooms: @Models.ChatRooms.find {}, sort: 'createdAt': -1
