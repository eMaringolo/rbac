behaviors
hasBehavior: aRBACUserBehaviorClass 

	^self behaviors anySatisfy: [ :each | each class = aRBACUserBehaviorClass ]