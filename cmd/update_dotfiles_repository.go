package cmd

import (
	"fmt"
	"os/exec"
)

func updateDotfilesRepository(dotfilesPath string) error {
	fmt.Println("🆙 Updating Dotfiles Repository")
	err := exec.Command("git", "-C", dotfilesPath, "pull", "origin", "main").Run()
	if err != nil {
		fmt.Println("❌ Dotfiles Repository Updated fails", err.Error())
		return err
	}
	fmt.Println("✅ Dotfiles Repository Updated successfully!")
	return nil
}
