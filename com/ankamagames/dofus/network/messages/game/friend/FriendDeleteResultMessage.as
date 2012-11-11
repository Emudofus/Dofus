package com.ankamagames.dofus.network.messages.game.friend
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class FriendDeleteResultMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var success:Boolean = false;
        public var name:String = "";
        public static const protocolId:uint = 5601;

        public function FriendDeleteResultMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5601;
        }// end function

        public function initFriendDeleteResultMessage(param1:Boolean = false, param2:String = "") : FriendDeleteResultMessage
        {
            this.success = param1;
            this.name = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.success = false;
            this.name = "";
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
            this.serializeAs_FriendDeleteResultMessage(param1);
            return;
        }// end function

        public function serializeAs_FriendDeleteResultMessage(param1:IDataOutput) : void
        {
            param1.writeBoolean(this.success);
            param1.writeUTF(this.name);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_FriendDeleteResultMessage(param1);
            return;
        }// end function

        public function deserializeAs_FriendDeleteResultMessage(param1:IDataInput) : void
        {
            this.success = param1.readBoolean();
            this.name = param1.readUTF();
            return;
        }// end function

    }
}
