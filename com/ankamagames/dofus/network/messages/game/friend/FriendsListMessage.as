package com.ankamagames.dofus.network.messages.game.friend
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.friend.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class FriendsListMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var friendsList:Vector.<FriendInformations>;
        public static const protocolId:uint = 4002;

        public function FriendsListMessage()
        {
            this.friendsList = new Vector.<FriendInformations>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 4002;
        }// end function

        public function initFriendsListMessage(param1:Vector.<FriendInformations> = null) : FriendsListMessage
        {
            this.friendsList = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.friendsList = new Vector.<FriendInformations>;
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
            this.serializeAs_FriendsListMessage(param1);
            return;
        }// end function

        public function serializeAs_FriendsListMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.friendsList.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.friendsList.length)
            {
                
                param1.writeShort((this.friendsList[_loc_2] as FriendInformations).getTypeId());
                (this.friendsList[_loc_2] as FriendInformations).serialize(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_FriendsListMessage(param1);
            return;
        }// end function

        public function deserializeAs_FriendsListMessage(param1:IDataInput) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readUnsignedShort();
                _loc_5 = ProtocolTypeManager.getInstance(FriendInformations, _loc_4);
                _loc_5.deserialize(param1);
                this.friendsList.push(_loc_5);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
