package com.ankamagames.dofus.network.messages.game.basic
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class BasicDateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 177;

        private var _isInitialized:Boolean = false;
        public var day:uint = 0;
        public var month:uint = 0;
        public var year:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (177);
        }

        public function initBasicDateMessage(day:uint=0, month:uint=0, year:uint=0):BasicDateMessage
        {
            this.day = day;
            this.month = month;
            this.year = year;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.day = 0;
            this.month = 0;
            this.year = 0;
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
            this.serializeAs_BasicDateMessage(output);
        }

        public function serializeAs_BasicDateMessage(output:ICustomDataOutput):void
        {
            if (this.day < 0)
            {
                throw (new Error((("Forbidden value (" + this.day) + ") on element day.")));
            };
            output.writeByte(this.day);
            if (this.month < 0)
            {
                throw (new Error((("Forbidden value (" + this.month) + ") on element month.")));
            };
            output.writeByte(this.month);
            if (this.year < 0)
            {
                throw (new Error((("Forbidden value (" + this.year) + ") on element year.")));
            };
            output.writeShort(this.year);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_BasicDateMessage(input);
        }

        public function deserializeAs_BasicDateMessage(input:ICustomDataInput):void
        {
            this.day = input.readByte();
            if (this.day < 0)
            {
                throw (new Error((("Forbidden value (" + this.day) + ") on element of BasicDateMessage.day.")));
            };
            this.month = input.readByte();
            if (this.month < 0)
            {
                throw (new Error((("Forbidden value (" + this.month) + ") on element of BasicDateMessage.month.")));
            };
            this.year = input.readShort();
            if (this.year < 0)
            {
                throw (new Error((("Forbidden value (" + this.year) + ") on element of BasicDateMessage.year.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.basic

