library JWave
//! textmacro JWaveInit takes BPM, LENGTH
    globals
        public constant integer bpm = $BPM$ 
        public constant real fpb = (0.03 * 100.0) / ((I2R(bpm) / 60.0))
        public constant integer length = $LENGTH$
        private real array layer1
        private real array layer2
        private boolean playing = false
        private integer current = 0
        private real delay = 0
    endglobals
//! endtextmacro

//! textmacro JWavePlayer
    public function isPlaying takes nothing returns boolean 
		return playing 
	endfunction
    
	public function play takes nothing returns nothing 
		set playing = true
        call BJDebugMsg("Play")
	endfunction
	
	public function pause takes nothing returns nothing 
        call StopSoundBJ(gg_snd_SoundLayer1, false)
		call StopSoundBJ(gg_snd_SoundLayer2, false)
        set playing = false
	endfunction
    
	public function stop takes nothing returns nothing
        call pause()
		set current = 0
        set delay = 0
        call BJDebugMsg("Stop")
	endfunction
	
	public function next takes nothing returns nothing
        if (delay > 0) then
            set delay = delay - 1
            return
        endif
        if (current >= length) then
			call stop()
			return 
		endif
        if (layer1[current] > 0) then
            call StopSoundBJ(gg_snd_SoundLayer1, false)
            call SetSoundPitch(gg_snd_SoundLayer1, layer1[current])
            call PlaySoundBJ(gg_snd_SoundLayer1)
            call BJDebugMsg(R2S(layer1[current]))
		elseif (layer1[current] < 0) then
            call StopSoundBJ(gg_snd_SoundLayer1, false)
        endif
        if (layer2[current] > 0) then
            call StopSoundBJ(gg_snd_SoundLayer2, false)
            call SetSoundPitch(gg_snd_SoundLayer2, layer2[current])
            call PlaySoundBJ(gg_snd_SoundLayer2)
		elseif (layer2[current] < 0) then
            call StopSoundBJ(gg_snd_SoundLayer2, false)
        endif
        set delay = fpb
        set current = current + 1
	endfunction
//! endtextmacro
endlibrary
