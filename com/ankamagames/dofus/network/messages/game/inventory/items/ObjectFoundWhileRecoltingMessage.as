package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ObjectFoundWhileRecoltingMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var genericId:uint = 0;
        public var quantity:uint = 0;
        public var ressourceGenericId:uint = 0;
        public static const protocolId:uint = 6017;

        public function ObjectFoundWhileRecoltingMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6017;
        }// end function

        public function initObjectFoundWhileRecoltingMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0) : ObjectFoundWhileRecoltingMessage
        {
            this.genericId = param1;
            this.quantity = param2;
            this.ressourceGenericId = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.genericId = 0;
            this.quantity = 0;
            this.ressourceGenericId = 0;
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
            this.serializeAs_ObjectFoundWhileRecoltingMessage(param1);
            return;
        }// end function

        public function serializeAs_ObjectFoundWhileRecoltingMessage(param1:IDataOutput) : void
        {
            if (this.genericId < 0)
            {
                throw new Error("Forbidden value (" + this.genericId + ") on element genericId.");
            }
            param1.writeInt(this.genericId);
            if (this.quantity < 0)
            {
                throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
            }
            param1.writeInt(this.quantity);
            if (this.ressourceGenericId < 0)
            {
                throw new Error("Forbidden value (" + this.ressourceGenericId + ") on element ressourceGenericId.");
            }
            param1.writeInt(this.ressourceGenericId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ObjectFoundWhileRecoltingMessage(param1);
            return;
        }// end function

        public function deserializeAs_ObjectFoundWhileRecoltingMessage(param1:IDataInput) : void
        {
            this.genericId = param1.readInt();
            if (this.genericId < 0)
            {
                throw new Error("Forbidden value (" + this.genericId + ") on element of ObjectFoundWhileRecoltingMessage.genericId.");
            }
            this.quantity = param1.readInt();
            if (this.quantity < 0)
            {
                throw new Error("Forbidden value (" + this.quantity + ") on element of ObjectFoundWhileRecoltingMessage.quantity.");
            }
            this.ressourceGenericId = param1.readInt();
            if (this.ressourceGenericId < 0)
            {
                throw new Error("Forbidden value (" + this.ressourceGenericId + ") on element of ObjectFoundWhileRecoltingMessage.ressourceGenericId.");
            }
            return;
        }// end function

    }
}
