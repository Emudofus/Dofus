package com.ankamagames.dofus.logic.game.approach.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class DownloadPartAction extends Object implements Action
    {
        public var id:String;

        public function DownloadPartAction()
        {
            return;
        }// end function

        public static function create(param1:String) : DownloadPartAction
        {
            var _loc_2:* = new DownloadPartAction;
            _loc_2.id = param1;
            return _loc_2;
        }// end function

    }
}
