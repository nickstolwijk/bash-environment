for f in ~/.bash_*_aliases
do
   source $f
done

alias replaceLang='find . -name "*.java" -print | xargs sed -i "s/commons\.lang\./commons\.lang3\./g"'
alias duf='du -sk * | sort -n | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'

alias gitstup='git stash && git up && git stash pop'




