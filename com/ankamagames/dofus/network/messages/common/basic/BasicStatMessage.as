package com.ankamagames.dofus.network.messages.common.basic
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class BasicStatMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6530;

        private var _isInitialized:Boolean = false;
        public var statId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6530);
        }

        public function initBasicStatMessage(statId:uint=0):BasicStatMessage
        {
            this.statId = statId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.statId = 0;
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
            this.serializeAs_BasicStatMessage(output);
        }

        public function serializeAs_BasicStatMessage(output:ICustomDataOutput):void
        {
            output.writeVarShort(this.statId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_BasicStatMessage(input);
        }

        public function deserializeAs_BasicStatMessage(input:ICustomDataInput):void
        {
            this.statId = input.readVarUhShort();
            if (this.statId < 0)
            {
                throw (new Error((("Forbidden value (" + this.statId) + ") on element of BasicStatMessage.statId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.common.basic

