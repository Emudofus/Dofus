package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ObjectMovementMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var objectUID:uint = 0;
        public var position:uint = 63;
        public static const protocolId:uint = 3010;

        public function ObjectMovementMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 3010;
        }// end function

        public function initObjectMovementMessage(param1:uint = 0, param2:uint = 63) : ObjectMovementMessage
        {
            this.objectUID = param1;
            this.position = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.objectUID = 0;
            this.position = 63;
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
            this.serializeAs_ObjectMovementMessage(param1);
            return;
        }// end function

        public function serializeAs_ObjectMovementMessage(param1:IDataOutput) : void
        {
            if (this.objectUID < 0)
            {
                throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
            }
            param1.writeInt(this.objectUID);
            param1.writeByte(this.position);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ObjectMovementMessage(param1);
            return;
        }// end function

        public function deserializeAs_ObjectMovementMessage(param1:IDataInput) : void
        {
            this.objectUID = param1.readInt();
            if (this.objectUID < 0)
            {
                throw new Error("Forbidden value (" + this.objectUID + ") on element of ObjectMovementMessage.objectUID.");
            }
            this.position = param1.readUnsignedByte();
            if (this.position < 0 || this.position > 255)
            {
                throw new Error("Forbidden value (" + this.position + ") on element of ObjectMovementMessage.position.");
            }
            return;
        }// end function

    }
}
