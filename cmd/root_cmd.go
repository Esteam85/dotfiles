package cmd

import (
	"fmt"
	"github.com/spf13/cobra"
	"os"
)

func getDotfilesPath() (string, error) {
	homeDir, err := os.UserHomeDir()
	if err != nil {
		fmt.Println("❌ Failed to get home directory:", err)
		return "", err
	}
	dotfilesPath := homeDir + "/.dotfiles"
	return dotfilesPath, nil
}

func getRootCommand(flagA bool) *cobra.Command {
	var rootCmd = &cobra.Command{
		Use:   "dotfiles",
		Short: "Esteam dotfiles installation tool",
		Long:  "Esteam dotfiles installation tool",
		RunE: func(cmd *cobra.Command, args []string) error {
			var fullInstallStepsConfig = &InstallStepsConfig{
				installBrewBundle: true,
			}
			installConfig := &InstallStepsConfig{
				installBrewBundle: false,
			}

			if flagA {
				installConfig = fullInstallStepsConfig
			}
			fmt.Println("🚀Esteam dotfiles installation tool")

			installStepsRunner, err := NewInstallStepBuilder(installConfig)
			if err != nil {
				return err
			}

			err = installStepsRunner.
				UpdateDotfilesRepository("🆙 Updating Dotfiles Repository").
				InstallingOhMyZSH("💪 Installing Oh-My-Zsh").
				DownloadGitSubmodules("💪 Checking git submodules status in .dotfiles!").
				InstallInitShellFiles("💪 Installing Init Shell files").
				InstallBrewBundle("💪 Installing bundle from Brewfile!").
				CreateSymlinks("💪 Creating symlinks").
				ConfigureMacDefaults("💪 Config Mac defaults").
				ConfigureExtensionsDefaults("💪 Config extensions defaults apps").
				CreateDevelopmentFolders("💪 Making Folder for Development").
				InstallDockerAndColima("💪 Installing Docker and Colima for M1").
				Error()
			if err != nil {
				return err
			}
			promptRestart()
			return nil
		},
	}
	return rootCmd
}

func Execute() {
	var flagA bool
	rootCmd := getRootCommand(flagA)

	rootCmd.Flags().BoolVarP(&flagA, "all", "a", false, "will try to Install all steps")
	if err := rootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

}
