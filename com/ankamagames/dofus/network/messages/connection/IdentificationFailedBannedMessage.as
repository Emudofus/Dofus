package com.ankamagames.dofus.network.messages.connection
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class IdentificationFailedBannedMessage extends IdentificationFailedMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6174;

        private var _isInitialized:Boolean = false;
        public var banEndDate:Number = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6174);
        }

        public function initIdentificationFailedBannedMessage(reason:uint=99, banEndDate:Number=0):IdentificationFailedBannedMessage
        {
            super.initIdentificationFailedMessage(reason);
            this.banEndDate = banEndDate;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.banEndDate = 0;
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

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_IdentificationFailedBannedMessage(output);
        }

        public function serializeAs_IdentificationFailedBannedMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_IdentificationFailedMessage(output);
            if ((((this.banEndDate < 0)) || ((this.banEndDate > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.banEndDate) + ") on element banEndDate.")));
            };
            output.writeDouble(this.banEndDate);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_IdentificationFailedBannedMessage(input);
        }

        public function deserializeAs_IdentificationFailedBannedMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.banEndDate = input.readDouble();
            if ((((this.banEndDate < 0)) || ((this.banEndDate > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.banEndDate) + ") on element of IdentificationFailedBannedMessage.banEndDate.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.connection

