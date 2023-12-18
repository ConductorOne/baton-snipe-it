package snipeit

import "fmt"

type SnipeItError struct {
	StatusCode int
	Err        error
}

func (e *SnipeItError) Error() string {
	return fmt.Sprintf("Snipe-IT API error: %s with statusCode: %d", e.Err.Error(), e.StatusCode)
}

func newSnipeItError(statusCode int, err error) *SnipeItError {
	return &SnipeItError{
		StatusCode: statusCode,
		Err:        err,
	}
}
