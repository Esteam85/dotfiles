package steps

import (
	"fmt"
	"os/exec"
)

func ConfigureMacDefaults(dotfilesPath string) error {
	scriptPath := dotfilesPath + "/mac/mac-os.sh"
	err := exec.Command("sh", scriptPath).Run()
	if err != nil {
		return fmt.Errorf("🛑 Error configuring Mac defaults: %s", err)

	}
	return nil
}
