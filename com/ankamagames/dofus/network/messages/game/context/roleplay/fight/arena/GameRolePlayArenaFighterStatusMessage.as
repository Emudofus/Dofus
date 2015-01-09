package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameRolePlayArenaFighterStatusMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6281;

        private var _isInitialized:Boolean = false;
        public var fightId:int = 0;
        public var playerId:uint = 0;
        public var accepted:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6281);
        }

        public function initGameRolePlayArenaFighterStatusMessage(fightId:int=0, playerId:uint=0, accepted:Boolean=false):GameRolePlayArenaFighterStatusMessage
        {
            this.fightId = fightId;
            this.playerId = playerId;
            this.accepted = accepted;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.fightId = 0;
            this.playerId = 0;
            this.accepted = false;
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
            this.serializeAs_GameRolePlayArenaFighterStatusMessage(output);
        }

        public function serializeAs_GameRolePlayArenaFighterStatusMessage(output:ICustomDataOutput):void
        {
            output.writeInt(this.fightId);
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element playerId.")));
            };
            output.writeVarInt(this.playerId);
            output.writeBoolean(this.accepted);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameRolePlayArenaFighterStatusMessage(input);
        }

        public function deserializeAs_GameRolePlayArenaFighterStatusMessage(input:ICustomDataInput):void
        {
            this.fightId = input.readInt();
            this.playerId = input.readVarUhInt();
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element of GameRolePlayArenaFighterStatusMessage.playerId.")));
            };
            this.accepted = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena

