uncategorized
comparePermission: perm with: comparandPerm
	^(perm target = comparandPerm target) & (perm bits = comparandPerm bits)