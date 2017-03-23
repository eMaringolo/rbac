behaviors
behaviorAt: aByteString 
	
	^self behaviorAt: aByteString ifAbsent:[NotFound signalFor: aByteString]