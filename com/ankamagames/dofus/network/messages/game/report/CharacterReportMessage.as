package com.ankamagames.dofus.network.messages.game.report
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class CharacterReportMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6079;

        private var _isInitialized:Boolean = false;
        public var reportedId:uint = 0;
        public var reason:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6079);
        }

        public function initCharacterReportMessage(reportedId:uint=0, reason:uint=0):CharacterReportMessage
        {
            this.reportedId = reportedId;
            this.reason = reason;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.reportedId = 0;
            this.reason = 0;
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
            this.serializeAs_CharacterReportMessage(output);
        }

        public function serializeAs_CharacterReportMessage(output:ICustomDataOutput):void
        {
            if (this.reportedId < 0)
            {
                throw (new Error((("Forbidden value (" + this.reportedId) + ") on element reportedId.")));
            };
            output.writeVarInt(this.reportedId);
            if (this.reason < 0)
            {
                throw (new Error((("Forbidden value (" + this.reason) + ") on element reason.")));
            };
            output.writeByte(this.reason);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CharacterReportMessage(input);
        }

        public function deserializeAs_CharacterReportMessage(input:ICustomDataInput):void
        {
            this.reportedId = input.readVarUhInt();
            if (this.reportedId < 0)
            {
                throw (new Error((("Forbidden value (" + this.reportedId) + ") on element of CharacterReportMessage.reportedId.")));
            };
            this.reason = input.readByte();
            if (this.reason < 0)
            {
                throw (new Error((("Forbidden value (" + this.reason) + ") on element of CharacterReportMessage.reason.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.report

