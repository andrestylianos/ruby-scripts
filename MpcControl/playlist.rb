class Playlist
  def initialize(dmenopt)
    @dmenopt = dmenopt
  end
  def clear(musicicon)
    cmd = 'mpc clear'
    %x[#{cmd}]
    cmd = 'notify-send "MPC Control" "Cleared Playlist" -i '+musicicon
    %x[#{cmd}]
  end
  
  def findSongInPlaylist()
    cmd = 'mpc playlist -f "%position% -> %artist% - %title%" | dmenu -l 10 -p "MPD: Choose Song"'+@dmenopt
    song = %x[#{cmd}]
    @pos = song.split(" ")[0]
    if (@pos.nil?)
      abort("No song Choosen.")
    else
      return self
    end
  end
  
  def delSong(musicicon)
    cmd = "mpc del #{@pos}"
    %x[#{cmd}]
  end
  
  def playSong(musicicon)
    cmd = "mpc play #{@pos}"
    %x[#{cmd}]
  end
  
  def loadPlaylist(musicicon)
    cmd = 'mpc lsplaylists | sort | dmenu -p "MPD: Playlist to load" '+@dmenopt
    playlist = %x[#{cmd}]
    unless playlist.empty?
      %x[#{'mpc clear'}]
      cmd = 'mpc load "'+playlist+'"'
      %x[#{cmd}]
      %x[#{'mpc shuffle'}]
      %x[#{'mpc play'}]
      cmd = 'notify-send "MPC Control" "Loaded playlist <b><i>'+playlist+'</i></b>" -i "'+musicicon+'"'
      %x[#{cmd}]
    end
  end
  
  def findSong()
  end
end