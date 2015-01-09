package com.ankamagames.dofus.network.messages.authorized
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ConsoleMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 75;

        private var _isInitialized:Boolean = false;
        public var type:uint = 0;
        public var content:String = "";


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (75);
        }

        public function initConsoleMessage(type:uint=0, content:String=""):ConsoleMessage
        {
            this.type = type;
            this.content = content;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.type = 0;
            this.content = "";
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
            this.serializeAs_ConsoleMessage(output);
        }

        public function serializeAs_ConsoleMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.type);
            output.writeUTF(this.content);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ConsoleMessage(input);
        }

        public function deserializeAs_ConsoleMessage(input:ICustomDataInput):void
        {
            this.type = input.readByte();
            if (this.type < 0)
            {
                throw (new Error((("Forbidden value (" + this.type) + ") on element of ConsoleMessage.type.")));
            };
            this.content = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.authorized

