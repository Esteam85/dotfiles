package cmd

import (
	"fmt"
	"os/exec"
)

func installInitShellFiles(dotfilesPath string) error {
	fmt.Println("💪 Installing Init Shell files")
	err := exec.Command("sh", fmt.Sprintf("%s/shell/init.sh", dotfilesPath)).Run()
	if err != nil {
		fmt.Printf("💔 Error installing Init Shell files: %v\n", err)
		return err
	}
	fmt.Println("✅ Init Shell files installed successfully!")
	return nil
}
