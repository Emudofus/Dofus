package com.ankamagames.dofus.network.messages.game.context.mount
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class MountFeedRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6189;

        private var _isInitialized:Boolean = false;
        public var mountUid:Number = 0;
        public var mountLocation:int = 0;
        public var mountFoodUid:uint = 0;
        public var quantity:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6189);
        }

        public function initMountFeedRequestMessage(mountUid:Number=0, mountLocation:int=0, mountFoodUid:uint=0, quantity:uint=0):MountFeedRequestMessage
        {
            this.mountUid = mountUid;
            this.mountLocation = mountLocation;
            this.mountFoodUid = mountFoodUid;
            this.quantity = quantity;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.mountUid = 0;
            this.mountLocation = 0;
            this.mountFoodUid = 0;
            this.quantity = 0;
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_MountFeedRequestMessage(output);
        }

        public function serializeAs_MountFeedRequestMessage(output:ICustomDataOutput):void
        {
            if ((((this.mountUid < 0)) || ((this.mountUid > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.mountUid) + ") on element mountUid.")));
            };
            output.writeVarLong(this.mountUid);
            output.writeByte(this.mountLocation);
            if (this.mountFoodUid < 0)
            {
                throw (new Error((("Forbidden value (" + this.mountFoodUid) + ") on element mountFoodUid.")));
            };
            output.writeVarInt(this.mountFoodUid);
            if (this.quantity < 0)
            {
                throw (new Error((("Forbidden value (" + this.quantity) + ") on element quantity.")));
            };
            output.writeVarInt(this.quantity);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_MountFeedRequestMessage(input);
        }

        public function deserializeAs_MountFeedRequestMessage(input:ICustomDataInput):void
        {
            this.mountUid = input.readVarUhLong();
            if ((((this.mountUid < 0)) || ((this.mountUid > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.mountUid) + ") on element of MountFeedRequestMessage.mountUid.")));
            };
            this.mountLocation = input.readByte();
            this.mountFoodUid = input.readVarUhInt();
            if (this.mountFoodUid < 0)
            {
                throw (new Error((("Forbidden value (" + this.mountFoodUid) + ") on element of MountFeedRequestMessage.mountFoodUid.")));
            };
            this.quantity = input.readVarUhInt();
            if (this.quantity < 0)
            {
                throw (new Error((("Forbidden value (" + this.quantity) + ") on element of MountFeedRequestMessage.quantity.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.mount

