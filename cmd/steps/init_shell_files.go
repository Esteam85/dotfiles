package steps

import (
	"fmt"
	"os/exec"
)

func InstallInitShellFiles(dotfilesPath string) error {
	err := exec.Command("sh", fmt.Sprintf("%s/shell/init.sh", dotfilesPath)).Run()
	if err != nil {
		return fmt.Errorf("💔 Error installing Init Shell files: %v\n", err)
	}
	return nil
}
