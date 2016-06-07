AutoForm.setDefaultTemplate('materialize')
Template.header.onRendered ->
	$(".button-collapse").sideNav()
	$(".button-collapse").sideNav('hide')

FlowRouter.route "/sign-in",
	name: "signIn"
	action: ->
		BlazeLayout.render "signIn"

Accounts.onLogin ->
	if FlowRouter.current().route.name == 'signIn'
		FlowRouter.go 'home'

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
