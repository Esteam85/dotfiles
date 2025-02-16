package cmd

import (
	"fmt"
	"os"
	"os/exec"
)

func installBrewBundle(dotfilesPath string) error {
	fmt.Println("💪 Installing bundle from Brewfile!")
	fmt.Println(fmt.Sprintf("--file=%s/mac/brew/Brewfile", dotfilesPath))
	cmd := exec.Command("brew", "bundle", fmt.Sprintf("--file=%s/mac/brew/Brewfile", dotfilesPath), "--force")
	cmd.Stderr = os.Stderr
	cmd.Stdout = os.Stdout
	err := cmd.Run()
	if err != nil {
		fmt.Printf("💔 Error installing Homebrew bundle: %v\n", err)
		return err
	}
	fmt.Println("✅ Homebrew Bundle installed successfully!")
	return nil
}
