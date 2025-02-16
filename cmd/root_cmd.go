package cmd

import (
	"fmt"
	"github.com/spf13/cobra"
	"os"
	"os/exec"
)

var rootCmd = &cobra.Command{
	Use:   "dotfiles",
	Short: "Esteam dotfiles installation tool",
	Long:  "Esteam dotfiles installation tool",
	RunE: func(cmd *cobra.Command, _ []string) error {
		fmt.Println("Esteam dotfiles installation tool")
		dotfilesPath, err := getDotfilesPath()
		if err != nil {
			return err
		}
		err = updateDotfilesRepository(dotfilesPath)
		if err != nil {
			return err
		}
		installingOhMyZSH()
		err = downloadGitSubmodules(dotfilesPath)
		if err != nil {
			return err
		}

		err = installInitShellFiles(dotfilesPath)
		if err != nil {
			return err
		}

		/*err = installBrewBundle(dotfilesPath)
		if err != nil {
			return err
		}*/

		err = createSymlinks(dotfilesPath)
		if err != nil {
			return err
		}

		createDevelopmentFolders()
		err = configureMacDefaults(dotfilesPath)
		if err != nil {
			return err
		}

		err = configureExtensionsDefaults(dotfilesPath)
		if err != nil {
			return err
		}

		err = installDockerAndColima(dotfilesPath)
		if err != nil {
			return err
		}

		promptRestart()
		return nil
	},
}

func configureMacDefaults(dotfilesPath string) error {
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

func configureExtensionsDefaults(dotfilesPath string) error {
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

func getDotfilesPath() (string, error) {
	homeDir, err := os.UserHomeDir()
	if err != nil {
		fmt.Println("❌ Failed to get home directory:", err)
		return "", err
	}
	dotfilesPath := homeDir + "/.dotfiles"
	return dotfilesPath, nil
}

func Execute() {
	if err := rootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

}
