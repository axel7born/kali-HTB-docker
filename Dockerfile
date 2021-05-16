FROM kalilinux/kali:latest

MAINTAINER Xavi Torelló <info@xaviertorello.cat>

ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm-256color

# Install Kali Top10
RUN rm -fR /var/lib/apt/ && \
    apt-get clean && \
    apt-get update -y && \
    apt-get install -y software-properties-common kali-linux-headless --fix-missing && \
    echo 'VERSION_CODENAME=kali-rolling' >> /etc/os-release
    
# Install `tshark`
RUN apt-get install tshark

# Some system tools
RUN apt-get install -y git colordiff colortail unzip vim tmux zsh curl telnet strace ltrace tmate less build-essential wget python3-setuptools python3-pip zstd net-tools bash-completion iputils-tracepath

# Install steghide, binwalk, xxd, file, binutils, openvpn, locate
RUN apt-get install -y steghide binwalk xxd file binutils openvpn locate

# Install Info Gathering / Vuln Assessment tools
RUN apt-get install -y enum4linux dnsmap masscan nbtscan ncat smbmap

# Install Reversing Tools
#RUN apt-get install -y radare2 gdb valgrind

# Setup GDB-Peda, from (https://github.com/longld/peda installation section)
#RUN git clone https://github.com/longld/peda.git ~/peda && \
#    echo "source ~/peda/peda.py" >> ~/.gdbinit && \
#3    echo "DONE! debug your program with gdb and enjoy"

# secLists!
#RUN git clone https://github.com/danielmiessler/SecLists /usr/share/seclists

# w3af
#RUN git clone https://github.com/andresriancho/w3af.git /opt/w3af && \
#    apt-get install -y libssl-dev libxml2-dev libxslt1-dev zlib1g-dev python-dev python-pybloomfiltermmap ; \
#    /opt/w3af/w3af_console ; \
#    bash /tmp/w3af_dependency_install.sh ; \
#    echo 'export PATH=/opt/w3af:$PATH' >> /etc/profile
    
# Install oh-my-zsh && some fun things for startup
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN apt-get install -y fortune
RUN apt-get install -y cowsay
RUN apt-get install -y lolcat

# Edit .vimrc 
RUN echo "filetype indent plugin on" >> ~/.vimrc
RUN echo "syntax on" >> ~/.vimrc
RUN echo "set hidden" >> ~/.vimrc
RUN echo "set ai" >> ~/.vimrc
RUN echo "set mouse=a" >> ~/.vimrc
RUN echo "set incsearch" >> ~/.vimrc
RUN echo "set confirm" >> ~/.vimrc
RUN echo "set number" >> ~/.vimrc
RUN echo "set ignorecase" >> ~/.vimrc
RUN echo "set smartcase" >> ~/.vimrc
RUN echo "set wildmenu" >> ~/.vimrc
RUN echo "set showcmd" >> ~/.vimrc
RUN echo "set hlsearch" >> ~/.vimrc
RUN echo "set nomodeline" >> ~/.vimrc
RUN echo "set backspace=indent,eol,start" >> ~/.vimrc
RUN echo "set autoindent" >> ~/.vimrc
RUN echo "set nostartofline" >> ~/.vimrc
RUN echo "set ruler" >> ~/.vimrc
RUN echo "set laststatus=2" >> ~/.vimrc
RUN echo "set shiftwidth=4" >> ~/.vimrc
RUN echo "set softtabstop=4" >> ~/.vimrc
RUN echo "set expandtab" >> ~/.vimrc

# Edit .zshrc
RUN echo "fortune | cowsay | lolcat" >> ~/.zshrc
RUN echo "alias ll='ls -alF'" >> ~/.zshrc
RUN echo "alias la='ls -A'" >> ~/.zshrc
RUN echo "alias l='ls -CF'" >> ~/.zshrc
RUN echo "alias suac='sudo apt-get update && sudo apt-get upgrade && sudo apt-get autoremove && sudo apt-get autoclean'" >> ~/.zshrc
RUN echo "alias python=/usr/bin/python3" >> ~/.zshrc
RUN echo "alias ks='ls'" >> ~/.zshrc
RUN echo "alias cls='clear'" >> ~/.zshrc
RUN echo "alias claer='clear'" >> ~/.zshrc
RUN echo "alias caler='clear'" >> ~/.zshrc
RUN echo "alias gdb='gdb -q'" >> ~/.zshrc
RUN echo "alias cd..='cd ..'" >> ~/.zshrc
RUN echo "alias cd....='cd ../..'" >> ~/.zshrc
RUN echo "alias fcl='fortune | cowsay | lolcat'" >> ~/.zshrc
RUN echo "alias pip='pip3'" >> ~/.zshrc
RUN echo "alias docker='sudo docker'" >> ~/.zshrc
RUN echo "export PATH=$PATH:/usr/games" >> ~/.zshrc
#RUN PATH="$PATH:/usr/games:/opt/w3af"
    
RUN export PATH="$PATH:/usr/games"
# Update DB and clean'up!
RUN updatedb && \
    apt-get autoremove -y && \
    apt-get clean 

# Welcome message
RUN echo "echo 'Kali HTB container!\n\n'" >> /etc/profile

CMD ["/usr/bin/zsh"]
