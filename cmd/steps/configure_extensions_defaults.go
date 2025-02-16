package steps

import (
	"fmt"
	"os/exec"
)

func ConfigureExtensionsDefaults(dotfilesPath string) error {
	scriptPath := dotfilesPath + "/mac/duti/default-app-extensions.sh"
	fmt.Println("💪 Config extensions defaults apps")
	err := exec.Command("sh", scriptPath).Run()
	if err != nil {
		fmt.Println("🛑 Error configuring extensions defaults apps:", err)
		return err
	}

	fmt.Println("✅ Config extensions defaults apps configured successfully!")
	return nil
}
