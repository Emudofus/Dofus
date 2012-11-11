package com.ankamagames.dofus.network.messages.web.krosmaster
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class KrosmasterPlayingStatusMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var playing:Boolean = false;
        public static const protocolId:uint = 6347;

        public function KrosmasterPlayingStatusMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6347;
        }// end function

        public function initKrosmasterPlayingStatusMessage(param1:Boolean = false) : KrosmasterPlayingStatusMessage
        {
            this.playing = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.playing = false;
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
            this.serializeAs_KrosmasterPlayingStatusMessage(param1);
            return;
        }// end function

        public function serializeAs_KrosmasterPlayingStatusMessage(param1:IDataOutput) : void
        {
            param1.writeBoolean(this.playing);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_KrosmasterPlayingStatusMessage(param1);
            return;
        }// end function

        public function deserializeAs_KrosmasterPlayingStatusMessage(param1:IDataInput) : void
        {
            this.playing = param1.readBoolean();
            return;
        }// end function

    }
}
