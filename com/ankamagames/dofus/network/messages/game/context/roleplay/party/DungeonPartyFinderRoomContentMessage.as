package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.party.DungeonPartyFinderPlayer;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class DungeonPartyFinderRoomContentMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6247;

        private var _isInitialized:Boolean = false;
        public var dungeonId:uint = 0;
        public var players:Vector.<DungeonPartyFinderPlayer>;

        public function DungeonPartyFinderRoomContentMessage()
        {
            this.players = new Vector.<DungeonPartyFinderPlayer>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6247);
        }

        public function initDungeonPartyFinderRoomContentMessage(dungeonId:uint=0, players:Vector.<DungeonPartyFinderPlayer>=null):DungeonPartyFinderRoomContentMessage
        {
            this.dungeonId = dungeonId;
            this.players = players;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.dungeonId = 0;
            this.players = new Vector.<DungeonPartyFinderPlayer>();
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
            this.serializeAs_DungeonPartyFinderRoomContentMessage(output);
        }

        public function serializeAs_DungeonPartyFinderRoomContentMessage(output:ICustomDataOutput):void
        {
            if (this.dungeonId < 0)
            {
                throw (new Error((("Forbidden value (" + this.dungeonId) + ") on element dungeonId.")));
            };
            output.writeVarShort(this.dungeonId);
            output.writeShort(this.players.length);
            var _i2:uint;
            while (_i2 < this.players.length)
            {
                (this.players[_i2] as DungeonPartyFinderPlayer).serializeAs_DungeonPartyFinderPlayer(output);
                _i2++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_DungeonPartyFinderRoomContentMessage(input);
        }

        public function deserializeAs_DungeonPartyFinderRoomContentMessage(input:ICustomDataInput):void
        {
            var _item2:DungeonPartyFinderPlayer;
            this.dungeonId = input.readVarUhShort();
            if (this.dungeonId < 0)
            {
                throw (new Error((("Forbidden value (" + this.dungeonId) + ") on element of DungeonPartyFinderRoomContentMessage.dungeonId.")));
            };
            var _playersLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _playersLen)
            {
                _item2 = new DungeonPartyFinderPlayer();
                _item2.deserialize(input);
                this.players.push(_item2);
                _i2++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.party

