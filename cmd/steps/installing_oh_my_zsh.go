package steps

import (
	"fmt"
	"os"
	"os/exec"
)

var ErrOhMyZshAlreadyInstalled = fmt.Errorf("oh my zsh already installed")

func InstallingOhMyZSH() error {
	zshPath, exists := os.LookupEnv("ZSH")
	if exists && zshPath != "" {
		return ErrOhMyZshAlreadyInstalled
	}
	err := exec.Command("sh", "-c", "curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh").Run()
	if err != nil {
		return fmt.Errorf("❌ Oh-My-Zsh Installation fails: %s", err.Error())
	}
	return nil
}
