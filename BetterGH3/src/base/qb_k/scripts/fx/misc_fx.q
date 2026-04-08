jowBlue = 717488127
jowGreen = 771697407
jowOrange = -6149377
jowRed = -15061505
jowYellow = -3267073

script JOW_Stars 
	printf \{"*******************************************************************"}
	printf <...>
	printf \{"*******************************************************************"}
endscript

script SafeGetUniqueCompositeObjectID \{PreferredId = safeFXID01}
	if NOT GotParam \{ObjID}
		GetUniqueCompositeObjectID PreferredId = <PreferredId>
		return UniqueId = <UniqueId>
	endif
	i = 0
	FormatText textname = index '%i' i = <i>
	ExtendCRC <PreferredId> <index> out = PreferredId
	begin
	MangleChecksums a = <PreferredId> b = <ObjID>
	if NOT ObjectExists id = <mangled_ID>
		return UniqueId = <PreferredId>
	else
		i = (<i> + 1)
		FormatText textname = index '%i' i = <i>
		ExtendCRC <PreferredId> <index> out = PreferredId
	endif
	repeat
endscript
