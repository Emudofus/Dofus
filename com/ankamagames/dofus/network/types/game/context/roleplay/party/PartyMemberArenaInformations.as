package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PartyMemberArenaInformations extends PartyMemberInformations implements INetworkType
    {
        public var rank:uint = 0;
        public static const protocolId:uint = 391;

        public function PartyMemberArenaInformations()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 391;
        }// end function

        public function initPartyMemberArenaInformations(param1:uint = 0, param2:uint = 0, param3:String = "", param4:EntityLook = null, param5:uint = 0, param6:uint = 0, param7:uint = 0, param8:uint = 0, param9:uint = 0, param10:Boolean = false, param11:int = 0, param12:uint = 0) : PartyMemberArenaInformations
        {
            super.initPartyMemberInformations(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
            this.rank = param12;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.rank = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_PartyMemberArenaInformations(param1);
            return;
        }// end function

        public function serializeAs_PartyMemberArenaInformations(param1:IDataOutput) : void
        {
            super.serializeAs_PartyMemberInformations(param1);
            if (this.rank < 0 || this.rank > 2300)
            {
                throw new Error("Forbidden value (" + this.rank + ") on element rank.");
            }
            param1.writeShort(this.rank);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PartyMemberArenaInformations(param1);
            return;
        }// end function

        public function deserializeAs_PartyMemberArenaInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.rank = param1.readShort();
            if (this.rank < 0 || this.rank > 2300)
            {
                throw new Error("Forbidden value (" + this.rank + ") on element of PartyMemberArenaInformations.rank.");
            }
            return;
        }// end function

    }
}
