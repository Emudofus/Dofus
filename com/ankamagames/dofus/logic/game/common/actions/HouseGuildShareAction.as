package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class HouseGuildShareAction extends Object implements Action
    {
        public var enabled:Boolean;
        public var rights:int;

        public function HouseGuildShareAction()
        {
            return;
        }// end function

        public static function create(param1:Boolean, param2:int = 0) : HouseGuildShareAction
        {
            var _loc_3:* = new HouseGuildShareAction;
            _loc_3.enabled = param1;
            _loc_3.rights = param2;
            return _loc_3;
        }// end function

    }
}
