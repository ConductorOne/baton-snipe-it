package snipeit

import (
	"encoding/json"
	"strconv"
)

type Permission string

type Permissions map[string]Permission

func (p *Permission) UnmarshalJSON(b []byte) error {
	val := &json.RawMessage{}
	err := json.Unmarshal(b, val)
	if err != nil {
		return err
	}

	var ret string
	err = json.Unmarshal(*val, &ret)
	if err != nil {
		// unable to marshal as string, try as int
		var i int
		err = json.Unmarshal(*val, &i)
		if err != nil {
			return err
		}
		ret = strconv.Itoa(i)
	}

	*p = Permission(ret)

	return nil
}

var (
	Granted   Permission = "1"
	Denied    Permission = "-1"
	Inherited Permission = "0"
)
