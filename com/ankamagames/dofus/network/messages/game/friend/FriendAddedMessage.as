package com.ankamagames.dofus.network.messages.game.friend
{
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.friend.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class FriendAddedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var friendAdded:FriendInformations;
        public static const protocolId:uint = 5599;

        public function FriendAddedMessage()
        {
            this.friendAdded = new FriendInformations();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5599;
        }// end function

        public function initFriendAddedMessage(param1:FriendInformations = null) : FriendAddedMessage
        {
            this.friendAdded = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.friendAdded = new FriendInformations();
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
            this.serializeAs_FriendAddedMessage(param1);
            return;
        }// end function

        public function serializeAs_FriendAddedMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.friendAdded.getTypeId());
            this.friendAdded.serialize(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_FriendAddedMessage(param1);
            return;
        }// end function

        public function deserializeAs_FriendAddedMessage(param1:IDataInput) : void
        {
            var _loc_2:* = param1.readUnsignedShort();
            this.friendAdded = ProtocolTypeManager.getInstance(FriendInformations, _loc_2);
            this.friendAdded.deserialize(param1);
            return;
        }// end function

    }
}
