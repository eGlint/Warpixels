library PixelText uses Font
    globals 
        private string charMap = "!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ "
        private string array charMapArray
        private integer charMapLength  = StringLength(charMap)
        public integer startX = 0
        public integer startY = 0
        public integer cursorX = startX
        public integer cursorY = startY
        public integer stackSize = 0
        public string array stack
    endglobals
    
    public function load takes nothing returns nothing 
        local integer index = 0
        loop
            exitwhen index >= charMapLength 
            set charMapArray[index] = SubString(charMap, index, index + 1)
            set index = index + 1
        endloop
    endfunction
    
    private function draw takes integer id returns nothing 
        call Font_draw(id, cursorX, cursorY)
        set cursorX = cursorX + Font_width
    endfunction
    
    private function newLine takes nothing returns nothing 
        set cursorX = startX
        set cursorY = cursorY + Font_height
    endfunction
    
    public function reset takes nothing returns nothing 
        set cursorX = startX
        set cursorY = startY
    endfunction
    
    public function print takes string str returns nothing 
        local integer length = StringLength(str)
        local integer array charData
        local integer index = 0
        local integer charIndex
        local string select
        local integer lnIndex = 0
        loop
            exitwhen index >= length 
            set select = SubString(str, index, index + 1)
            set charIndex = 0
            loop
                if (charIndex >= charMapLength) then
                    call draw(30)
                    exitwhen true
                endif
                if (select == charMapArray[charIndex]) then
                    call draw(charIndex)
                    exitwhen true
                endif
                set charIndex = charIndex + 1
            endloop
            if cursorX >= Bitmap_Width then
                call newLine()
                set lnIndex = 0
            else
                set lnIndex = lnIndex + 1
            endif
            set index = index + 1
        endloop
    endfunction
    
    public function push takes string str returns nothing 
        set stack[stackSize] = str
        set stackSize = stackSize + 1
    endfunction
    
   
    public function pop takes nothing returns nothing
        if (stackSize == 0) then 
            return
        endif
        set stackSize = stackSize - 1
        call print(stack[stackSize])
    endfunction
    
     public function popln takes nothing returns nothing
        if (stackSize == 0) then 
            return
        endif
        call pop()
        call newLine()
    endfunction
    
    public function println takes string str returns nothing
        call print(str)
        call newLine()
    endfunction

endlibrary