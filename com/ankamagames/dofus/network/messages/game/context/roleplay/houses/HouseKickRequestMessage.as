package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class HouseKickRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var id:uint = 0;
        public static const protocolId:uint = 5698;

        public function HouseKickRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5698;
        }// end function

        public function initHouseKickRequestMessage(param1:uint = 0) : HouseKickRequestMessage
        {
            this.id = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.id = 0;
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
            this.serializeAs_HouseKickRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_HouseKickRequestMessage(param1:IDataOutput) : void
        {
            if (this.id < 0)
            {
                throw new Error("Forbidden value (" + this.id + ") on element id.");
            }
            param1.writeInt(this.id);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_HouseKickRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_HouseKickRequestMessage(param1:IDataInput) : void
        {
            this.id = param1.readInt();
            if (this.id < 0)
            {
                throw new Error("Forbidden value (" + this.id + ") on element of HouseKickRequestMessage.id.");
            }
            return;
        }// end function

    }
}
