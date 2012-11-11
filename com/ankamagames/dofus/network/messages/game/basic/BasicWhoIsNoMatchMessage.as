package com.ankamagames.dofus.network.messages.game.basic
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class BasicWhoIsNoMatchMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var search:String = "";
        public static const protocolId:uint = 179;

        public function BasicWhoIsNoMatchMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 179;
        }// end function

        public function initBasicWhoIsNoMatchMessage(param1:String = "") : BasicWhoIsNoMatchMessage
        {
            this.search = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.search = "";
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
            this.serializeAs_BasicWhoIsNoMatchMessage(param1);
            return;
        }// end function

        public function serializeAs_BasicWhoIsNoMatchMessage(param1:IDataOutput) : void
        {
            param1.writeUTF(this.search);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_BasicWhoIsNoMatchMessage(param1);
            return;
        }// end function

        public function deserializeAs_BasicWhoIsNoMatchMessage(param1:IDataInput) : void
        {
            this.search = param1.readUTF();
            return;
        }// end function

    }
}
