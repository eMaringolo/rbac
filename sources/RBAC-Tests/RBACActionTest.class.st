"

"
Class {
	#name : 'RBACActionTest',
	#superclass : 'RBACTest',
	#vw_namespace : 'Root',
	#category : 'RBAC-Tests'
}

{ #category : 'uncategorized' }
RBACActionTest >> setUp [
	super setUp.
	self setupProfile
]

{ #category : 'uncategorized' }
RBACActionTest >> setupProfile [
	| profile permA permB permC targetA targetB |
	targetA := self operations at: 1.
	targetB := self operations at: 2.
	profile := self users at: 1.
	profile addRole: (self simpleRoles at: 1).
	permA := RBACPermission target: targetA.
	permA
		allowsCreation: true;
		allowsUpdate: true;
		allowsExecution: true.
	permB := RBACPermission target: targetB.
	permB
		allowsDeletion: true;
		allowsRead: true.
	permC := RBACPermission target: (self operations at: 1).
	permC allowsExecution: true.
	(self simpleRoles at: 1)
		addPermission: permA;
		addPermission: permB;
		addPermission: permC
]

{ #category : 'uncategorized' }
RBACActionTest >> testEvaluationByUser [
	"Test the addition of roles to the user."

	| profile target1 menuB |
	target1 := self operations at: 1.
	menuB := self operations at: 2.
	profile := self users at: 1.
	self assert: ((RBACCreation of: target1) canBeDoneBy: profile).
	self assert: ((RBACUpdate of: target1) canBeDoneBy: profile).
	self assert: ((RBACDeletion of: menuB) canBeDoneBy: profile).
	self assert: ((RBACRead of: menuB) canBeDoneBy: profile).
	self assert: ((RBACExecution of: (self operations at: 1)) canBeDoneBy: profile).
	self deny: ((RBACCreation of: menuB) canBeDoneBy: profile).
	self deny: ((RBACUpdate of: menuB) canBeDoneBy: profile).
	self deny: ((RBACDeletion of: target1) canBeDoneBy: profile).
	self deny: ((RBACRead of: target1) canBeDoneBy: profile).
	self deny: ((RBACExecution of: (self operations at: 2)) canBeDoneBy: profile)
]
