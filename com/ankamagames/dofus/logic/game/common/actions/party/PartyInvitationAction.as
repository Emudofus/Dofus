package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PartyInvitationAction implements Action 
    {

        public var name:String;
        public var dungeon:uint;
        public var inArena:Boolean;


        public static function create(name:String, dungeon:uint=0, inArena:Boolean=false):PartyInvitationAction
        {
            var a:PartyInvitationAction = new (PartyInvitationAction)();
            a.name = name;
            a.dungeon = dungeon;
            a.inArena = inArena;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.party

