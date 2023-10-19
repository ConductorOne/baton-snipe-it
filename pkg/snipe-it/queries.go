package snipeit

import (
	"fmt"
	"net/http"
)

type (
	queryParam struct {
		name  string
		value string
	}

	queryFunction func() queryParam
)

func WithGroupId(groupID int) queryFunction {
	return func() queryParam {
		return queryParam{
			name:  "group_id",
			value: fmt.Sprint(groupID),
		}
	}
}

func WithOffset(offset int) queryFunction {
	return func() queryParam {
		return queryParam{
			name:  "offset",
			value: fmt.Sprint(offset),
		}
	}
}

func WithLimit(limit int) queryFunction {
	return func() queryParam {
		return queryParam{
			name:  "limit",
			value: fmt.Sprint(limit),
		}
	}
}

func addQueryParams(req *http.Request, queries ...queryFunction) *http.Request {
	q := req.URL.Query()
	for _, query := range queries {
		param := query()
		q.Add(param.name, param.value)
	}
	req.URL.RawQuery = q.Encode()

	return req
}
