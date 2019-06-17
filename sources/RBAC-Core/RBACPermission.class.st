"
I represent a permission belonging to a role, defined for a target object.

The target of receiver can be a Class or any other object based on the business rules where I am used.

Among my different grants or denials I have the four CRUD operations and an Execution to secure the execution of target.

To be more compact I store the different grants as a single byte, each bit position represents a particular grant, from less significative bit, to more significative bit.
- Creation: 1st bit
- Read: 2nd bit
- Update: 3rd  bit
- Deletion: 4th bit
- Execution: 5th bit.

So for a Permission of Creation and Read, but not deletion, the bits would be 2r00011.



"
Class {
	#name : 'RBACPermission',
	#superclass : 'RBACObject',
	#instVars : [
		'target',
		'bits',
		'role'
	],
	#vw_namespace : 'Root',
	#category : 'RBAC-Core'
}

{ #category : 'uncategorized' }
RBACPermission class >> from: anRBACPermission [

	^(self new)
		target: anRBACPermission target;
		owner: anRBACPermission owner;
		setBits: anRBACPermission bits
]

{ #category : 'uncategorized' }
RBACPermission class >> role: aRBACRole target: anObject [ 

	^self new
		role: aRBACRole;
		target: anObject;
		yourself
]

{ #category : 'uncategorized' }
RBACPermission class >> target: anObject [
	^ self new
		target: anObject;
		yourself
]

{ #category : 'operations' }
RBACPermission >> allowAll [

	bits := 2r11111111
]

{ #category : 'accessing' }
RBACPermission >> allowsCreation [

	^(bits bitAnd: 1) ~= 0
]

{ #category : 'accessing' }
RBACPermission >> allowsCreation: aBoolean [
	bits := bits bitAt: 1 put: (aBoolean ifTrue: [1] ifFalse: [0])
]

{ #category : 'accessing' }
RBACPermission >> allowsDeletion [

	^(bits bitAnd: 2r1000) ~= 0
]

{ #category : 'accessing' }
RBACPermission >> allowsDeletion: aBoolean [
	bits := bits bitAt: 4 put: (aBoolean ifTrue: [1] ifFalse: [0])
]

{ #category : 'accessing' }
RBACPermission >> allowsExecution [
	^(bits bitAnd: 2r10000) ~= 0
]

{ #category : 'accessing' }
RBACPermission >> allowsExecution: aBoolean [
	bits := bits bitAt: 5 put: (aBoolean ifTrue: [1] ifFalse: [0])
]

{ #category : 'accessing' }
RBACPermission >> allowsRead [
	^ (bits bitAnd: 2r10) ~= 0
]

{ #category : 'accessing' }
RBACPermission >> allowsRead: aBoolean [
	bits := bits bitAt: 2 put: (aBoolean ifTrue: [1] ifFalse: [0])
]

{ #category : 'accessing' }
RBACPermission >> allowsUpdate [
	^ (bits bitAnd: 2r100) ~= 0
]

{ #category : 'accessing' }
RBACPermission >> allowsUpdate: aBoolean [
	bits := bits bitAt: 3 put: (aBoolean ifTrue: [1] ifFalse: [0])
]

{ #category : 'convenience' }
RBACPermission >> asTransient [
	"Answer the receiver as a transient instance."
	
	^RBACTransientPermission from: self
]

{ #category : 'accessing' }
RBACPermission >> bits [

	^bits
]

{ #category : 'private' }
RBACPermission >> bits: anInteger [

	bits := anInteger
]

{ #category : 'querying' }
RBACPermission >> canCreate [
	^ self canCreate: target
]

{ #category : 'querying' }
RBACPermission >> canCreate: class [
	^ self allowsCreation and: [ self notExpired ]
]

{ #category : 'querying' }
RBACPermission >> canDelete [
	^ self canDelete: target
]

{ #category : 'querying' }
RBACPermission >> canDelete: class [
	^ self allowsDeletion and: [ self notExpired ]
]

{ #category : 'querying' }
RBACPermission >> canRead [
	^ self canRead: target
]

{ #category : 'querying' }
RBACPermission >> canRead: class [
	^ self allowsRead and: [ self notExpired ]
]

{ #category : 'querying' }
RBACPermission >> canUpdate [
	^ self canUpdate: target
]

{ #category : 'querying' }
RBACPermission >> canUpdate: class [
	^ self allowsUpdate and: [ self notExpired ]
]

{ #category : 'operations' }
RBACPermission >> denyAll [
	bits := 0
]

{ #category : 'private' }
RBACPermission >> initialize [
	"Private - Initializes receiver."
	
	super initialize.
	bits := 0.
	self denyAll
]

{ #category : 'testing' }
RBACPermission >> isCRUD [
	^ self isExecution not
]

{ #category : 'testing' }
RBACPermission >> isDenyAll [
	
	^self bits = 0
]

{ #category : 'testing' }
RBACPermission >> isExecution [

	^self target isOperation
]

{ #category : 'testing' }
RBACPermission >> isExpired [
	^ false
]

{ #category : 'testing' }
RBACPermission >> isTransient [
	
	^false
]

{ #category : 'operations' }
RBACPermission >> mergeFrom: aRBACPermission [ 
	bits := self bits bitOr: aRBACPermission bits
]

{ #category : 'testing' }
RBACPermission >> notExpired [
	
	^true
]

{ #category : 'accessing' }
RBACPermission >> owner [
	^ self role
]

{ #category : 'accessing' }
RBACPermission >> owner: anObject [ 

	self role: anObject
]

{ #category : 'operations' }
RBACPermission >> permissionOr: permission [
	^ self asTransient setBits: (self bits bitOr: permission bits)
]

{ #category : 'printing' }
RBACPermission >> printOn: aStream [
	"Prints the receiver on aStream."

	aStream nextPut: ${.
	aStream
		nextPut:
			(self allowsCreation
				ifTrue: [ $C ]
				ifFalse: [ $- ]);
		nextPut:
			(self allowsRead
				ifTrue: [ $R ]
				ifFalse: [ $- ]);
		nextPut:
			(self allowsUpdate
				ifTrue: [ $U ]
				ifFalse: [ $- ]);
		nextPut:
			(self allowsDeletion
				ifTrue: [ $D ]
				ifFalse: [ $- ]);
		nextPut:
			(self allowsExecution
				ifTrue: [ $X ]
				ifFalse: [ $- ]);
		space;
		nextPutAll: self target printString;
		nextPut: $}
]

{ #category : 'convenience' }
RBACPermission >> role [

	^role
]

{ #category : 'convenience' }
RBACPermission >> role: newRole [
	role := newRole
]

{ #category : 'private' }
RBACPermission >> setBits: integerBits [
	bits := integerBits
]

{ #category : 'accessing' }
RBACPermission >> target [

	^target
]

{ #category : 'accessing' }
RBACPermission >> target: anObject [ 

	target := anObject
]
