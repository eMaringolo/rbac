"
RBACGlorpAuthenticationProvider is an RBAC authentication that uses Glorp mechanisms to lookup for RBAC users.

"
Class {
	#name : #RBACGlorpAuthenticationProvider,
	#superclass : #RBACAuthenticationProvider,
	#instVars : [
		'session'
	],
	#category : #'RBAC-Glorp-Core'
}

{ #category : #'instance creation' }
RBACGlorpAuthenticationProvider class >> session: aGlorpSession [

	^self new setSession: aGlorpSession
]

{ #category : #authentication }
RBACGlorpAuthenticationProvider >> authenticateUsername: userString password: passwordString [
	"Authenthicates a username with uid userString and passwordString.
	Answer true if authenticates successfully, otherwise answer false."

	| user |	
	user := self session readOneOf: RBACUser where: [:each | each name = userString ].
	^user notNil and: [(self preparePassword: passwordString salt: user passwordSalt) = user password]
]

{ #category : #passwords }
RBACGlorpAuthenticationProvider >> preparePassword: passwordString [

	^self preparePassword: passwordString salt: String new
]

{ #category : #passwords }
RBACGlorpAuthenticationProvider >> preparePassword: passwordString salt: saltString [
	^ (PBKDF2 derivedKeySHA1Password: passwordString salt: saltString) base64Encoded 
]

{ #category : #authentication }
RBACGlorpAuthenticationProvider >> session [

	^session
]

{ #category : #passwords }
RBACGlorpAuthenticationProvider >> setNewPassword: aString for: aRBACUser [ 
	"Defines aString as the new password of aRBACUser."

	aRBACUser generateNewSalt.
	aRBACUser password: (self preparePassword: aString salt: aRBACUser passwordSalt)
]

{ #category : #authentication }
RBACGlorpAuthenticationProvider >> setSession: aGlorpSession [

	session := aGlorpSession
]
