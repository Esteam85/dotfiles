package steps

import (
	"fmt"
	"os/exec"
	"strings"
)

func DownloadGitSubmodules(dotfilesPath string) error {
	fmt.Println("💪 Checking git submodules status in .dotfiles!")
	output, err := exec.Command("git", "-C", dotfilesPath, "submodule", "status").CombinedOutput()
	if err != nil {
		fmt.Println("❌ Error checking submodule status:", err.Error())
		return err
	}

	if strings.TrimSpace(string(output)) != "" {
		fmt.Println("✅ Submodules already initialized.")
	} else {
		fmt.Println("💪 Initializing and updating git submodules in .dotfiles!")
		err = exec.Command("git", "-C", dotfilesPath, "submodule", "init").Run()
		if err != nil {
			fmt.Println("❌ Downloading git submodules in .dotfiles fails:", err.Error())
			return err
		}
		fmt.Println("✅ git submodules in .dotfiles downloaded successfully!")
		return nil
	}

	err = exec.Command("git", "-C", dotfilesPath, "submodule", "update").Run()
	if err != nil {
		fmt.Println("❌ Updating git submodules in .dotfiles fails:", err.Error())
		return err
	}
	fmt.Println("✅ git submodules in .dotfiles updated successfully!")
	return nil
}
