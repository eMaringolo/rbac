Class {
	#name : #RBACAuthenticationProviderTestCase,
	#superclass : #RBACTest,
	#category : 'RBAC-Tests'
}

{ #category : #uncategorized }
RBACAuthenticationProviderTestCase >> authenticationProvider [

	^RBACAuthenticationProvider dummy
]

{ #category : #uncategorized }
RBACAuthenticationProviderTestCase >> testDummyAuthentication [
	self
		assert:
			(self authenticationProvider
				authenticateUsername: 'foo'
				password: 'baz')
]

{ #category : #uncategorized }
RBACAuthenticationProviderTestCase >> testReturnACorrectRBACSession [
	self assert: (RBACAuthenticationProvider new sessionFor: RBACUser new) class = RBACSession.
	self
		assert: (RBACAuthenticationProvider new sessionFor: (RBACUser new isSuperuser: true)) class = RBACSession.
	self
		assert:
			(RBACAuthenticationProvider new
				sessionFor: (RBACUser new name: RBACSuperUserSession superUserName)) class
				= RBACSuperUserSession
]
