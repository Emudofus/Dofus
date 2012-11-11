package com.ankamagames.dofus.logic.game.common.actions.mount
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class MountRenameRequestAction extends Object implements Action
    {
        public var newName:String;
        public var mountId:Number;

        public function MountRenameRequestAction()
        {
            return;
        }// end function

        public static function create(param1:String, param2:Number) : MountRenameRequestAction
        {
            var _loc_3:* = new MountRenameRequestAction;
            _loc_3.newName = param1;
            _loc_3.mountId = param2;
            return _loc_3;
        }// end function

    }
}
