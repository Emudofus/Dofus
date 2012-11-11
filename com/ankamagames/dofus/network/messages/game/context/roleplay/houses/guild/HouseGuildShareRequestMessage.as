package com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class HouseGuildShareRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var enable:Boolean = false;
        public var rights:uint = 0;
        public static const protocolId:uint = 5704;

        public function HouseGuildShareRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5704;
        }// end function

        public function initHouseGuildShareRequestMessage(param1:Boolean = false, param2:uint = 0) : HouseGuildShareRequestMessage
        {
            this.enable = param1;
            this.rights = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.enable = false;
            this.rights = 0;
            this._isInitialized = false;
            return;
        }// end function

        override public function pack(param1:IDataOutput) : void
        {
            var _loc_2:* = new ByteArray();
            this.serialize(_loc_2);
            writePacket(param1, this.getMessageId(), _loc_2);
            return;
        }// end function

        override public function unpack(param1:IDataInput, param2:uint) : void
        {
            this.deserialize(param1);
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_HouseGuildShareRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_HouseGuildShareRequestMessage(param1:IDataOutput) : void
        {
            param1.writeBoolean(this.enable);
            if (this.rights < 0 || this.rights > 4294967295)
            {
                throw new Error("Forbidden value (" + this.rights + ") on element rights.");
            }
            param1.writeUnsignedInt(this.rights);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_HouseGuildShareRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_HouseGuildShareRequestMessage(param1:IDataInput) : void
        {
            this.enable = param1.readBoolean();
            this.rights = param1.readUnsignedInt();
            if (this.rights < 0 || this.rights > 4294967295)
            {
                throw new Error("Forbidden value (" + this.rights + ") on element of HouseGuildShareRequestMessage.rights.");
            }
            return;
        }// end function

    }
}
