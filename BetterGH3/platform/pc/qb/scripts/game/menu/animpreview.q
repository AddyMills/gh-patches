
script ReloadAnimation 
	AllowAssetLoading \{on}
	UpdateAnimCache \{Clear}
	PushAssetContext
	ReloadAnim filename = <filename> Anim = <AnimName>
	PopAssetContext
	AllowAssetLoading \{off}
endscript
