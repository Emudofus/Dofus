package com.ankamagames.dofus.network.messages.game.basic
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class BasicWhoAmIRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5664;

        private var _isInitialized:Boolean = false;
        public var verbose:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5664);
        }

        public function initBasicWhoAmIRequestMessage(verbose:Boolean=false):BasicWhoAmIRequestMessage
        {
            this.verbose = verbose;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.verbose = false;
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
            this.serializeAs_BasicWhoAmIRequestMessage(output);
        }

        public function serializeAs_BasicWhoAmIRequestMessage(output:IDataOutput):void
        {
            output.writeBoolean(this.verbose);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_BasicWhoAmIRequestMessage(input);
        }

        public function deserializeAs_BasicWhoAmIRequestMessage(input:IDataInput):void
        {
            this.verbose = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.basic

