class Song
  def initialize(dmenopt)
    @dmenopt = dmenopt
  end
  
  def findSong()
    cmd = 'mpc list title | sort | dmenu -l 20 -p "MPD: Choose Song" '+@dmenopt
    song = %x[#{cmd}]
    playlist = `mpc playlist -f "%title%"`
    pos = playlist.split("\n").index { |s| s==song }
    if pos!=nil
      pos+=1
      cmd = "mpc play #{pos}"
      puts cmd
      %x[#{cmd}]
    else
      cmd = 'mpc findadd title "'+song+'"'
      puts cmd
      %x[#{cmd}]
    end
  end
end