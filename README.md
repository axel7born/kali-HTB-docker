# Kali Linux

It provides a Kali Linux container with the `kali-linux-top10` pre-installed ready to work, mainly to work on HackTheBox challenges and, of course, attacking boxes!
This fork is customized to remove some other mods from the original creator (https://github.com/XaviTorello/kali-full-docker)

This docker image comprises of tools I use, I saw no reason to install the entire Kali system on a docker if I only use a few tools for HackTheBox and CTFs. Hope this is as useful to others as it is to me! That's the point of GitHub and the internet, to share!

NOTE: I removed burpsuite and did not install other GUI apps because getting GUI apps running in docker is not very fun automated, aka I couldn't get it to work so no GUI apps for now.

Integrated with docker-compose and standalone builds

Be patient, this will install all Kali tools (just for the first install, at image generation time). Final image size `~8.5GB`.

## Tools

- `kali-linux-top10` 
  - aircrack-ng (removed, I don't think this necessary to use on HTB machines so I removed it)
  - burpsuite (removed, see NOTE above)
  - crackmapexec (removed, python kept giving me errors about not finding the imports or something)
  - hydra
  - john
  - metasploit-framework
  - nmap
  - responder
  - sqlmap
  - wireshark (replaced with `tshark` to use in CLI, see NOTE above)
- Info Gathering / Vuln Assessment
  - enum4linux
  - dnsmap
  - masscan
  - nbtscan
  - ncat
  - smbmap
- [SecLists](https://github.com/danielmiessler/SecLists) at `/usr/share/seclists`
- w3af (dropped out of Kali repos)
- Stego tools
  - strings
  - xxd
  - Steghide
  - Binwalk
- Reversing tools
  - radare2
  - gdb-peda
  - valgrind
  - file
- base packages
  - wget, curl, telnet, git, iputils-tracepath, net-tools
  - build-essentials
  - tmux, tmate
  - xterm, zsh
  - zstd
  - ltrace, strace
  - vim, less, colordiff, colortail
  - unzip
  - python3-setuptools python3-pip python
  - openvpn, binutils, file
- Custom dotfiles
  - .zshrc / .bashrc
  - .vimrc
  - .profile
  - .gdbinit

  
## Usage

Just launch the container using our simple bash compose handler:

```
docker cp User.ovpn <CONTAINER-ID>:/root &&\
bash run.sh
```

This will prepare a temporal container (will be auto-destroyed at the end) with the latest available version of Kali

