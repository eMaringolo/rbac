uncategorized
testAllSubrolesDo
	"Test the allSubrolesBreadthFirstDo: method."

	| result |
	result := false.
	(self simpleRoles at: 2) allSubrolesDo: [ :each | result := true ].
	self deny: result.
	result := 0.
	(self simpleRoles at: 1) allSubrolesDo: [ :each | result := result + 2 ].
	self assert: result = 0