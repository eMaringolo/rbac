uncategorized
testDummyAuthentication
	self
		assert:
			(self authenticationProvider
				authenticateUsername: 'foo'
				password: 'baz')