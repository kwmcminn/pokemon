

def pokemon_theme_song
  player = Audite.new
  player.load('lib/sound/pokemon_theme.mp3')
  player.forward(12.3)
  player.start_stream
end
