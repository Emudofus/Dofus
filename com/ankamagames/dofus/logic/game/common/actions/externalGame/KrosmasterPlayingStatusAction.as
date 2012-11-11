package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class KrosmasterPlayingStatusAction extends Object implements Action
    {
        public var playing:Boolean;

        public function KrosmasterPlayingStatusAction()
        {
            return;
        }// end function

        public static function create(param1:Boolean) : KrosmasterPlayingStatusAction
        {
            var _loc_2:* = new KrosmasterPlayingStatusAction;
            _loc_2.playing = param1;
            return _loc_2;
        }// end function

    }
}
