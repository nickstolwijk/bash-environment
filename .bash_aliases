alias mci='mvnrun clean install'
alias mi='mvnrun install'
alias mcist='mvnrun clean install -Dmaven.test.skip=true $@'
alias mt='mvnrun test $@'
alias mc='mvnrun clean $@'
alias mct='mvnrun clean test $@'
alias mist='mvnrun install -Dmaven.test.skip=true $@'
alias mcd='mvnrun clean deploy $@'
alias mtd='mvnrun tomcat:deploy $@'
alias msttd='mvnrun tomcat:deploy -Dmaven.test.skip=true $@'
alias mtr='mvnrun tomcat:redeploy $@'
alias msttr='mvnrun tomcat:redeploy -Dmaven.test.skip=true $@ '
alias mtu='mvnrun tomcat:undeploy $@'
alias mtcr='mvnrun tomcat:run $@' 
alias mdr='mvnrun project-info-reports:dependencies'
alias mda='mvnrun clean dependency:analyze dependency:analyze-dep-mgt -Dmdep.analyze.ignore.direct=false'
alias mdu='mvnrun versions:display-dependency-updates versions:display-property-updates'
alias mpu='mvnrun versions:display-plugin-updates'
alias mdt='mvnrun dependency:tree'
alias cleanSnapshots='find /home/nick/.m2/repository/com/ahold/ -type f -name *SNAPSHOT* -exec rm -rf {} \;'

alias mrprepare='mvnrun release:prepare -DpushChanges=false'
alias mrperform='mvnrun release:perform -DlocalCheckout=true'
alias mulr='mvnrun versions:use-latest-releases -DallowMajorUpgrades=true -DgenerateBackupPoms=false -Dincludes=com.ahold.\*:\* -U'
function muls(){ 
  printf -v var "com.ahold.\*:ecommerce-%s\*," $@

  var=${var%?} 
  mvnrun versions:use-latest-snapshots -DallowMajorUpdates=true -DgenerateBackupPoms=false -Dincludes=${var} -U;
}
alias munv='mvnrun versions:use-next-versions -DgenerateBackupPoms=false -Dincludes=com.ahold.ecommerce:\* -U'
alias mulp='mvnrun versions:update-parent -DallowSnapshots=false -DgenerateBackupPoms=false \"-DparentVersion=[,900-SNAPSHOT\)\" -U'
alias mulps='mvnrun versions:update-parent -DallowSnapshots=true -DgenerateBackupPoms=false \"-DparentVersion=[,900-SNAPSHOT\)\" -U'
alias mur='mvnrun versions:use-releases -DgenerateBackupPoms=false -Dincludes=com.ahold.ecommerce:\*' 


alias mjr='mvnrunwithjvmopts -Decommerce.environment=tst -Doverride.resources=classpath:configuration-local.properties jetty:run'
alias mcjr='mvnrunwithjvmopts -Decommerce.environment=tst -Doverride.resources=classpath:configuration-local.properties clean jetty:run'
alias mjrstg='mvnrunwithjvmopts -Decommerce.environment=stg -Doverride.resources=classpath:configuration-local.properties jetty:run'
alias lmvn='less /tmp/lastmavencommand'

alias gitmassrebase='gitmassrun pull --rebase | tee /tmp/lastgitcommand'
alias gitmasswtf='gitmassrun wtf'
alias gitmassstatus='gitmassrun status | tee /tmp/lastgitcommand'
function gitmasslog(){ gitmassrun log "$@"; }
function gitmasscheckout(){ gitmassrun co "$@" | tee /tmp/lastgitcommand;}
alias gitmassstashshow='gitmassrun stash show | tee /tmp/lastgitcommand' 

alias replaceLang='find . -name "*.java" -print | xargs sed -i "s/commons\.lang\./commons\.lang3\./g"'

alias lgit='less /tmp/lastgitcommand'
alias gitstup='git stash && git up && git stash pop'
alias msonar='mvnrun clean test sonar:sonar -Dsonar.host.url=http://localhost:9080 -Psonar-localhost'

alias duf='du -sk * | sort -n | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'

#  Customize BASH PS1 prompt to show current GIT repository and branch.
#  by Mike Stewart - http://MediaDoneRight.com

