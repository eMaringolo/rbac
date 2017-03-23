unit tests
testAdditionToAndRemotionFromGroup
	| user |
	user := RBACUser new.
	user onAddedToGroup: (self groups at: 1).
	self assert: (user groups difference: (Set with: (self groups at: 1))) isEmpty.
	user onAddedToGroup: (self groups at: 2).
	self
		assert:
			(user groups difference: (Set with: (self groups at: 1) with: (self groups at: 2)))
				isEmpty.
	user onRemovedFromGroup: (self groups at: 2).
	self assert: (user groups difference: (Set with: (self groups at: 1))) isEmpty.
	user onAddedToGroup: (self groups at: 3).
	self
		assert:
			(user groups difference: (Set with: (self groups at: 1) with: (self groups at: 3)))
				isEmpty.
	user onRemovedFromGroup: (self groups at: 1).
	self assert: (user groups difference: (Set with: (self groups at: 3))) isEmpty.
	user onRemovedFromGroup: (self groups at: 3).
	self assert: user groups isEmpty