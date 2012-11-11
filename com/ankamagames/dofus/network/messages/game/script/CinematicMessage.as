package com.ankamagames.dofus.network.messages.game.script
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class CinematicMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var cinematicId:uint = 0;
        public static const protocolId:uint = 6053;

        public function CinematicMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6053;
        }// end function

        public function initCinematicMessage(param1:uint = 0) : CinematicMessage
        {
            this.cinematicId = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.cinematicId = 0;
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
            this.serializeAs_CinematicMessage(param1);
            return;
        }// end function

        public function serializeAs_CinematicMessage(param1:IDataOutput) : void
        {
            if (this.cinematicId < 0)
            {
                throw new Error("Forbidden value (" + this.cinematicId + ") on element cinematicId.");
            }
            param1.writeShort(this.cinematicId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_CinematicMessage(param1);
            return;
        }// end function

        public function deserializeAs_CinematicMessage(param1:IDataInput) : void
        {
            this.cinematicId = param1.readShort();
            if (this.cinematicId < 0)
            {
                throw new Error("Forbidden value (" + this.cinematicId + ") on element of CinematicMessage.cinematicId.");
            }
            return;
        }// end function

    }
}
