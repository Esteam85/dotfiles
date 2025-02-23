package steps

import (
	"fmt"
	"os/exec"
)

func ConfigureExtensionsDefaults(dotfilesPath string) error {
	scriptPath := dotfilesPath + "/mac/duti/default-app-extensions.sh"
	err := exec.Command("sh", scriptPath).Run()
	if err != nil {
		return fmt.Errorf("🛑 Error configuring extensions defaults apps: %s", err)

	}
	return nil
}
