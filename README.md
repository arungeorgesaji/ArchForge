# ArchForge

ArchForge is an extremely customizable Arch Linux install script tool designed to streamline the process of creating a personalized Arch installer tailored to your specific needs.

## Table of Contents

- [Description](#description)
- [Features](#features)
- [Files](#files)
- [Usage](#usage)

## Description

ArchForge simplifies the installation of Arch Linux by providing a set of scripts that can be customized to suit your preferences. Whether you need a basic setup or a fully personalized environment with your preferred tools and dotfiles, ArchForge has you covered.

## Features

- **Customizable installation**: Tailor the installation process to your needs.
- **Post-installation configuration**: Automate the setup of additional tools and configurations.
- **Variable-based customization**: Easily modify settings through a structured variable setup.

## Files

- `arch_installer.sh`: Installs the base system components.
- `arch_post_installer.sh`: Performs post-installation tasks.
- `my_config_installer.sh`: Installs user-specified tools and dotfiles. By default, it includes your configuration.
- `setup_variables.sh`: Allows users to customize installation settings.
- `variables.sh`: Contains system-required variables, branched from `setup_variables.sh`.
- `references/`: Contains reference files to aid in setting up `setup_variables.sh`.

## Usage

1. Clone the repository:

       git clone https://github.com/arungeorgesaji/ArchForge.git
       
2. Move everything to the home directory:

       mv ArchForge/* .
       
3. Edit the setup_variables.sh according to your requirements this setup_variables is made to lessen the load on you for scripting the my_config_installer.sh and is what make ArchForge is a good tool according to me with your favourite text editor like i use neovim(References folder has files which might help with settings up setup_variables.sh):

       nvim setup_variables.sh

4. I mean you should have done this already and made your own fork already with your own my_config_installer.sh instead of using mine here just use you favourite text editor like previously mentioned i use neovim:

       nvim my_config_installer.sh
       
5. Finally whenever you feel ready you can run the script and its run hopefully getting you a working system in the end:

       ./arch_installer.sh
       
     

   

