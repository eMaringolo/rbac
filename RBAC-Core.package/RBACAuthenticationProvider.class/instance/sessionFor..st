uncategorized
sessionFor: anUser 
	^anUser name asLowercase = RBACSuperUserSession superUserName asLowercase
		ifTrue: [RBACSuperUserSession for: anUser]
		ifFalse: [RBACSession for: anUser]