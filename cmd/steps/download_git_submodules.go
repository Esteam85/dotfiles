package steps

import (
	"fmt"
	"os/exec"
	"strings"
)

func DownloadGitSubmodules(dotfilesPath string) error {
	output, err := exec.Command("git", "-C", dotfilesPath, "submodule", "status").CombinedOutput()
	if err != nil {
		return fmt.Errorf("❌ Error checking submodule status: %s", err.Error())
	}
	if strings.TrimSpace(string(output)) == "" {
		err = exec.Command("git", "-C", dotfilesPath, "submodule", "init").Run()
		if err != nil {

			return fmt.Errorf("❌ Downloading git submodules in .dotfiles fails: %s", err.Error())
		}
		return nil
	}
	err = exec.Command("git", "-C", dotfilesPath, "submodule", "update").Run()
	if err != nil {
		return fmt.Errorf("❌ Updating git submodules in .dotfiles fails: %s", err.Error())
	}
	return nil
}
