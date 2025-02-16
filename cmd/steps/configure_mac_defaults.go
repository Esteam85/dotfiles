package steps

import (
	"fmt"
	"os/exec"
)

func ConfigureMacDefaults(dotfilesPath string) error {
	scriptPath := dotfilesPath + "/mac/mac-os.sh"
	fmt.Println("💪 Config Mac defaults")
	err := exec.Command("sh", scriptPath).Run()
	if err != nil {
		fmt.Println("🛑 Error configuring Mac defaults:", err)
		return err
	}
	fmt.Println("✅ Mac defaults configured successfully!")
	return nil
}
