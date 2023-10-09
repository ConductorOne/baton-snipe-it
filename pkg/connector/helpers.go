package connector

import "fmt"

func wrapError(err error, message string) error {
	return fmt.Errorf("snipe-it-connector: %s: %w", message, err)
}
