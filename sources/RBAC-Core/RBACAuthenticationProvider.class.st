"
I represent the abstract for user authentication by means of username and password, my subclasses should specify the behaviour specific for each authentication mechanism.
"
Class {
	#name : #RBACAuthenticationProvider,
	#superclass : #GRObject,
	#classVars : [
		'AuthenticationProviderClass',
		'Current'
	],
	#category : 'RBAC-Core'
}

{ #category : #uncategorized }
RBACAuthenticationProvider class >> authenticationProviderClass [
	"Private - Answer the authentication provider class used as default."
	
	^AuthenticationProviderClass
]

{ #category : #uncategorized }
RBACAuthenticationProvider class >> authenticationProviderClass: aRBACAuthenticationProvider [
	"Private - Sets aRBACAuthenticationProvider as authentication provider class used
	by receiver."
	
	AuthenticationProviderClass := aRBACAuthenticationProvider
]

{ #category : #uncategorized }
RBACAuthenticationProvider class >> beProviderClass [

	self authenticationProviderClass: self
]

{ #category : #'security.json' }
RBACAuthenticationProvider class >> configurationFilename [
	^'security.json'
]

{ #category : #uncategorized }
RBACAuthenticationProvider class >> current [
	"Answer the current instance of provider."
	
	Current ifNil: [self initializeCurrent].
	^Current
]

{ #category : #uncategorized }
RBACAuthenticationProvider class >> defaultAuthenticationProviderClass [

	^RBACDummyAuthenticationProvider
]

{ #category : #accessing }
RBACAuthenticationProvider class >> dummy [
	^RBACDummyAuthenticationProvider new
]

{ #category : #uncategorized }
RBACAuthenticationProvider class >> initializeCurrent [
	"Private - Initializes the current instance of provider."
	
	Current := (self authenticationProviderClass ifNil: [self defaultAuthenticationProviderClass]) new
]

{ #category : #uncategorized }
RBACAuthenticationProvider class >> reset [
	"Resets the current instance of receiver."
	
	Current ifNotNil: [:c | c shutDown ].
	Current := nil
]

{ #category : #uncategorized }
RBACAuthenticationProvider >> authenticateUsername: userString password: passwordString [
	"Authenthicates a username with uid userString and passwordString.
	Answer true if authenticates successfully, otherwise answer false."
	
	self subclassResponsibility
]

{ #category : #uncategorized }
RBACAuthenticationProvider >> lastLoginOf: aRBACUser [
	
	self subclassResponsibility
]

{ #category : #uncategorized }
RBACAuthenticationProvider >> preparePassword: passwordString [
	
	^passwordString
]

{ #category : #uncategorized }
RBACAuthenticationProvider >> registerFailedLoginForUsername: userString [
]

{ #category : #uncategorized }
RBACAuthenticationProvider >> sessionFor: anUser [ 
	^anUser name asLowercase = RBACSuperUserSession superUserName asLowercase
		ifTrue: [RBACSuperUserSession for: anUser]
		ifFalse: [RBACSession for: anUser]
]

{ #category : #uncategorized }
RBACAuthenticationProvider >> setNewPassword: aString for: aRBACUser [ 
	"Defines aString as the new password of aRBACUser."

	aRBACUser setNewPassword: (self preparePassword: aString)
]
