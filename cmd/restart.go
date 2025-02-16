package cmd

import (
	"fmt"
	"github.com/manifoldco/promptui"
	"os/exec"
	"time"
)

const SecondsWaitTimeout = 10 * time.Second
const Yes = "Yes"
const No = "No"

func promptRestart() {
	prompt := promptui.Select{
		Label: "⚠️ Restart is needed, do you wish to restart?",
		Items: []string{Yes, No},
	}

	resultChan := make(chan string, 1)
	go func() {
		_, result, err := prompt.Run()
		if err != nil {
			fmt.Println("🛑 Error reading input:", err)
			resultChan <- No
		} else {
			resultChan <- result
		}
	}()

	select {
	case result := <-resultChan:
		if result == Yes {
			cmd := exec.Command("sudo", "shutdown", "-r", "now")
			err := cmd.Run()
			if err != nil {
				fmt.Println("🛑 Error restarting:", err)
			} else {
				fmt.Println("💫 Restarting...")
			}
		} else {
			fmt.Println("👏🥳 Installation finished👀 without restarting⚠️")
		}
	case <-time.After(SecondsWaitTimeout):
		fmt.Println("\n🛑 Timeout reached, no input received.")
		fmt.Println("👏🥳 Installation finished👀 without restarting⚠️")
	}
}
