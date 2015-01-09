package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PlaySoundAction implements Action 
    {

        public var soundId:String;


        public static function create(pSoundId:String):PlaySoundAction
        {
            var action:PlaySoundAction = new (PlaySoundAction)();
            action.soundId = pSoundId;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions

