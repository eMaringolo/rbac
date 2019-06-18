Class {
	#name : #RBACUserTest,
	#superclass : #RBACProfileTest,
	#category : 'RBAC-Tests'
}

{ #category : #configuration }
RBACUserTest >> classToTest [
	^ RBACUser
]

{ #category : #configuration }
RBACUserTest >> profile1 [
	^ self users first
]

{ #category : #'unit tests' }
RBACUserTest >> testAdditionToAndRemotionFromGroup [
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
]

{ #category : #'unit tests' }
RBACUserTest >> testPermissionsInheritanceFromGroups [
	"Test the addition of roles to the user."

	| profile group1 group2 permission target |
	profile := self profile1.
	profile addRole: (self simpleRoles at: 1).
	profile addRole: (self compositeRoles at: 1).
	(self compositeRoles at: 1) addRole: (self simpleRoles at: 2).
	group1 := self groups at: 1.
	group2 := self groups at: 2.
	target := (RBACNamedModel new).
	group1 addMember: profile.
	group2 addMember: profile.
	group1 addRole: (self simpleRoles at: 3).
	group2 addRole: (self simpleRoles at: 4).
	permission := RBACPermission target: target.
	permission
		allowsCreation: true;
		allowsUpdate: true.
	(self simpleRoles at: 1) addPermission: permission.
	permission := RBACPermission target: target.
	permission allowsDeletion: true.
	(self simpleRoles at: 3) addPermission: permission.
	permission := RBACPermission target: target.
	permission allowsRead: true.
	(self simpleRoles at: 4) addPermission: permission.
	self assert: (profile canCreate: target).
	self assert: (profile canRead: target).
	self assert: (profile canUpdate: target).
	self assert: (profile canDelete: target)
]

{ #category : #'unit tests' }
RBACUserTest >> testPreferences [
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
]
