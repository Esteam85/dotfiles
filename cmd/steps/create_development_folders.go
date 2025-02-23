package steps

import (
	"os"
)

func CreateDevelopmentFolders() error {
	home := os.Getenv("HOME")
	folders := []string{
		home + "/Development",
		home + "/go",
		home + "/.kube",
		home + "/.aws",
	}
	for _, folder := range folders {
		if _, err := os.Stat(folder); !os.IsNotExist(err) {
			return nil
		}
	}
	for _, folder := range folders {
		err := os.MkdirAll(folder, os.ModePerm)
		if err != nil {
			return nil
		}
	}
	return nil
}
