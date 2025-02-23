package cmd

import (
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

func (i *InstallStepsRunner) UpdateDotfilesRepository() *InstallStepsRunner {
	if i.err != nil {
		return i
	}
	bar := progressbar.NewOptions(100,
		progressbar.OptionSetDescription("🆙 Updating Dotfiles Repository"),
	)
	done := make(chan struct{})
	var wg sync.WaitGroup
	wg.Add(1)
	go func() {
		i.err = steps.UpdateDotfilesRepository(i.dotfilesPath)
		close(done)
	}()
	go func(wg *sync.WaitGroup) {
		for {
			select {
			case <-done:
				_ = bar.Set(100)
				if i.err == nil {
					fmt.Println("👍")
				}
				wg.Done()
				return
			default:
				_ = bar.Add(1)
				time.Sleep(40 * time.Millisecond)
			}
		}
	}(&wg)
	wg.Wait()
	return i
}

func (i *InstallStepsRunner) InstallingOhMyZSH() *InstallStepsRunner {
	if i.err == nil {
		steps.InstallingOhMyZSH()
	}
	return i
}
func (i *InstallStepsRunner) DownloadGitSubmodules() *InstallStepsRunner {
	if i.err == nil {
		if err := steps.DownloadGitSubmodules(i.dotfilesPath); err != nil {
			i.err = err
		}
	}
	return i
}
func (i *InstallStepsRunner) InstallInitShellFiles() *InstallStepsRunner {
	if i.err == nil {
		if err := steps.InstallInitShellFiles(i.dotfilesPath); err != nil {
			i.err = err
		}
	}
	return i
}
func (i *InstallStepsRunner) InstallBrewBundle() *InstallStepsRunner {
	if i.err == nil && i.config.installBrewBundle {
		if err := steps.InstallBrewBundle(i.dotfilesPath); err != nil {
			i.err = err
		}
	}
	return i
}

func (i *InstallStepsRunner) CreateSymlinks() *InstallStepsRunner {
	if i.err == nil {
		if err := steps.CreateSymlinks(i.dotfilesPath); err != nil {
			i.err = err
		}
	}
	return i
}

func (i *InstallStepsRunner) CreateDevelopmentFolders() *InstallStepsRunner {
	if i.err == nil {
		steps.CreateDevelopmentFolders()
	}
	return i
}

func (i *InstallStepsRunner) ConfigureMacDefaults() *InstallStepsRunner {
	if i.err == nil {
		if err := steps.ConfigureMacDefaults(i.dotfilesPath); err != nil {
			i.err = err
		}
	}
	return i
}
func (i *InstallStepsRunner) ConfigureExtensionsDefaults() *InstallStepsRunner {
	if i.err == nil {
		if err := steps.ConfigureExtensionsDefaults(i.dotfilesPath); err != nil {
			i.err = err
		}
	}
	return i
}
func (i *InstallStepsRunner) InstallDockerAndColima() *InstallStepsRunner {
	if i.err == nil {
		if err := steps.InstallDockerAndColima(i.dotfilesPath); err != nil {
			i.err = err
		}
	}
	return i
}

func (i *InstallStepsRunner) Error() error {
	return i.err
}
