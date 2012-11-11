package com.ankamagames.dofus.network.messages.game.social
{
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ContactLookMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var requestId:uint = 0;
        public var playerName:String = "";
        public var playerId:uint = 0;
        public var look:EntityLook;
        public static const protocolId:uint = 5934;

        public function ContactLookMessage()
        {
            this.look = new EntityLook();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5934;
        }// end function

        public function initContactLookMessage(param1:uint = 0, param2:String = "", param3:uint = 0, param4:EntityLook = null) : ContactLookMessage
        {
            this.requestId = param1;
            this.playerName = param2;
            this.playerId = param3;
            this.look = param4;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.requestId = 0;
            this.playerName = "";
            this.playerId = 0;
            this.look = new EntityLook();
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
            this.serializeAs_ContactLookMessage(param1);
            return;
        }// end function

        public function serializeAs_ContactLookMessage(param1:IDataOutput) : void
        {
            if (this.requestId < 0)
            {
                throw new Error("Forbidden value (" + this.requestId + ") on element requestId.");
            }
            param1.writeInt(this.requestId);
            param1.writeUTF(this.playerName);
            if (this.playerId < 0)
            {
                throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
            }
            param1.writeInt(this.playerId);
            this.look.serializeAs_EntityLook(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ContactLookMessage(param1);
            return;
        }// end function

        public function deserializeAs_ContactLookMessage(param1:IDataInput) : void
        {
            this.requestId = param1.readInt();
            if (this.requestId < 0)
            {
                throw new Error("Forbidden value (" + this.requestId + ") on element of ContactLookMessage.requestId.");
            }
            this.playerName = param1.readUTF();
            this.playerId = param1.readInt();
            if (this.playerId < 0)
            {
                throw new Error("Forbidden value (" + this.playerId + ") on element of ContactLookMessage.playerId.");
            }
            this.look = new EntityLook();
            this.look.deserialize(param1);
            return;
        }// end function

    }
}
