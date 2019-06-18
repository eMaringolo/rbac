Class {
	#name : #RBACGroupTest,
	#superclass : #RBACProfileTest,
	#category : 'RBAC-Tests'
}

{ #category : #configuration }
RBACGroupTest >> classToTest [
	^ RBACGroup
]

{ #category : #configuration }
RBACGroupTest >> sampleGroup [
	^ self groups first
]

{ #category : #'unit tests' }
RBACGroupTest >> testAdditionRemotionAndInclusionOfMembers [
	"Test addMember: , removeAllMembers , removeMember: and includesMember: methods."

	self sampleGroup initializeMembers.
	self deny: (self sampleGroup includesMember: (self users at: 1)).
	self deny: (self sampleGroup includesMember: (self users at: 2)).
	self sampleGroup addMember: (self users at: 1).
	self assert: (self sampleGroup includesMember: (self users at: 1)).
	self deny: (self sampleGroup includesMember: (self users at: 2)).
	self sampleGroup addMember: (self users at: 2).
	self assert: (self sampleGroup includesMember: (self users at: 1)).
	self assert: (self sampleGroup includesMember: (self users at: 2)).
	self sampleGroup removeMember: (self users at: 1).
	self deny: (self sampleGroup includesMember: (self users at: 1)).
	self assert: (self sampleGroup includesMember: (self users at: 2)).
	self sampleGroup addMember: (self users at: 3).
	self assert: (self sampleGroup includesMember: (self users at: 3)).
	self sampleGroup removeAllMembers.
	self deny: (self sampleGroup includesMember: (self users at: 1)).
	self deny: (self sampleGroup includesMember: (self users at: 2)).
	self deny: (self sampleGroup includesMember: (self users at: 3))
]

{ #category : #'unit tests' }
RBACGroupTest >> testEquals [

	"Test the equals: method."

	

	self assert: self sampleGroup = self sampleGroup.

	self assert: (self groups at: 2) = (self groups at: 2).

	self assert: (self groups at: 3) = (self groups at: 3).

	self deny: (self groups at: 3) = (self groups at: 2).

	self deny: (self groups at: 2) = (self groups at: 3).	

	self deny: self sampleGroup = (self groups at: 2).

	self deny: self sampleGroup = (self users at: 2)
]

{ #category : #'unit tests' }
RBACGroupTest >> testMembers [
	self sampleGroup members: (Set with: (self users at: 1) with: (self users at: 2) with: (self users at: 3)).
	self
		assert: (self sampleGroup members difference: (OrderedCollection with: (self users at: 2) with: (self users at: 1) with: (self users at: 3))) isEmpty.
	self sampleGroup members: (Set with: (self users at: 2)).
	self assert: (self sampleGroup members difference: (Set with: (self users at: 2))) isEmpty.
	self sampleGroup initializeMembers.
	self assert: self sampleGroup members isEmpty
]
