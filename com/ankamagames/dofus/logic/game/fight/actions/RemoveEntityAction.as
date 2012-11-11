package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class RemoveEntityAction extends Object implements Action
    {
        public var actorId:int;

        public function RemoveEntityAction()
        {
            return;
        }// end function

        public static function create(param1:int) : RemoveEntityAction
        {
            var _loc_2:* = new RemoveEntityAction;
            _loc_2.actorId = param1;
            return _loc_2;
        }// end function

    }
}
