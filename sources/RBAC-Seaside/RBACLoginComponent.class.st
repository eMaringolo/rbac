"

"
Class {
	#name : 'RBACLoginComponent',
	#superclass : 'WAComponent',
	#instVars : [
		'username',
		'password',
		'authenticator'
	],
	#vw_namespace : 'Root',
	#category : 'RBAC-Seaside'
}

{ #category : 'instance creation' }
RBACLoginComponent class >> on: authenticationProvider [

	^self new
		setAuthenticator: authenticationProvider;
		yourself
]

{ #category : 'operations' }
RBACLoginComponent >> attemptLogin [

	self answer: true
]

{ #category : 'accessing' }
RBACLoginComponent >> authenticator [

	^authenticator
]

{ #category : 'initialize-release' }
RBACLoginComponent >> initialize [
	"Initialize a newly created instance. This method must answer the receiver."

	super initialize.
	^self
]

{ #category : 'accessing' }
RBACLoginComponent >> password [
	^password ifNil: [String new]
]

{ #category : 'accessing' }
RBACLoginComponent >> password: aString [ 
	password := aString
]

{ #category : 'rendering' }
RBACLoginComponent >> renderContentOn: html [

	(html div)
		align: 'center';
		with: [self renderLoginFormOn: html]
]

{ #category : 'rendering' }
RBACLoginComponent >> renderLoginFormOn: html [

	html tbsForm: 
			[html tbsFormGroup: 
					[(html label)
						for: 'username';
						with: 'Username:'.
					(html textInput)
						id: 'username';
						attributeAt: 'placeholder' put: 'username';
						callback: [:value | self username: value]].
			html tbsFormGroup: 
					[(html label)
						for: 'password';
						with: 'Password:'.
					(html passwordInput)
						id: 'password';
						attributeAt: 'placeholder' put: 'password';
						callback: [:value | self password: value]].
			html tbsFormGroup: 
					[(html anchor)
						callback: [self attemptLogin];
						with: 'Sign in']]
]

{ #category : 'initialize-release' }
RBACLoginComponent >> setAuthenticator: authenticationProvider [

	authenticator := authenticationProvider
]

{ #category : 'javascript' }
RBACLoginComponent >> submitButtonScriptOn: html [

	html jQuery ajax 
		callback: [self attemptLogin]
]

{ #category : 'accessing' }
RBACLoginComponent >> username [
	^username ifNil: [String new]
]

{ #category : 'accessing' }
RBACLoginComponent >> username: aString [ 
	username := aString
]
