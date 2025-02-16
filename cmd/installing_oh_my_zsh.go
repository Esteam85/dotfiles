package cmd

import (
	"fmt"
	"os"
	"os/exec"
)

func installingOhMyZSH() {
	fmt.Println("💪 Installing Oh-My-Zsh")
	zshPath, exists := os.LookupEnv("ZSH")

	if exists && zshPath != "" {
		fmt.Println("✅ Oh My Zsh is already installed at:", zshPath)
		return
	}
	fmt.Println("🚀 Oh My Zsh is not installed. Proceeding with installation...")
	err := exec.Command("sh", "-c", "curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh").Run()
	if err != nil {
		fmt.Println("❌ Oh-My-Zsh Installation fails", err.Error())
		return
	}
	fmt.Println("✅ Oh-My-Zsh installed successfully!")
}
