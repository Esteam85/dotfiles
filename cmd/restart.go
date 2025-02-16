package cmd

import (
	"fmt"
	"github.com/manifoldco/promptui"
	"os/exec"
	"time"
)

const (
	SecondsWaitTimeout = 10 * time.Second
	Yes                = "Yes"
	No                 = "No"
	CountDown          = 5
)

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
		close(resultChan)
	}()

	select {
	case result := <-resultChan:
		HandleRestart(result)
	case <-time.After(SecondsWaitTimeout):
		fmt.Println("\n🛑 Timeout reached, no input received.")
		fmt.Println("👏🥳 Installation finished 👀 without restarting⚠️")
	}
}

func HandleRestart(result string) {
	if result == No {
		fmt.Println("👏🥳 Installation finished 👀 without restarting⚠️")
		return
	}

	countDownEmojis := map[int]string{
		5: "😱",
		4: "🤷‍♂️",
		3: "👀",
		2: "😎",
		1: "🗿",
	}

	fmt.Println("💫 Restarting...")
	for i := CountDown; i > 0; i-- {
		fmt.Println(fmt.Sprintf("%d...%s", i, countDownEmojis[i]))
		time.Sleep(1 * time.Second) // Wait for 1 second
	}
	fmt.Println("Go!")
	cmd := exec.Command("sudo", "reboot")
	err := cmd.Run()
	if err != nil {
		fmt.Println("🛑 Error restarting:", err)
		return
	}
}
