package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PartyGuestInformations extends Object implements INetworkType
    {
        public var guestId:uint = 0;
        public var hostId:uint = 0;
        public var name:String = "";
        public var guestLook:EntityLook;
        public static const protocolId:uint = 374;

        public function PartyGuestInformations()
        {
            this.guestLook = new EntityLook();
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 374;
        }// end function

        public function initPartyGuestInformations(param1:uint = 0, param2:uint = 0, param3:String = "", param4:EntityLook = null) : PartyGuestInformations
        {
            this.guestId = param1;
            this.hostId = param2;
            this.name = param3;
            this.guestLook = param4;
            return this;
        }// end function

        public function reset() : void
        {
            this.guestId = 0;
            this.hostId = 0;
            this.name = "";
            this.guestLook = new EntityLook();
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_PartyGuestInformations(param1);
            return;
        }// end function

        public function serializeAs_PartyGuestInformations(param1:IDataOutput) : void
        {
            if (this.guestId < 0)
            {
                throw new Error("Forbidden value (" + this.guestId + ") on element guestId.");
            }
            param1.writeInt(this.guestId);
            if (this.hostId < 0)
            {
                throw new Error("Forbidden value (" + this.hostId + ") on element hostId.");
            }
            param1.writeInt(this.hostId);
            param1.writeUTF(this.name);
            this.guestLook.serializeAs_EntityLook(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PartyGuestInformations(param1);
            return;
        }// end function

        public function deserializeAs_PartyGuestInformations(param1:IDataInput) : void
        {
            this.guestId = param1.readInt();
            if (this.guestId < 0)
            {
                throw new Error("Forbidden value (" + this.guestId + ") on element of PartyGuestInformations.guestId.");
            }
            this.hostId = param1.readInt();
            if (this.hostId < 0)
            {
                throw new Error("Forbidden value (" + this.hostId + ") on element of PartyGuestInformations.hostId.");
            }
            this.name = param1.readUTF();
            this.guestLook = new EntityLook();
            this.guestLook.deserialize(param1);
            return;
        }// end function

    }
}
