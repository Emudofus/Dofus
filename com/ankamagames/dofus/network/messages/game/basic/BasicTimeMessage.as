package com.ankamagames.dofus.network.messages.game.basic
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class BasicTimeMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 175;

        private var _isInitialized:Boolean = false;
        public var timestamp:Number = 0;
        public var timezoneOffset:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (175);
        }

        public function initBasicTimeMessage(timestamp:Number=0, timezoneOffset:int=0):BasicTimeMessage
        {
            this.timestamp = timestamp;
            this.timezoneOffset = timezoneOffset;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.timestamp = 0;
            this.timezoneOffset = 0;
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
            this.serializeAs_BasicTimeMessage(output);
        }

        public function serializeAs_BasicTimeMessage(output:ICustomDataOutput):void
        {
            if ((((this.timestamp < 0)) || ((this.timestamp > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.timestamp) + ") on element timestamp.")));
            };
            output.writeDouble(this.timestamp);
            output.writeShort(this.timezoneOffset);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_BasicTimeMessage(input);
        }

        public function deserializeAs_BasicTimeMessage(input:ICustomDataInput):void
        {
            this.timestamp = input.readDouble();
            if ((((this.timestamp < 0)) || ((this.timestamp > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.timestamp) + ") on element of BasicTimeMessage.timestamp.")));
            };
            this.timezoneOffset = input.readShort();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.basic