#  SETUP CONSTANTS
#  Bunch-o-predefined colors.  Makes reading code easier than escape sequences.
#  I don't remember where I found this.  o_O

# Reset
Color_Off="\[\033[0m\]"       # Text Reset

# Regular Colors
Black="\[\033[0;30m\]"        # Black
Red="\[\033[0;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White

# Bold
BBlack="\[\033[1;30m\]"       # Black
BRed="\[\033[1;31m\]"         # Red
BGreen="\[\033[1;32m\]"       # Green
BYellow="\[\033[1;33m\]"      # Yellow
BBlue="\[\033[1;34m\]"        # Blue
BPurple="\[\033[1;35m\]"      # Purple
BCyan="\[\033[1;36m\]"        # Cyan
BWhite="\[\033[1;37m\]"       # White

# Underline
UBlack="\[\033[4;30m\]"       # Black
URed="\[\033[4;31m\]"         # Red
UGreen="\[\033[4;32m\]"       # Green
UYellow="\[\033[4;33m\]"      # Yellow
UBlue="\[\033[4;34m\]"        # Blue
UPurple="\[\033[4;35m\]"      # Purple
UCyan="\[\033[4;36m\]"        # Cyan
UWhite="\[\033[4;37m\]"       # White

# Background
On_Black="\[\033[40m\]"       # Black
On_Red="\[\033[41m\]"         # Red
On_Green="\[\033[42m\]"       # Green
On_Yellow="\[\033[43m\]"      # Yellow
On_Blue="\[\033[44m\]"        # Blue
On_Purple="\[\033[45m\]"      # Purple
On_Cyan="\[\033[46m\]"        # Cyan
On_White="\[\033[47m\]"       # White

# High Intensty
IBlack="\[\033[0;90m\]"       # Black
IRed="\[\033[0;91m\]"         # Red
IGreen="\[\033[0;92m\]"       # Green
IYellow="\[\033[0;93m\]"      # Yellow
IBlue="\[\033[0;94m\]"        # Blue
IPurple="\[\033[0;95m\]"      # Purple
ICyan="\[\033[0;96m\]"        # Cyan
IWhite="\[\033[0;97m\]"       # White

# Bold High Intensty
BIBlack="\[\033[1;90m\]"      # Black
BIRed="\[\033[1;91m\]"        # Red
BIGreen="\[\033[1;92m\]"      # Green
BIYellow="\[\033[1;93m\]"     # Yellow
BIBlue="\[\033[1;94m\]"       # Blue
BIPurple="\[\033[1;95m\]"     # Purple
BICyan="\[\033[1;96m\]"       # Cyan
BIWhite="\[\033[1;97m\]"      # White

# High Intensty backgrounds
On_IBlack="\[\033[0;100m\]"   # Black
On_IRed="\[\033[0;101m\]"     # Red
On_IGreen="\[\033[0;102m\]"   # Green
On_IYellow="\[\033[0;103m\]"  # Yellow
On_IBlue="\[\033[0;104m\]"    # Blue
On_IPurple="\[\033[10;95m\]"  # Purple
On_ICyan="\[\033[0;106m\]"    # Cyan
On_IWhite="\[\033[0;107m\]"   # White

# Various variables you might want for your PS1 prompt instead
Time12h="\T"
Time12a="\@"
PathShort="\w"
PathFull="\W"
NewLine="\n"
Jobs="\j"


# This PS1 snippet was adopted from code for MAC/BSD I saw from: http://allancraig.net/index.php?option=com_content&view=article&id=108:ps1-export-command-for-git&catid=45:general&Itemid=96
# I tweaked it to work on UBUNTU 11.04 & 11.10 plus made it mo' better

export PS1=$IBlack$Time12h$Color_Off'$(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
  echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    # @4 - Clean repository - nothing to commit
    echo "'$Green'"$(__git_ps1 " (%s)"); \
  else \
    # @5 - Changes to working tree
    echo "'$IRed'"$(__git_ps1 " {%s}"); \
  fi) '$BYellow$PathShort$Color_Off'\$ "; \
else \
  # @2 - Prompt when not in GIT repo
  echo " '$Yellow$PathShort$Color_Off'\$ "; \
fi)'
