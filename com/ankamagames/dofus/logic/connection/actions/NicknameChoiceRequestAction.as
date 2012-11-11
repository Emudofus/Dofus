package com.ankamagames.dofus.logic.connection.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class NicknameChoiceRequestAction extends Object implements Action
    {
        public var nickname:String;

        public function NicknameChoiceRequestAction()
        {
            return;
        }// end function

        public static function create(param1:String) : NicknameChoiceRequestAction
        {
            var _loc_2:* = new NicknameChoiceRequestAction;
            _loc_2.nickname = param1;
            return _loc_2;
        }// end function

    }
}
