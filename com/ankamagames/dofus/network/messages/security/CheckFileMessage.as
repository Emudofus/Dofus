package com.ankamagames.dofus.network.messages.security
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class CheckFileMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6156;

        private var _isInitialized:Boolean = false;
        public var filenameHash:String = "";
        public var type:uint = 0;
        public var value:String = "";


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6156);
        }

        public function initCheckFileMessage(filenameHash:String="", type:uint=0, value:String=""):CheckFileMessage
        {
            this.filenameHash = filenameHash;
            this.type = type;
            this.value = value;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.filenameHash = "";
            this.type = 0;
            this.value = "";
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
            this.serializeAs_CheckFileMessage(output);
        }

        public function serializeAs_CheckFileMessage(output:ICustomDataOutput):void
        {
            output.writeUTF(this.filenameHash);
            output.writeByte(this.type);
            output.writeUTF(this.value);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CheckFileMessage(input);
        }

        public function deserializeAs_CheckFileMessage(input:ICustomDataInput):void
        {
            this.filenameHash = input.readUTF();
            this.type = input.readByte();
            if (this.type < 0)
            {
                throw (new Error((("Forbidden value (" + this.type) + ") on element of CheckFileMessage.type.")));
            };
            this.value = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.security

