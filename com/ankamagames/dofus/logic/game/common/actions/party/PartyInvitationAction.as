package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class PartyInvitationAction extends Object implements Action
    {
        public var name:String;
        public var dungeon:uint;
        public var inArena:Boolean;

        public function PartyInvitationAction()
        {
            return;
        }// end function

        public static function create(param1:String, param2:uint = 0, param3:Boolean = false) : PartyInvitationAction
        {
            var _loc_4:* = new PartyInvitationAction;
            new PartyInvitationAction.name = param1;
            _loc_4.dungeon = param2;
            _loc_4.inArena = param3;
            return _loc_4;
        }// end function

    }
}
