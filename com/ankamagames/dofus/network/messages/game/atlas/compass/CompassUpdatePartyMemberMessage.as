package com.ankamagames.dofus.network.messages.game.atlas.compass
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class CompassUpdatePartyMemberMessage extends CompassUpdateMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var memberId:uint = 0;
        public static const protocolId:uint = 5589;

        public function CompassUpdatePartyMemberMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5589;
        }// end function

        public function initCompassUpdatePartyMemberMessage(param1:uint = 0, param2:int = 0, param3:int = 0, param4:uint = 0) : CompassUpdatePartyMemberMessage
        {
            super.initCompassUpdateMessage(param1, param2, param3);
            this.memberId = param4;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.memberId = 0;
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

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_CompassUpdatePartyMemberMessage(param1);
            return;
        }// end function

        public function serializeAs_CompassUpdatePartyMemberMessage(param1:IDataOutput) : void
        {
            super.serializeAs_CompassUpdateMessage(param1);
            if (this.memberId < 0)
            {
                throw new Error("Forbidden value (" + this.memberId + ") on element memberId.");
            }
            param1.writeInt(this.memberId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_CompassUpdatePartyMemberMessage(param1);
            return;
        }// end function

        public function deserializeAs_CompassUpdatePartyMemberMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.memberId = param1.readInt();
            if (this.memberId < 0)
            {
                throw new Error("Forbidden value (" + this.memberId + ") on element of CompassUpdatePartyMemberMessage.memberId.");
            }
            return;
        }// end function

    }
}
