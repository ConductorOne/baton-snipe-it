package snipeit

type (
	Permission string

	Permissions map[string]Permission
)

var (
	Granted   Permission = "1"
	Denied    Permission = "-1"
	Inherited Permission = "0"
)
