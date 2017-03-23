behaviors
behaviorOfClass: aRBACUserBehaviorClass 

	^self behaviors detect: [:one | one class= aRBACUserBehaviorClass ] ifNone: [NotFound signalFor:  aRBACUserBehaviorClass]