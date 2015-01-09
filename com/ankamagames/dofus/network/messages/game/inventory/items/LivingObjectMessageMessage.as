package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class LivingObjectMessageMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6065;

        private var _isInitialized:Boolean = false;
        public var msgId:uint = 0;
        public var timeStamp:uint = 0;
        public var owner:String = "";
        public var objectGenericId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6065);
        }

        public function initLivingObjectMessageMessage(msgId:uint=0, timeStamp:uint=0, owner:String="", objectGenericId:uint=0):LivingObjectMessageMessage
        {
            this.msgId = msgId;
            this.timeStamp = timeStamp;
            this.owner = owner;
            this.objectGenericId = objectGenericId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.msgId = 0;
            this.timeStamp = 0;
            this.owner = "";
            this.objectGenericId = 0;
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
            this.serializeAs_LivingObjectMessageMessage(output);
        }

        public function serializeAs_LivingObjectMessageMessage(output:ICustomDataOutput):void
        {
            if (this.msgId < 0)
            {
                throw (new Error((("Forbidden value (" + this.msgId) + ") on element msgId.")));
            };
            output.writeVarShort(this.msgId);
            if (this.timeStamp < 0)
            {
                throw (new Error((("Forbidden value (" + this.timeStamp) + ") on element timeStamp.")));
            };
            output.writeInt(this.timeStamp);
            output.writeUTF(this.owner);
            if (this.objectGenericId < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectGenericId) + ") on element objectGenericId.")));
            };
            output.writeVarShort(this.objectGenericId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_LivingObjectMessageMessage(input);
        }

        public function deserializeAs_LivingObjectMessageMessage(input:ICustomDataInput):void
        {
            this.msgId = input.readVarUhShort();
            if (this.msgId < 0)
            {
                throw (new Error((("Forbidden value (" + this.msgId) + ") on element of LivingObjectMessageMessage.msgId.")));
            };
            this.timeStamp = input.readInt();
            if (this.timeStamp < 0)
            {
                throw (new Error((("Forbidden value (" + this.timeStamp) + ") on element of LivingObjectMessageMessage.timeStamp.")));
            };
            this.owner = input.readUTF();
            this.objectGenericId = input.readVarUhShort();
            if (this.objectGenericId < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectGenericId) + ") on element of LivingObjectMessageMessage.objectGenericId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.items

