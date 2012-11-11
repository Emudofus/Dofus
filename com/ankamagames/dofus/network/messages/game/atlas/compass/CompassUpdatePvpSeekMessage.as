package com.ankamagames.dofus.network.messages.game.atlas.compass
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class CompassUpdatePvpSeekMessage extends CompassUpdateMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var memberId:uint = 0;
        public var memberName:String = "";
        public static const protocolId:uint = 6013;

        public function CompassUpdatePvpSeekMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6013;
        }// end function

        public function initCompassUpdatePvpSeekMessage(param1:uint = 0, param2:int = 0, param3:int = 0, param4:uint = 0, param5:String = "") : CompassUpdatePvpSeekMessage
        {
            super.initCompassUpdateMessage(param1, param2, param3);
            this.memberId = param4;
            this.memberName = param5;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.memberId = 0;
            this.memberName = "";
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
            this.serializeAs_CompassUpdatePvpSeekMessage(param1);
            return;
        }// end function

        public function serializeAs_CompassUpdatePvpSeekMessage(param1:IDataOutput) : void
        {
            super.serializeAs_CompassUpdateMessage(param1);
            if (this.memberId < 0)
            {
                throw new Error("Forbidden value (" + this.memberId + ") on element memberId.");
            }
            param1.writeInt(this.memberId);
            param1.writeUTF(this.memberName);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_CompassUpdatePvpSeekMessage(param1);
            return;
        }// end function

        public function deserializeAs_CompassUpdatePvpSeekMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.memberId = param1.readInt();
            if (this.memberId < 0)
            {
                throw new Error("Forbidden value (" + this.memberId + ") on element of CompassUpdatePvpSeekMessage.memberId.");
            }
            this.memberName = param1.readUTF();
            return;
        }// end function

    }
}
