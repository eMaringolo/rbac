Class {
	#name : #BaselineOfRBAC,
	#superclass : #BaselineOf,
	#category : #BaselineOfRBAC
}

{ #category : #baselines }
BaselineOfRBAC >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ self setUpDependencies: spec.
			spec
				package: 'RBAC-Core' ;
				package: 'RBAC-Tests' with: [ spec requires: #('RBAC-Core') ];
				package: 'RBAC-Glorp' with: [ spec requires: #('RBAC-Core' 'PBKDF2') ];
				package: 'RBAC-Glorp-Tests' with: [ spec requires: #('RBAC-Tests' 'RBAC-Glorp') ];
				package: 'RBAC-Seaside' with: [ spec requires: #('RBAC-Core') ].
			spec
				group: 'default' with: #('core' 'tests');
				group: 'core' with: #('RBAC-Core');
				group: 'tests' with: #('RBAC-Tests');
				group: 'glorp' with: #('RBAC-Glorp');
				group: 'seaside' with: #('core' 'Seaside3') ]
]

{ #category : #baselines }
BaselineOfRBAC >> setUpDependencies: spec [
	spec
		baseline: 'Grease'
			with: [ spec
				loads: #('Grease-Core');
				repository: 'github://SeasideSt/Grease:v1.4.x/repository' ];
		baseline: 'Cryptography'
			with: [ spec
				loads: #('PBKDF2');
				repository: 'github://pharo-contributions/Cryptography/source' ];
		baseline: 'Seaside3'
			with: [ spec
				loads: #('default');
				repository: 'github://SeasideSt/Seaside:master/repository' ];
		baseline: 'Glorp'
			with: [ spec repository: 'github://pharo-rdbms/glorp' ]
]
