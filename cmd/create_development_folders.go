package cmd

import (
	"fmt"
	"os"
)

func createDevelopmentFolders() {
	home := os.Getenv("HOME")
	folders := []string{
		home + "/Development",
		home + "/go",
		home + "/.kube",
		home + "/.aws",
	}

	fmt.Printf("💪 Making Folder for Development: %v\n", folders)
	for _, folder := range folders {
		if _, err := os.Stat(folder); !os.IsNotExist(err) {
			fmt.Println("👍 Folders already exist.")
			return
		}
	}
	for _, folder := range folders {
		err := os.MkdirAll(folder, os.ModePerm)
		if err != nil {
			fmt.Println("🛑 Error making folders:", err)
			return
		}
	}

	fmt.Printf("✅ Development folders created successfully in %s!\n", home)
}
