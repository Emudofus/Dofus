package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class KrosmasterPlayingStatusAction implements Action 
    {

        public var playing:Boolean;


        public static function create(playing:Boolean):KrosmasterPlayingStatusAction
        {
            var action:KrosmasterPlayingStatusAction = new (KrosmasterPlayingStatusAction)();
            action.playing = playing;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.externalGame

