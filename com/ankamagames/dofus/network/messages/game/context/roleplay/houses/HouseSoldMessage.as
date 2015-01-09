package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class HouseSoldMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5737;

        private var _isInitialized:Boolean = false;
        public var houseId:uint = 0;
        public var realPrice:uint = 0;
        public var buyerName:String = "";


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5737);
        }

        public function initHouseSoldMessage(houseId:uint=0, realPrice:uint=0, buyerName:String=""):HouseSoldMessage
        {
            this.houseId = houseId;
            this.realPrice = realPrice;
            this.buyerName = buyerName;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.houseId = 0;
            this.realPrice = 0;
            this.buyerName = "";
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
            this.serializeAs_HouseSoldMessage(output);
        }

        public function serializeAs_HouseSoldMessage(output:ICustomDataOutput):void
        {
            if (this.houseId < 0)
            {
                throw (new Error((("Forbidden value (" + this.houseId) + ") on element houseId.")));
            };
            output.writeVarInt(this.houseId);
            if (this.realPrice < 0)
            {
                throw (new Error((("Forbidden value (" + this.realPrice) + ") on element realPrice.")));
            };
            output.writeVarInt(this.realPrice);
            output.writeUTF(this.buyerName);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_HouseSoldMessage(input);
        }

        public function deserializeAs_HouseSoldMessage(input:ICustomDataInput):void
        {
            this.houseId = input.readVarUhInt();
            if (this.houseId < 0)
            {
                throw (new Error((("Forbidden value (" + this.houseId) + ") on element of HouseSoldMessage.houseId.")));
            };
            this.realPrice = input.readVarUhInt();
            if (this.realPrice < 0)
            {
                throw (new Error((("Forbidden value (" + this.realPrice) + ") on element of HouseSoldMessage.realPrice.")));
            };
            this.buyerName = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.houses

