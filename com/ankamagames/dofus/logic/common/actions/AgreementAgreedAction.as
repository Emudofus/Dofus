package com.ankamagames.dofus.logic.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class AgreementAgreedAction extends Object implements Action
    {
        public var fileName:String;

        public function AgreementAgreedAction()
        {
            return;
        }// end function

        public static function create(param1:String) : AgreementAgreedAction
        {
            var _loc_2:* = new AgreementAgreedAction;
            _loc_2.fileName = param1;
            return _loc_2;
        }// end function

    }
}
