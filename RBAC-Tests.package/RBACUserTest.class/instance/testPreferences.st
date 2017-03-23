unit tests
testPreferences
	| user group |
	user := RBACUser new.
	group := RBACGroup new.
	group members add: user.
	user groups add: group.
	user preferenceValueAt: 'A' named: 'A1' put: 'foo'.
	group preferenceValueAt: 'A' named: 'A1' put: 'inheritedFoo'.
	user inheritPreferences: true.
	group inheritPreferences: false.
	self assert: (user preferenceValueAt: 'A' named: 'A1') = 'inheritedFoo'.
	self assert: (group preferenceValueAt: 'A' named: 'A1') = 'inheritedFoo'.
	self assert: (user ownPreferenceValueAt: 'A' named: 'A1') = 'foo'.
	self assert: (group ownPreferenceValueAt: 'A' named: 'A1') = 'inheritedFoo'.
	user inheritPreferences: false.
	self assert: (user preferenceValueAt: 'A' named: 'A1') = 'foo'.
	self assert: (user ownPreferenceValueAt: 'A' named: 'A1') = 'foo'.
	group inheritPreferences: false.
	self assert: (group preferenceValueAt: 'A' named: 'A1') = 'inheritedFoo'