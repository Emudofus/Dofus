package com.ankamagames.dofus.network.messages.game.inventory
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class KamasUpdateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5537;

        private var _isInitialized:Boolean = false;
        public var kamasTotal:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5537);
        }

        public function initKamasUpdateMessage(kamasTotal:int=0):KamasUpdateMessage
        {
            this.kamasTotal = kamasTotal;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.kamasTotal = 0;
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_KamasUpdateMessage(output);
        }

        public function serializeAs_KamasUpdateMessage(output:IDataOutput):void
        {
            output.writeInt(this.kamasTotal);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_KamasUpdateMessage(input);
        }

        public function deserializeAs_KamasUpdateMessage(input:IDataInput):void
        {
            this.kamasTotal = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory

