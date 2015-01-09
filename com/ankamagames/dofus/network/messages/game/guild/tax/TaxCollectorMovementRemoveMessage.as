package com.ankamagames.dofus.network.messages.game.guild.tax
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class TaxCollectorMovementRemoveMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5915;

        private var _isInitialized:Boolean = false;
        public var collectorId:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5915);
        }

        public function initTaxCollectorMovementRemoveMessage(collectorId:int=0):TaxCollectorMovementRemoveMessage
        {
            this.collectorId = collectorId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.collectorId = 0;
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
            this.serializeAs_TaxCollectorMovementRemoveMessage(output);
        }

        public function serializeAs_TaxCollectorMovementRemoveMessage(output:ICustomDataOutput):void
        {
            output.writeInt(this.collectorId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_TaxCollectorMovementRemoveMessage(input);
        }

        public function deserializeAs_TaxCollectorMovementRemoveMessage(input:ICustomDataInput):void
        {
            this.collectorId = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild.tax

