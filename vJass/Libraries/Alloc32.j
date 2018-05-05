library Alloc32 
    module Alloc32
        private static integer instanceCount = 0
        private thistype recycle
    
        static method allocate takes nothing returns thistype
            local thistype this
    
            if (thistype(0).recycle == 0) then
                debug if (instanceCount == 32766) then
                    debug call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "Alloc ERROR: Attempted to allocate too many instances!")
                    debug return 0
                debug endif
                set instanceCount = instanceCount + 1
                set this = instanceCount
            else
                set this = thistype(0).recycle
                set thistype(0).recycle = thistype(0).recycle.recycle
            endif

            debug set this.recycle = -1
    
            return this
        endmethod
    
        method deallocate takes nothing returns nothing
            debug if (this.recycle != -1) then
                debug call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "Alloc ERROR: Attempted to deallocate an invalid instance at [" + I2S(this) + "]!")
                debug return
            debug endif

            set this.recycle = thistype(0).recycle
            set thistype(0).recycle = this
        endmethod
    endmodule
endlibrary