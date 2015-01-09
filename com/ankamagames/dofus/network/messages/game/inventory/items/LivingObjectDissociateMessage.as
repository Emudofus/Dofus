package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class LivingObjectDissociateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5723;

        private var _isInitialized:Boolean = false;
        public var livingUID:uint = 0;
        public var livingPosition:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5723);
        }

        public function initLivingObjectDissociateMessage(livingUID:uint=0, livingPosition:uint=0):LivingObjectDissociateMessage
        {
            this.livingUID = livingUID;
            this.livingPosition = livingPosition;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.livingUID = 0;
            this.livingPosition = 0;
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
            this.serializeAs_LivingObjectDissociateMessage(output);
        }

        public function serializeAs_LivingObjectDissociateMessage(output:ICustomDataOutput):void
        {
            if (this.livingUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.livingUID) + ") on element livingUID.")));
            };
            output.writeVarInt(this.livingUID);
            if ((((this.livingPosition < 0)) || ((this.livingPosition > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.livingPosition) + ") on element livingPosition.")));
            };
            output.writeByte(this.livingPosition);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_LivingObjectDissociateMessage(input);
        }

        public function deserializeAs_LivingObjectDissociateMessage(input:ICustomDataInput):void
        {
            this.livingUID = input.readVarUhInt();
            if (this.livingUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.livingUID) + ") on element of LivingObjectDissociateMessage.livingUID.")));
            };
            this.livingPosition = input.readUnsignedByte();
            if ((((this.livingPosition < 0)) || ((this.livingPosition > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.livingPosition) + ") on element of LivingObjectDissociateMessage.livingPosition.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.items

