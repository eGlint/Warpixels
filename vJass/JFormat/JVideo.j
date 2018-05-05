library JVideo
//! textmacro JVideoInit takes WIDTH, HEIGHT
    globals 
		public constant integer width = $WIDTH$
		public constant integer height = $HEIGHT$
		public constant integer area = width * height
		private filterfunc array frame
		private integer currentFrame = 0
		private boolean playing = false
		private integer array R
		private integer array G
		private integer array B
	endglobals
//! endtextmacro

//! textmacro JVideoPlayer 

    public function isPlaying takes nothing returns boolean 
		return playing 
	endfunction
    
	public function play takes nothing returns nothing 
		set playing = true
	endfunction
	
	public function stop takes nothing returns nothing 
		set playing = false
		set currentFrame = 0
	endfunction
	
	public function pause takes nothing returns nothing 
		set playing = false
	endfunction
	
	public function next takes integer ox, integer oy returns nothing
		local integer x
        local integer y = oy
        local integer index = 0
		if (frame[currentFrame] == null) then
			call stop()
			return 
		endif
		call ForceEnumPlayers(bj_FORCE_PLAYER[0], frame[currentFrame])
        set index = 0
        
        loop
            exitwhen y >= height
            set x = ox
            loop
                exitwhen x >= width
                call Bitmap_setPixelColorRaw(x, y, R[index], G[index], B[index])
                set index = index + 1
                set x = x + 1
            endloop
            set y = y + 1
        endloop
		loop
			exitwhen index >= area
			
			set index = index + 1
		endloop
		set currentFrame = currentFrame + 1
	endfunction
//! endtextmacro
endlibrary