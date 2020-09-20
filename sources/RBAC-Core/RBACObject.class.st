"
I'm the common superclass of all RBAC classes, I provide an id for persistence.

"
Class {
	#name : #RBACObject,
	#superclass : #GRObject,
	#instVars : [
		'id',
		'creationTs',
		'modificationTs'
	],
	#category : #'RBAC-Core'
}

{ #category : #accessing }
RBACObject class >> computeRandomId [
	^UUID new asString36
]

{ #category : #accessing }
RBACObject >> creationTs [

	^creationTs
]

{ #category : #accessing }
RBACObject >> creationTs: anObject [

	creationTs := anObject
]

{ #category : #accessing }
RBACObject >> id [

	^id ifNil: [ id := self class computeRandomId ]
]

{ #category : #accessing }
RBACObject >> id: anObject [

	id := anObject
]

{ #category : #accessing }
RBACObject >> modificationTs [

	^modificationTs
]

{ #category : #accessing }
RBACObject >> modificationTs: anObject [

	modificationTs := anObject
]
