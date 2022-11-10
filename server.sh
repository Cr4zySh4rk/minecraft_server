cd /home/warlock/minecraft_server
JAR="paper.jar"
#JAR="purpur.jar"
RAM="6400M"
FLAGS="-XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:MaxGCPauseMillis=100 -XX:+DisableExplicitGC -XX:TargetSurvivorRatio=90 -XX:G1NewSizePercent=50 -XX:G1MaxNewSizePercent=80 -XX:G1MixedGCLiveThresholdPercent=50 -XX:+AlwaysPreTouch --add-modules=jdk.incubator.vector"
echo "-=-=-=-=-=STARTING MINECRAFT SERVER=-=-=-=-=-"
sudo -u warlock tmux new-session -d -s minecraft java -Xms${RAM} -Xmx${RAM} ${FLAGS} -jar ${JAR} --nogui
sudo -u warlock tmux set -g status off
for i in $(seq 0.0 .384615 100.0);
do
  printf "\r<<<<<<<<<<<<<<<<<<< %04.1f%% >>>>>>>>>>>>>>>>>>>" "$i"
  sleep 1
done
printf "\n"
sudo -u warlock tmux send-keys -t minecraft "dhub reload" ENTER
sleep 5
sudo -u warlock echo "DeluxeHub plugin has been reloaded."
if tmux ls | grep -q "minecraft";then
 sudo -u warlock echo "Server status: Online"
else
 sudo -u warlock echo "Server status: Offline"
 sudo -u warlock echo "error: Server failed to start!"
fi
