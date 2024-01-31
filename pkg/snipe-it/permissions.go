package snipeit

type (
	Permission int64

	Permissions map[string]Permission
)

var (
	Granted   Permission = 1
	Denied    Permission = -1
	Inherited Permission = 0
)
