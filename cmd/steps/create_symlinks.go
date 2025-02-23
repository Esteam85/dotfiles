package steps

import (
	"fmt"
	"os/exec"
)

func CreateSymlinks(dotfilesPath string) error {
	err := exec.Command("sh", fmt.Sprintf("%s/symlinks/links.sh", dotfilesPath)).Run()
	if err != nil {
		return fmt.Errorf("❌ Failed to create symlinks: %s", err)
	}
	return nil
}
