# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/dj/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -U promptinit; promptinit
prompt pure

if [[ -s "$HOME/.localtokens" ]]; then
  source "$HOME/.localtokens"
fi

if [[ -s "$HOME/.zshrc-local" ]]; then
  source "$HOME/.zshrc-local"
fi

function cg() {

if (( $#==0 )) then
  echo "Usage: cg [[org/]repo/]package"
  return 1
fi
package=$1
parts=(${(s:/:)package})

if ((${+parts[3]})) then
  cd $GOPATH/src/$1
  return 0
fi

if ((${+parts[2]})) then
  targs=`echo $GOPATH/src/*/$parts[1]/$parts[2]`
else
  targs=`echo $GOPATH/src/*/*/$parts[1]`
fi

possibles=(${(s: :)targs})

if ((${+possibles[2]})) then
  echo "Too many possible targets: $possibles"
  return 1
else
  cd $possibles[1]
  return 0
fi
}

