package cmd

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
	if i.err == nil {
		if err := updateDotfilesRepository(i.dotfilesPath); err != nil {
			i.err = err
		}
	}
	return i
}

func (i *InstallStepsRunner) InstallingOhMyZSH() *InstallStepsRunner {
	if i.err == nil {
		installingOhMyZSH()
	}
	return i
}
func (i *InstallStepsRunner) DownloadGitSubmodules() *InstallStepsRunner {
	if i.err == nil {
		if err := downloadGitSubmodules(i.dotfilesPath); err != nil {
			i.err = err
		}
	}
	return i
}
func (i *InstallStepsRunner) InstallInitShellFiles() *InstallStepsRunner {
	if i.err == nil {
		if err := installInitShellFiles(i.dotfilesPath); err != nil {
			i.err = err
		}
	}
	return i
}
func (i *InstallStepsRunner) InstallBrewBundle() *InstallStepsRunner {
	if i.err == nil && i.config.installBrewBundle {
		if err := installBrewBundle(i.dotfilesPath); err != nil {
			i.err = err
		}
	}
	return i
}

func (i *InstallStepsRunner) CreateSymlinks() *InstallStepsRunner {
	if i.err == nil {
		if err := createSymlinks(i.dotfilesPath); err != nil {
			i.err = err
		}
	}
	return i
}

func (i *InstallStepsRunner) CreateDevelopmentFolders() *InstallStepsRunner {
	if i.err == nil {
		createDevelopmentFolders()
	}
	return i
}

func (i *InstallStepsRunner) ConfigureMacDefaults() *InstallStepsRunner {
	if i.err == nil {
		if err := configureMacDefaults(i.dotfilesPath); err != nil {
			i.err = err
		}
	}
	return i
}
func (i *InstallStepsRunner) ConfigureExtensionsDefaults() *InstallStepsRunner {
	if i.err == nil {
		if err := configureExtensionsDefaults(i.dotfilesPath); err != nil {
			i.err = err
		}
	}
	return i
}
func (i *InstallStepsRunner) InstallDockerAndColima() *InstallStepsRunner {
	if i.err == nil {
		if err := installDockerAndColima(i.dotfilesPath); err != nil {
			i.err = err
		}
	}
	return i
}

func (i *InstallStepsRunner) Error() error {
	return i.err
}
