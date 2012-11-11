package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ObjectFeedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var objectUID:uint = 0;
        public var foodUID:uint = 0;
        public var foodQuantity:uint = 0;
        public static const protocolId:uint = 6290;

        public function ObjectFeedMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6290;
        }// end function

        public function initObjectFeedMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0) : ObjectFeedMessage
        {
            this.objectUID = param1;
            this.foodUID = param2;
            this.foodQuantity = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.objectUID = 0;
            this.foodUID = 0;
            this.foodQuantity = 0;
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
            this.serializeAs_ObjectFeedMessage(param1);
            return;
        }// end function

        public function serializeAs_ObjectFeedMessage(param1:IDataOutput) : void
        {
            if (this.objectUID < 0)
            {
                throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
            }
            param1.writeInt(this.objectUID);
            if (this.foodUID < 0)
            {
                throw new Error("Forbidden value (" + this.foodUID + ") on element foodUID.");
            }
            param1.writeInt(this.foodUID);
            if (this.foodQuantity < 0)
            {
                throw new Error("Forbidden value (" + this.foodQuantity + ") on element foodQuantity.");
            }
            param1.writeShort(this.foodQuantity);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ObjectFeedMessage(param1);
            return;
        }// end function

        public function deserializeAs_ObjectFeedMessage(param1:IDataInput) : void
        {
            this.objectUID = param1.readInt();
            if (this.objectUID < 0)
            {
                throw new Error("Forbidden value (" + this.objectUID + ") on element of ObjectFeedMessage.objectUID.");
            }
            this.foodUID = param1.readInt();
            if (this.foodUID < 0)
            {
                throw new Error("Forbidden value (" + this.foodUID + ") on element of ObjectFeedMessage.foodUID.");
            }
            this.foodQuantity = param1.readShort();
            if (this.foodQuantity < 0)
            {
                throw new Error("Forbidden value (" + this.foodQuantity + ") on element of ObjectFeedMessage.foodQuantity.");
            }
            return;
        }// end function

    }
}
