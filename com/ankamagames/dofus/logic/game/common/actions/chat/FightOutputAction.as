package com.ankamagames.dofus.logic.game.common.actions.chat
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class FightOutputAction extends Object implements Action
    {
        public var content:String;
        public var channel:uint;

        public function FightOutputAction()
        {
            return;
        }// end function

        public static function create(param1:String, param2:uint = 0) : FightOutputAction
        {
            var _loc_3:* = new FightOutputAction;
            _loc_3.content = param1;
            _loc_3.channel = param2;
            return _loc_3;
        }// end function

    }
}
