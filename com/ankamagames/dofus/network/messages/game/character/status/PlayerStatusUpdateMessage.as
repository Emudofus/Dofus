package com.ankamagames.dofus.network.messages.game.character.status
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;

    [Trusted]
    public class PlayerStatusUpdateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6386;

        private var _isInitialized:Boolean = false;
        public var accountId:uint = 0;
        public var playerId:uint = 0;
        public var status:PlayerStatus;

        public function PlayerStatusUpdateMessage()
        {
            this.status = new PlayerStatus();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6386);
        }

        public function initPlayerStatusUpdateMessage(accountId:uint=0, playerId:uint=0, status:PlayerStatus=null):PlayerStatusUpdateMessage
        {
            this.accountId = accountId;
            this.playerId = playerId;
            this.status = status;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.accountId = 0;
            this.playerId = 0;
            this.status = new PlayerStatus();
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
            this.serializeAs_PlayerStatusUpdateMessage(output);
        }

        public function serializeAs_PlayerStatusUpdateMessage(output:ICustomDataOutput):void
        {
            if (this.accountId < 0)
            {
                throw (new Error((("Forbidden value (" + this.accountId) + ") on element accountId.")));
            };
            output.writeInt(this.accountId);
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element playerId.")));
            };
            output.writeVarInt(this.playerId);
            output.writeShort(this.status.getTypeId());
            this.status.serialize(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PlayerStatusUpdateMessage(input);
        }

        public function deserializeAs_PlayerStatusUpdateMessage(input:ICustomDataInput):void
        {
            this.accountId = input.readInt();
            if (this.accountId < 0)
            {
                throw (new Error((("Forbidden value (" + this.accountId) + ") on element of PlayerStatusUpdateMessage.accountId.")));
            };
            this.playerId = input.readVarUhInt();
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element of PlayerStatusUpdateMessage.playerId.")));
            };
            var _id3:uint = input.readUnsignedShort();
            this.status = ProtocolTypeManager.getInstance(PlayerStatus, _id3);
            this.status.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.character.status

