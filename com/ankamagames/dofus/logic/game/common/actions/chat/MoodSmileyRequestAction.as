package com.ankamagames.dofus.logic.game.common.actions.chat
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class MoodSmileyRequestAction extends Object implements Action
    {
        public var smileyId:int;

        public function MoodSmileyRequestAction()
        {
            return;
        }// end function

        public static function create(param1:int) : MoodSmileyRequestAction
        {
            var _loc_2:* = new MoodSmileyRequestAction;
            _loc_2.smileyId = param1;
            return _loc_2;
        }// end function

    }
}
