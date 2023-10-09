package snipeit

type SnipeItError struct {
	StatusCode int
	Err        error
}

func (e *SnipeItError) Error() string {
	return e.Err.Error() // TODO: add status code
}

func newSnipeItError(statusCode int, err error) *SnipeItError {
	return &SnipeItError{
		StatusCode: statusCode,
		Err:        err,
	}
}
