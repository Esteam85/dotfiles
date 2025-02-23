package steps

import (
	"fmt"
	"os/exec"
)

func UpdateDotfilesRepository(dotfilesPath string) error {
	err := exec.Command("git", "-C", dotfilesPath, "pull", "origin", "main").Run()
	if err != nil {
		return fmt.Errorf(fmt.Sprintf("❌ Dotfiles Repository Updated fails: %s", err.Error()))
	}
	return nil
}
