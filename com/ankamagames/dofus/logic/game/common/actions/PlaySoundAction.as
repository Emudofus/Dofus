package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class PlaySoundAction extends Object implements Action
    {
        public var soundId:String;

        public function PlaySoundAction()
        {
            return;
        }// end function

        public static function create(param1:String) : PlaySoundAction
        {
            var _loc_2:* = new PlaySoundAction;
            _loc_2.soundId = param1;
            return _loc_2;
        }// end function

    }
}
