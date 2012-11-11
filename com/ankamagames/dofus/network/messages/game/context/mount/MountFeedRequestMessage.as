package com.ankamagames.dofus.network.messages.game.context.mount
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class MountFeedRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var mountUid:Number = 0;
        public var mountLocation:int = 0;
        public var mountFoodUid:uint = 0;
        public var quantity:uint = 0;
        public static const protocolId:uint = 6189;

        public function MountFeedRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6189;
        }// end function

        public function initMountFeedRequestMessage(param1:Number = 0, param2:int = 0, param3:uint = 0, param4:uint = 0) : MountFeedRequestMessage
        {
            this.mountUid = param1;
            this.mountLocation = param2;
            this.mountFoodUid = param3;
            this.quantity = param4;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.mountUid = 0;
            this.mountLocation = 0;
            this.mountFoodUid = 0;
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

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_MountFeedRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_MountFeedRequestMessage(param1:IDataOutput) : void
        {
            if (this.mountUid < 0)
            {
                throw new Error("Forbidden value (" + this.mountUid + ") on element mountUid.");
            }
            param1.writeDouble(this.mountUid);
            param1.writeByte(this.mountLocation);
            if (this.mountFoodUid < 0)
            {
                throw new Error("Forbidden value (" + this.mountFoodUid + ") on element mountFoodUid.");
            }
            param1.writeInt(this.mountFoodUid);
            if (this.quantity < 0)
            {
                throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
            }
            param1.writeInt(this.quantity);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_MountFeedRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_MountFeedRequestMessage(param1:IDataInput) : void
        {
            this.mountUid = param1.readDouble();
            if (this.mountUid < 0)
            {
                throw new Error("Forbidden value (" + this.mountUid + ") on element of MountFeedRequestMessage.mountUid.");
            }
            this.mountLocation = param1.readByte();
            this.mountFoodUid = param1.readInt();
            if (this.mountFoodUid < 0)
            {
                throw new Error("Forbidden value (" + this.mountFoodUid + ") on element of MountFeedRequestMessage.mountFoodUid.");
            }
            this.quantity = param1.readInt();
            if (this.quantity < 0)
            {
                throw new Error("Forbidden value (" + this.quantity + ") on element of MountFeedRequestMessage.quantity.");
            }
            return;
        }// end function

    }
}
