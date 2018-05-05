struct PixelPlayer
    readonly integer id
    readonly player data 
    readonly Input input
    
    method update takes nothing returns nothing 
        call SelectUnitForPlayerSingle(input.controller, data)
    endmethod
    
    method getPlayerColorId takes nothing returns integer 
        return GetHandleId(GetPlayerColor(data))
    endmethod
    
    static method create takes integer id returns thistype 
        local thistype this = allocate()
        set this.id = id 
        set data = Player(id)
        set players[id] = this 
        set input = Input.create(id)
        return this
    endmethod
    
endstruct