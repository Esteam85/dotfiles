package steps

import (
	"errors"
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

var ErrDockerAndColimaAlreadyInstalled = errors.New("docker and colima already installed")

func InstallDockerAndColima(dotfilesPath string) error {
	if isDockerInstalled() && isColimaInstalled() {
		return ErrDockerAndColimaAlreadyInstalled
	}
	scriptPath := dotfilesPath + "/mac/docker/install-docker-colima.sh"
	cmd := exec.Command("sh", scriptPath)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	err := cmd.Run()
	if err != nil {
		return fmt.Errorf("🛑 Error installing Docker and Colima: %s", err)
	}
	return nil
}
