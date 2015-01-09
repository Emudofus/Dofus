package com.ankamagames.dofus.network.messages.common.basic
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class BasicPingMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 182;

        private var _isInitialized:Boolean = false;
        public var quiet:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (182);
        }

        public function initBasicPingMessage(quiet:Boolean=false):BasicPingMessage
        {
            this.quiet = quiet;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.quiet = false;
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
            this.serializeAs_BasicPingMessage(output);
        }

        public function serializeAs_BasicPingMessage(output:ICustomDataOutput):void
        {
            output.writeBoolean(this.quiet);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_BasicPingMessage(input);
        }

        public function deserializeAs_BasicPingMessage(input:ICustomDataInput):void
        {
            this.quiet = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.common.basic

