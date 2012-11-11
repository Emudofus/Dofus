package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class NpcGenericActionRequestAction extends Object implements Action
    {
        public var npcId:int;
        public var actionId:int;

        public function NpcGenericActionRequestAction()
        {
            return;
        }// end function

        public static function create(param1:int, param2:int) : NpcGenericActionRequestAction
        {
            var _loc_3:* = new NpcGenericActionRequestAction;
            _loc_3.npcId = param1;
            _loc_3.actionId = param2;
            return _loc_3;
        }// end function

    }
}
