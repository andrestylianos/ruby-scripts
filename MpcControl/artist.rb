class Artist
  
  def getArtist(dmenopt)
    cmd = 'mpc list artist'
    cmd2 = 'sort'
    cmd3 = 'dmenu -p "MPD: Choose artist"'+dmenopt
    Open3.pipeline_r(cmd,cmd2,cmd3) do |output|
      @artist = output.read
    end
    if @artist.empty?
      abort("No artist chosen.")
    else
      return self
    end
  end
    
  def addArtist(musicicon)
    cmd = 'mpc findadd artist '+@artist
    %x[#{cmd}]
    notify = 'notify-send "MPC Control" "Added all songs by '+@artist+'" -i "'+musicicon+'"'
    %x[#{notify}]
  end

  def delArtist(musicicon)
    cmd = 'mpc playlist'
    cmd2 = 'grep -i -n "'+@artist+'"'
    cmd3 = 'cut -d ":" -f 1'
    cmd4 = 'mpc del'
    Open3.pipeline(cmd,cmd2,cmd3,cmd4)  
    notify = 'notify-send "MPC Control" "Deleted all songs by '+@artist+'" -i "'+musicicon+'"'
    %x[#{notify}]
  end
end