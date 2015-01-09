package com.ankamagames.dofus.network.messages.security
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ClientKeyMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5607;

        private var _isInitialized:Boolean = false;
        public var key:String = "";


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5607);
        }

        public function initClientKeyMessage(key:String=""):ClientKeyMessage
        {
            this.key = key;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.key = "";
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
            this.serializeAs_ClientKeyMessage(output);
        }

        public function serializeAs_ClientKeyMessage(output:ICustomDataOutput):void
        {
            output.writeUTF(this.key);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ClientKeyMessage(input);
        }

        public function deserializeAs_ClientKeyMessage(input:ICustomDataInput):void
        {
            this.key = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.security

