package com.ankamagames.dofus.network.messages.game.report
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class CharacterReportMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var reportedId:uint = 0;
        public var reason:uint = 0;
        public static const protocolId:uint = 6079;

        public function CharacterReportMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6079;
        }// end function

        public function initCharacterReportMessage(param1:uint = 0, param2:uint = 0) : CharacterReportMessage
        {
            this.reportedId = param1;
            this.reason = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.reportedId = 0;
            this.reason = 0;
            this._isInitialized = false;
            return;
        }// end function

        override public function pack(param1:IDataOutput) : void
        {
            var _loc_2:* = new ByteArray();
            this.serialize(_loc_2);
            writePacket(param1, this.getMessageId(), _loc_2);
            return;
        }// end function

        override public function unpack(param1:IDataInput, param2:uint) : void
        {
            this.deserialize(param1);
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_CharacterReportMessage(param1);
            return;
        }// end function

        public function serializeAs_CharacterReportMessage(param1:IDataOutput) : void
        {
            if (this.reportedId < 0 || this.reportedId > 4294967295)
            {
                throw new Error("Forbidden value (" + this.reportedId + ") on element reportedId.");
            }
            param1.writeUnsignedInt(this.reportedId);
            if (this.reason < 0)
            {
                throw new Error("Forbidden value (" + this.reason + ") on element reason.");
            }
            param1.writeByte(this.reason);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_CharacterReportMessage(param1);
            return;
        }// end function

        public function deserializeAs_CharacterReportMessage(param1:IDataInput) : void
        {
            this.reportedId = param1.readUnsignedInt();
            if (this.reportedId < 0 || this.reportedId > 4294967295)
            {
                throw new Error("Forbidden value (" + this.reportedId + ") on element of CharacterReportMessage.reportedId.");
            }
            this.reason = param1.readByte();
            if (this.reason < 0)
            {
                throw new Error("Forbidden value (" + this.reason + ") on element of CharacterReportMessage.reason.");
            }
            return;
        }// end function

    }
}
