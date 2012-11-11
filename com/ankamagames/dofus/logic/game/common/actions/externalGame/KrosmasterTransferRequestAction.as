package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class KrosmasterTransferRequestAction extends Object implements Action
    {
        public var figureId:String;

        public function KrosmasterTransferRequestAction()
        {
            return;
        }// end function

        public static function create(param1:String) : KrosmasterTransferRequestAction
        {
            var _loc_2:* = new KrosmasterTransferRequestAction;
            _loc_2.figureId = param1;
            return _loc_2;
        }// end function

    }
}
