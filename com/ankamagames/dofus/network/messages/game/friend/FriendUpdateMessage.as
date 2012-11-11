package com.ankamagames.dofus.network.messages.game.friend
{
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.friend.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class FriendUpdateMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var friendUpdated:FriendInformations;
        public static const protocolId:uint = 5924;

        public function FriendUpdateMessage()
        {
            this.friendUpdated = new FriendInformations();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5924;
        }// end function

        public function initFriendUpdateMessage(param1:FriendInformations = null) : FriendUpdateMessage
        {
            this.friendUpdated = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.friendUpdated = new FriendInformations();
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
            this.serializeAs_FriendUpdateMessage(param1);
            return;
        }// end function

        public function serializeAs_FriendUpdateMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.friendUpdated.getTypeId());
            this.friendUpdated.serialize(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_FriendUpdateMessage(param1);
            return;
        }// end function

        public function deserializeAs_FriendUpdateMessage(param1:IDataInput) : void
        {
            var _loc_2:* = param1.readUnsignedShort();
            this.friendUpdated = ProtocolTypeManager.getInstance(FriendInformations, _loc_2);
            this.friendUpdated.deserialize(param1);
            return;
        }// end function

    }
}
