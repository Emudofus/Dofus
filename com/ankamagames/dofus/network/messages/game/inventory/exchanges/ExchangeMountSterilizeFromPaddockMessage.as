package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeMountSterilizeFromPaddockMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6056;

        private var _isInitialized:Boolean = false;
        public var name:String = "";
        public var worldX:int = 0;
        public var worldY:int = 0;
        public var sterilizator:String = "";


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6056);
        }

        public function initExchangeMountSterilizeFromPaddockMessage(name:String="", worldX:int=0, worldY:int=0, sterilizator:String=""):ExchangeMountSterilizeFromPaddockMessage
        {
            this.name = name;
            this.worldX = worldX;
            this.worldY = worldY;
            this.sterilizator = sterilizator;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.name = "";
            this.worldX = 0;
            this.worldY = 0;
            this.sterilizator = "";
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
            this.serializeAs_ExchangeMountSterilizeFromPaddockMessage(output);
        }

        public function serializeAs_ExchangeMountSterilizeFromPaddockMessage(output:ICustomDataOutput):void
        {
            output.writeUTF(this.name);
            if ((((this.worldX < -255)) || ((this.worldX > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldX) + ") on element worldX.")));
            };
            output.writeShort(this.worldX);
            if ((((this.worldY < -255)) || ((this.worldY > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldY) + ") on element worldY.")));
            };
            output.writeShort(this.worldY);
            output.writeUTF(this.sterilizator);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeMountSterilizeFromPaddockMessage(input);
        }

        public function deserializeAs_ExchangeMountSterilizeFromPaddockMessage(input:ICustomDataInput):void
        {
            this.name = input.readUTF();
            this.worldX = input.readShort();
            if ((((this.worldX < -255)) || ((this.worldX > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldX) + ") on element of ExchangeMountSterilizeFromPaddockMessage.worldX.")));
            };
            this.worldY = input.readShort();
            if ((((this.worldY < -255)) || ((this.worldY > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldY) + ") on element of ExchangeMountSterilizeFromPaddockMessage.worldY.")));
            };
            this.sterilizator = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

