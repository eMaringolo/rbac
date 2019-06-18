Class {
	#name : #RBACError,
	#superclass : #GRError,
	#category : 'RBAC-Core'
}

{ #category : #'as yet unclassified' }
RBACError class >> signalWith: signaler [
	
	^self new
		signaler: signaler;
		signal
]

{ #category : #testing }
RBACError >> isResumable [
	^ true
]

{ #category : #accessing }
RBACError >> signaler [
]

{ #category : #accessing }
RBACError >> signaler: anObject [
]
