package com.ankamagames.dofus.network.messages.web.krosmaster
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class KrosmasterAuthTokenMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var token:String = "";
        public static const protocolId:uint = 6351;

        public function KrosmasterAuthTokenMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6351;
        }// end function

        public function initKrosmasterAuthTokenMessage(param1:String = "") : KrosmasterAuthTokenMessage
        {
            this.token = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.token = "";
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
            this.serializeAs_KrosmasterAuthTokenMessage(param1);
            return;
        }// end function

        public function serializeAs_KrosmasterAuthTokenMessage(param1:IDataOutput) : void
        {
            param1.writeUTF(this.token);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_KrosmasterAuthTokenMessage(param1);
            return;
        }// end function

        public function deserializeAs_KrosmasterAuthTokenMessage(param1:IDataInput) : void
        {
            this.token = param1.readUTF();
            return;
        }// end function

    }
}
