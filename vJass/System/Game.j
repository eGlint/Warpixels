library Game uses Bitmap, PixelWindow
    globals 
        Game1 game
        PixelPlayer array players
        timer gameThread
        timer graphicsThread
        real DELTA_TIME = 0.03
        real GRAPHICS_TIME = 0.08
    endglobals 
    
    private keyword Init
    
    interface IGame 
        method initialize takes nothing returns nothing
        method load takes nothing returns nothing
        method update takes nothing returns nothing 
        method draw takes nothing returns nothing 
    endinterface
    
    struct Game extends IGame
        boolean drawEnabled
        
        method initialize takes nothing returns nothing 
            call Bitmap_init()
            set drawEnabled = true
        endmethod
        
        method load takes nothing returns nothing
        endmethod
        
        method update takes nothing returns nothing
        endmethod

        method draw takes nothing returns nothing
        endmethod
        
        implement Init
    endstruct 
    
    private module Init
        private static method mainUpdate takes nothing returns nothing
            call CameraSetupApplyForceDuration(gg_cam_Camera, true, 0)
            if (not Bitmap_loadDone) then
                return
            endif
            call game.update()
        endmethod
        
        private static method graphicsUpdate takes nothing returns nothing
            if (not Bitmap_loadDone) then
                return
            endif
            if (game.drawEnabled) then
                call game.draw()
            endif
        endmethod
        
        private static method addPlayers takes nothing returns nothing
            call PixelPlayer.create(GetPlayerId(GetEnumPlayer()))
        endmethod
        
        private static method onInit takes nothing returns nothing
            call FogEnable(false)
            call FogMaskEnable(false)
            call SetFloatGameState(GAME_STATE_TIME_OF_DAY, 12)
            call SuspendTimeOfDay(true)
            call RGB.load()
            call PixelText_load()
            call PixelWindow_load()
            call ForForce(GetPlayersByMapControl(MAP_CONTROL_USER), function thistype.addPlayers)
            set game = Game.create()
            call game.initialize()
            call game.load()
            set gameThread = CreateTimer()
            call TimerStart(gameThread, DELTA_TIME, true, function thistype.mainUpdate)
            set graphicsThread = CreateTimer()
            call TimerStart(graphicsThread, GRAPHICS_TIME, true, function thistype.graphicsUpdate)
        endmethod
    endmodule
    
endlibrary
