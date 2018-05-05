library Input
    //! textmacro InputInitArrowTrigger takes VAR, ID, FUNC
        set $VAR$ = CreateTrigger()
        call TriggerRegisterPlayerEvent($VAR$, Player(id), EVENT_PLAYER_ARROW_$ID$)
        call TriggerAddAction($VAR$, function thistype.$FUNC$)
    //! endtextmacro

    //! textmacro InputArrow takes UP, LOW
        boolean is$UP$
        trigger $LOW$Down
        trigger $LOW$Up
        static method on$UP$Down takes nothing returns nothing 
            set all[GetPlayerId(GetTriggerPlayer())].is$UP$ = true
        endmethod
        
        static method on$UP$Up takes nothing returns nothing 
            set all[GetPlayerId(GetTriggerPlayer())].is$UP$ = false
        endmethod
    //! endtextmacro

    //! textmacro InputInitSpellTrigger takes VAR, ID, FUNC
        set $VAR$ = CreateTrigger()
        call TriggerRegisterPlayerUnitEvent(trig, Player(ID), whichEvent, null)
        call TriggerAddAction( gg_trg_JVideo, function Trig_Untitled_Trigger_001_Actions )
        call TriggerRegisterPlayerEvent($VAR$, Player(id), EVENT_PLAYER_ARROW_$ID$)
        call TriggerAddAction($VAR$, function thistype.$FUNC$)
    //! endtextmacro

    struct Input
        private static thistype array all
        unit controller
        trigger keyW
        trigger keyA
        trigger keyS
        trigger keyD
        trigger keyStart
        trigger keySelect
        boolean isW
        boolean isA
        boolean isS
        boolean isD
        boolean isStart
        boolean isSelect
        
        //! runtextmacro InputArrow("Up", "up")
        //! runtextmacro InputArrow("Down", "down")
        //! runtextmacro InputArrow("Left", "left")
        //! runtextmacro InputArrow("Right", "right")
        
        static method create takes integer id returns thistype 
            local thistype this = allocate()
            //! runtextmacro InputInitArrowTrigger("upDown","UP_DOWN","onUpDown")
            //! runtextmacro InputInitArrowTrigger("downDown","DOWN_DOWN","onDownDown")
            //! runtextmacro InputInitArrowTrigger("leftDown","LEFT_DOWN","onLeftDown")
            //! runtextmacro InputInitArrowTrigger("rightDown","RIGHT_DOWN","onRightDown")
            //! runtextmacro InputInitArrowTrigger("upUp","UP_UP","onUpUp")
            //! runtextmacro InputInitArrowTrigger("downUp","DOWN_UP","onDownUp")
            //! runtextmacro InputInitArrowTrigger("leftUp","LEFT_UP","onLeftUp")
            //! runtextmacro InputInitArrowTrigger("rightUp","RIGHT_UP","onRightUp")
            set controller = CreateUnit(Player(id), 'h000', 0, 0, 0)
            call SelectUnitForPlayerSingle(controller, Player(id))
            set all[id] = this
            return this
        endmethod 
    endstruct
endlibrary