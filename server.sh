cd /home/warlock/server
JAR="paper.jar"
RAM="6400M"
FLAGS="-XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Daikars.new.flags=true -Dusing.aikars.flags=https://mcflags.emc.gs"
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
