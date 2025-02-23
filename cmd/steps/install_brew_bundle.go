package steps

import (
	"fmt"
	"os"
	"os/exec"
)

func InstallBrewBundle(dotfilesPath string) error {
	cmd := exec.Command("brew", "bundle", fmt.Sprintf("--file=%s/mac/brew/Brewfile", dotfilesPath), "--force")
	cmd.Stderr = os.Stderr
	cmd.Stdout = os.Stdout
	fmt.Println("")
	err := cmd.Run()
	if err != nil {
		return fmt.Errorf("💔 Error installing Homebrew bundle: %v\n", err)
	}
	return nil
}
