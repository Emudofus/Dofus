package com.ankamagames.dofus.network.messages.secure
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class TrustStatusMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6267;

        private var _isInitialized:Boolean = false;
        public var trusted:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6267);
        }

        public function initTrustStatusMessage(trusted:Boolean=false):TrustStatusMessage
        {
            this.trusted = trusted;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.trusted = false;
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
            this.serializeAs_TrustStatusMessage(output);
        }

        public function serializeAs_TrustStatusMessage(output:ICustomDataOutput):void
        {
            output.writeBoolean(this.trusted);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_TrustStatusMessage(input);
        }

        public function deserializeAs_TrustStatusMessage(input:ICustomDataInput):void
        {
            this.trusted = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.secure

