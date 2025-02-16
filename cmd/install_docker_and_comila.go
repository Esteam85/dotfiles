package cmd

import (
	"fmt"
	"os"
	"os/exec"
)

func isDockerInstalled() bool {
	cmd := exec.Command("docker", "--version")
	err := cmd.Run()
	return err == nil
}

func isColimaInstalled() bool {
	cmd := exec.Command("colima", "--version")
	err := cmd.Run()
	return err == nil
}

func installDockerAndColima(dotfilesPath string) error {

	if isDockerInstalled() && isColimaInstalled() {
		fmt.Println("👍 Docker and Colima is already installed.")
		return nil
	}

	scriptPath := dotfilesPath + "/mac/docker/install-docker-colima.sh"
	fmt.Println("💪 Installing Docker and Colima for M1")

	cmd := exec.Command("sh", scriptPath)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	err := cmd.Run()
	if err != nil {
		fmt.Println("🛑 Error installing Docker and Colima:", err)
		return err
	}
	fmt.Println("✅ Docker and Colima installed successfully!")
	return nil
}
