package 
{
    import com.ankamagames.dofus.network.types.game.context.roleplay.party.*;
    import com.ankamagames.tiphon.types.look.*;

    class PartyMember extends Object
    {
        public var isLeader:Boolean = false;
        public var infos:PartyMemberInformations;
        public var skin:TiphonEntityLook;
        public var skinModified:Boolean = false;

        function PartyMember()
        {
            return;
        }// end function

    }
}
