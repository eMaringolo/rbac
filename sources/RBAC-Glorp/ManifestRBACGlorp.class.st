"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestRBACGlorp,
	#superclass : #PackageManifest,
	#category : #'RBAC-Glorp-Manifest'
}

{ #category : #'code-critics' }
ManifestRBACGlorp class >> ruleRBBadMessageRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#TRBACDescriptionSystem #schemaStatementsFor: #false)) #'2019-07-20T16:51:53.265012-03:00') )
]

{ #category : #'code-critics' }
ManifestRBACGlorp class >> ruleRBCollectionProtocolRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#TRBACDescriptionSystem #schemaStatementsFor: #false)) #'2019-07-20T16:51:49.480609-03:00') )
]

{ #category : #'code-critics' }
ManifestRBACGlorp class >> ruleRBLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#TRBACDescriptionSystem #schemaStatementsFor: #false)) #'2019-07-20T16:51:56.134652-03:00') )
]
