package com.ankamagames.dofus.network.messages.game.prism
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class PrismSetSabotagedRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6468;

        private var _isInitialized:Boolean = false;
        public var subAreaId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6468);
        }

        public function initPrismSetSabotagedRequestMessage(subAreaId:uint=0):PrismSetSabotagedRequestMessage
        {
            this.subAreaId = subAreaId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.subAreaId = 0;
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
            this.serializeAs_PrismSetSabotagedRequestMessage(output);
        }

        public function serializeAs_PrismSetSabotagedRequestMessage(output:ICustomDataOutput):void
        {
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element subAreaId.")));
            };
            output.writeVarShort(this.subAreaId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PrismSetSabotagedRequestMessage(input);
        }

        public function deserializeAs_PrismSetSabotagedRequestMessage(input:ICustomDataInput):void
        {
            this.subAreaId = input.readVarUhShort();
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element of PrismSetSabotagedRequestMessage.subAreaId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.prism

