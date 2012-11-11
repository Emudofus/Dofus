package com.ankamagames.dofus.network.messages.game.approach
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AccountCapabilitiesMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var accountId:int = 0;
        public var tutorialAvailable:Boolean = false;
        public var breedsVisible:uint = 0;
        public var breedsAvailable:uint = 0;
        public var status:int = 0;
        public static const protocolId:uint = 6216;

        public function AccountCapabilitiesMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6216;
        }// end function

        public function initAccountCapabilitiesMessage(param1:int = 0, param2:Boolean = false, param3:uint = 0, param4:uint = 0, param5:int = 0) : AccountCapabilitiesMessage
        {
            this.accountId = param1;
            this.tutorialAvailable = param2;
            this.breedsVisible = param3;
            this.breedsAvailable = param4;
            this.status = param5;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.accountId = 0;
            this.tutorialAvailable = false;
            this.breedsVisible = 0;
            this.breedsAvailable = 0;
            this.status = 0;
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
            this.serializeAs_AccountCapabilitiesMessage(param1);
            return;
        }// end function

        public function serializeAs_AccountCapabilitiesMessage(param1:IDataOutput) : void
        {
            param1.writeInt(this.accountId);
            param1.writeBoolean(this.tutorialAvailable);
            if (this.breedsVisible < 0)
            {
                throw new Error("Forbidden value (" + this.breedsVisible + ") on element breedsVisible.");
            }
            param1.writeShort(this.breedsVisible);
            if (this.breedsAvailable < 0)
            {
                throw new Error("Forbidden value (" + this.breedsAvailable + ") on element breedsAvailable.");
            }
            param1.writeShort(this.breedsAvailable);
            param1.writeByte(this.status);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AccountCapabilitiesMessage(param1);
            return;
        }// end function

        public function deserializeAs_AccountCapabilitiesMessage(param1:IDataInput) : void
        {
            this.accountId = param1.readInt();
            this.tutorialAvailable = param1.readBoolean();
            this.breedsVisible = param1.readShort();
            if (this.breedsVisible < 0)
            {
                throw new Error("Forbidden value (" + this.breedsVisible + ") on element of AccountCapabilitiesMessage.breedsVisible.");
            }
            this.breedsAvailable = param1.readShort();
            if (this.breedsAvailable < 0)
            {
                throw new Error("Forbidden value (" + this.breedsAvailable + ") on element of AccountCapabilitiesMessage.breedsAvailable.");
            }
            this.status = param1.readByte();
            return;
        }// end function

    }
}
