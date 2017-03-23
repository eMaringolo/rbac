uncategorized
initializeCurrent
	"Private - Initializes the current instance of provider."
	
	Current := (self authenticationProviderClass ifNil: [self defaultAuthenticationProviderClass]) new