package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ObjectUseMultipleMessage extends ObjectUseMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var quantity:uint = 0;
        public static const protocolId:uint = 6234;

        public function ObjectUseMultipleMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6234;
        }// end function

        public function initObjectUseMultipleMessage(param1:uint = 0, param2:uint = 0) : ObjectUseMultipleMessage
        {
            super.initObjectUseMessage(param1);
            this.quantity = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.quantity = 0;
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

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ObjectUseMultipleMessage(param1);
            return;
        }// end function

        public function serializeAs_ObjectUseMultipleMessage(param1:IDataOutput) : void
        {
            super.serializeAs_ObjectUseMessage(param1);
            if (this.quantity < 0)
            {
                throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
            }
            param1.writeInt(this.quantity);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ObjectUseMultipleMessage(param1);
            return;
        }// end function

        public function deserializeAs_ObjectUseMultipleMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.quantity = param1.readInt();
            if (this.quantity < 0)
            {
                throw new Error("Forbidden value (" + this.quantity + ") on element of ObjectUseMultipleMessage.quantity.");
            }
            return;
        }// end function

    }
}
