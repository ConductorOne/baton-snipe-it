package connector

import "fmt"

func wrapError(err error, message string) error {
	return fmt.Errorf("snipe-it-connector: %s: %w", message, err)
}

func Map[T, V any](ts []T, fn func(T) V) []V {
	result := make([]V, len(ts))
	for i, t := range ts {
		result[i] = fn(t)
	}
	return result
}

func contains(array []string, value string) bool {
	for _, v := range array {
		if v == value {
			return true
		}
	}
	return false
}
