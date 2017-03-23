uncategorized
testReturnACorrectRBACSession
	self assert: (RBACAuthenticationProvider new sessionFor: RBACUser new) class = RBACSession.
	self
		assert: (RBACAuthenticationProvider new sessionFor: (RBACUser new isSuperuser: true)) class = RBACSession.
	self
		assert:
			(RBACAuthenticationProvider new
				sessionFor: (RBACUser new name: RBACSuperUserSession superUserName)) class
				= RBACSuperUserSession