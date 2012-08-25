package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.party.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class DungeonPartyFinderRoomContentUpdateMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var dungeonId:uint = 0;
        public var addedPlayers:Vector.<DungeonPartyFinderPlayer>;
        public var removedPlayersIds:Vector.<uint>;
        public static const protocolId:uint = 6250;

        public function DungeonPartyFinderRoomContentUpdateMessage()
        {
            this.addedPlayers = new Vector.<DungeonPartyFinderPlayer>;
            this.removedPlayersIds = new Vector.<uint>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6250;
        }// end function

        public function initDungeonPartyFinderRoomContentUpdateMessage(param1:uint = 0, param2:Vector.<DungeonPartyFinderPlayer> = null, param3:Vector.<uint> = null) : DungeonPartyFinderRoomContentUpdateMessage
        {
            this.dungeonId = param1;
            this.addedPlayers = param2;
            this.removedPlayersIds = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.dungeonId = 0;
            this.addedPlayers = new Vector.<DungeonPartyFinderPlayer>;
            this.removedPlayersIds = new Vector.<uint>;
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
            this.serializeAs_DungeonPartyFinderRoomContentUpdateMessage(param1);
            return;
        }// end function

        public function serializeAs_DungeonPartyFinderRoomContentUpdateMessage(param1:IDataOutput) : void
        {
            if (this.dungeonId < 0)
            {
                throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
            }
            param1.writeShort(this.dungeonId);
            param1.writeShort(this.addedPlayers.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.addedPlayers.length)
            {
                
                (this.addedPlayers[_loc_2] as DungeonPartyFinderPlayer).serializeAs_DungeonPartyFinderPlayer(param1);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.removedPlayersIds.length);
            var _loc_3:uint = 0;
            while (_loc_3 < this.removedPlayersIds.length)
            {
                
                if (this.removedPlayersIds[_loc_3] < 0)
                {
                    throw new Error("Forbidden value (" + this.removedPlayersIds[_loc_3] + ") on element 3 (starting at 1) of removedPlayersIds.");
                }
                param1.writeInt(this.removedPlayersIds[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_DungeonPartyFinderRoomContentUpdateMessage(param1);
            return;
        }// end function

        public function deserializeAs_DungeonPartyFinderRoomContentUpdateMessage(param1:IDataInput) : void
        {
            var _loc_6:DungeonPartyFinderPlayer = null;
            var _loc_7:uint = 0;
            this.dungeonId = param1.readShort();
            if (this.dungeonId < 0)
            {
                throw new Error("Forbidden value (" + this.dungeonId + ") on element of DungeonPartyFinderRoomContentUpdateMessage.dungeonId.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_6 = new DungeonPartyFinderPlayer();
                _loc_6.deserialize(param1);
                this.addedPlayers.push(_loc_6);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:uint = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_7 = param1.readInt();
                if (_loc_7 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_7 + ") on elements of removedPlayersIds.");
                }
                this.removedPlayersIds.push(_loc_7);
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

    }
}
