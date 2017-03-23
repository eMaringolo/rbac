uncategorized
testEvaluationByUser
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