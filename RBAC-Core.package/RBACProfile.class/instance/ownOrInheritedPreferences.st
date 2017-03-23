testing
ownOrInheritedPreferences
	self inheritPreferences
		ifTrue: [ ^ self groups flatCollect: [ :each | each ownOrInheritedPreferences ] ].
	^ self preferences