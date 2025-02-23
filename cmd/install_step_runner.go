package cmd

import (
	"errors"
	"fmt"
	"github.com/esteam85/dotfiles/cmd/steps"
	"github.com/schollz/progressbar/v3"
	"sync"
	"time"
)

type InstallStepsConfig struct {
	installBrewBundle bool
}
type InstallStepsRunner struct {
	err          error
	config       *InstallStepsConfig
	dotfilesPath string
}

func NewInstallStepBuilder(config *InstallStepsConfig) (*InstallStepsRunner, error) {
	dotfilesPath, err := getDotfilesPath()
	if err != nil {
		return nil, err
	}
	return &InstallStepsRunner{
		config:       config,
		dotfilesPath: dotfilesPath,
	}, nil
}

func (i *InstallStepsRunner) UpdateDotfilesRepository(description string) *InstallStepsRunner {
	if i.err != nil {
		return i
	}
	processStep(description, &i.err, func() error {
		return steps.UpdateDotfilesRepository(i.dotfilesPath)
	})
	if i.err == nil {
		fmt.Println("👍")
	}
	return i
}

func (i *InstallStepsRunner) InstallingOhMyZSH(description string) *InstallStepsRunner {
	if i.err != nil {
		return i
	}
	processStep(description, &i.err, steps.InstallingOhMyZSH)
	if errors.Is(i.err, steps.ErrOhMyZshAlreadyInstalled) {
		i.err = nil
		fmt.Println("👀", steps.ErrOhMyZshAlreadyInstalled.Error())
	}

	return i
}
func (i *InstallStepsRunner) DownloadGitSubmodules(description string) *InstallStepsRunner {
	if i.err != nil {
		return i
	}
	processStep(description, &i.err, func() error {
		return steps.DownloadGitSubmodules(i.dotfilesPath)
	})
	if i.err == nil {
		fmt.Println("👍")
	}
	return i
}
func (i *InstallStepsRunner) InstallInitShellFiles(description string) *InstallStepsRunner {
	if i.err != nil {
		return i
	}
	processStep(description, &i.err, func() error {
		return steps.InstallInitShellFiles(i.dotfilesPath)
	})
	if i.err == nil {
		fmt.Println("👍")
	}
	return i
}

func (i *InstallStepsRunner) InstallBrewBundle(description string) *InstallStepsRunner {
	if i.err != nil || !i.config.installBrewBundle {
		return i
	}
	processStep(description, &i.err, func() error {
		return steps.InstallBrewBundle(i.dotfilesPath)
	})
	if i.err == nil {
		fmt.Println("👍")
	}
	return i
}

func (i *InstallStepsRunner) CreateSymlinks(description string) *InstallStepsRunner {
	if i.err != nil {
		return i
	}
	processStep(description, &i.err, func() error {
		return steps.CreateSymlinks(i.dotfilesPath)
	})
	if i.err == nil {
		fmt.Println("👍")
	}
	return i
}

func (i *InstallStepsRunner) CreateDevelopmentFolders(description string) *InstallStepsRunner {
	if i.err != nil {
		return i
	}
	processStep(description, &i.err, steps.CreateDevelopmentFolders)
	return i
}

func (i *InstallStepsRunner) ConfigureMacDefaults(description string) *InstallStepsRunner {
	if i.err != nil {
		return i
	}
	processStep(description, &i.err, func() error {
		return steps.ConfigureMacDefaults(i.dotfilesPath)
	})
	if i.err == nil {
		fmt.Println("👍")
	}
	return i
}
func (i *InstallStepsRunner) ConfigureExtensionsDefaults(description string) *InstallStepsRunner {
	if i.err != nil {
		return i
	}
	processStep(description, &i.err, func() error {
		return steps.ConfigureExtensionsDefaults(i.dotfilesPath)
	})
	if i.err == nil {
		fmt.Println("👍")
	}
	return i
}
func (i *InstallStepsRunner) InstallDockerAndColima(description string) *InstallStepsRunner {
	if i.err != nil {
		return i
	}
	processStep(description, &i.err, func() error {
		return steps.InstallDockerAndColima(i.dotfilesPath)
	})
	if errors.Is(i.err, steps.ErrDockerAndColimaAlreadyInstalled) {
		i.err = nil
		fmt.Println("👀", steps.ErrDockerAndColimaAlreadyInstalled.Error())
	}
	return i
}

func (i *InstallStepsRunner) Error() error {
	return i.err
}

func processStep(description string, err *error, step func() error) {
	bar := progressbar.NewOptions(100,
		progressbar.OptionSetDescription(description),
	)
	done := make(chan struct{})
	var wg sync.WaitGroup
	wg.Add(1)
	go func() {
		*err = step()
		close(done)
	}()
	go func(wg *sync.WaitGroup) {
		for {
			select {
			case <-done:
				_ = bar.Set(100)
				wg.Done()
				return
			default:
				_ = bar.Add(1)
				time.Sleep(40 * time.Millisecond)
			}
		}
	}(&wg)
	wg.Wait()
	return
}
