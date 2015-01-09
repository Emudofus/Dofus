package com.ankamagames.dofus.network.messages.game.friend
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.friend.FriendInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;

    [Trusted]
    public class FriendUpdateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5924;

        private var _isInitialized:Boolean = false;
        public var friendUpdated:FriendInformations;

        public function FriendUpdateMessage()
        {
            this.friendUpdated = new FriendInformations();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5924);
        }

        public function initFriendUpdateMessage(friendUpdated:FriendInformations=null):FriendUpdateMessage
        {
            this.friendUpdated = friendUpdated;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.friendUpdated = new FriendInformations();
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_FriendUpdateMessage(output);
        }

        public function serializeAs_FriendUpdateMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.friendUpdated.getTypeId());
            this.friendUpdated.serialize(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_FriendUpdateMessage(input);
        }

        public function deserializeAs_FriendUpdateMessage(input:ICustomDataInput):void
        {
            var _id1:uint = input.readUnsignedShort();
            this.friendUpdated = ProtocolTypeManager.getInstance(FriendInformations, _id1);
            this.friendUpdated.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.friend

