package cmd

import (
	"fmt"
	"os/exec"
)

func createSymlinks(dotfilesPath string) error {
	fmt.Println("💪 Creating symlinks")
	err := exec.Command("sh", fmt.Sprintf("%s/symlinks/links.sh", dotfilesPath)).Run()
	if err != nil {
		fmt.Println("❌ Failed to create symlinks", err)
		return nil
	}
	fmt.Println("✅ Symlinks created successfully!")
	return nil
}
