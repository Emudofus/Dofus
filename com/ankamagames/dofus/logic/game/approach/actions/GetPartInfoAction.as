package com.ankamagames.dofus.logic.game.approach.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class GetPartInfoAction extends Object implements Action
    {
        public var id:String;

        public function GetPartInfoAction()
        {
            return;
        }// end function

        public static function create(param1:String) : GetPartInfoAction
        {
            var _loc_2:* = new GetPartInfoAction;
            _loc_2.id = param1;
            return _loc_2;
        }// end function

    }
}
