package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class EmotePlayRequestAction extends Object implements Action
    {
        public var emoteId:uint;

        public function EmotePlayRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : EmotePlayRequestAction
        {
            var _loc_2:* = new EmotePlayRequestAction;
            _loc_2.emoteId = param1;
            return _loc_2;
        }// end function

    }
}
