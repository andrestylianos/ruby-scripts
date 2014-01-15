require 'open3'
require_relative 'artist'
require_relative 'playlist'
require_relative 'song'

class Control
  def initialize(dmenopt=' -i -nb "#2B0123" -nf white -sb white -sf "#2B0123" -fn red-13', musicicon='/home/pantera/Downloads/musicicon.png')
    @dmenopt = dmenopt
    @musicicon = musicicon
  end

  def getOpt()
    cmd = 'printf "Add\nClear\nDelArtist\nDelMusic\nFind\nGoTo\nPlaylist\nRandom"'
    cmd2 = 'dmenu -p "MPD: What do you wish to do?"'+@dmenopt
    Open3.pipeline_r(cmd,cmd2) do |output|
      return output.read
    end
  end

  def doOpt()
    case getOpt()
    when("Add")
      art = Artist.new
      art.getArtist(@dmenopt).addArtist(@musicicon)
    when("Clear")
      pl = Playlist.new(@dmenopt)
      pl.clear(@musicicon)
    when("DelArtist")
      art = Artist.new
      art.getArtist(@dmenopt).delArtist(@musicicon)  
    when("DelMusic")
      pl = Playlist.new(@dmenopt)
      pl.findSongInPlaylist().delSong(@musicicon)
    when("Find")
      s = Song.new(@dmenopt)
      s.findSong      
    when("GoTo")
      pl = Playlist.new(@dmenopt)
      pl.findSongInPlaylist().playSong(@musicicon)
    when("Playlist")
      pl = Playlist.new(@dmenopt)
      pl.loadPlaylist(@musicicon)
    when("Random")
    end
  end
  
end

control = Control.new
control.doOpt()