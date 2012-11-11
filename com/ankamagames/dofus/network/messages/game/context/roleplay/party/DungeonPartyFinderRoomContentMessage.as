package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.party.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class DungeonPartyFinderRoomContentMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var dungeonId:uint = 0;
        public var players:Vector.<DungeonPartyFinderPlayer>;
        public static const protocolId:uint = 6247;

        public function DungeonPartyFinderRoomContentMessage()
        {
            this.players = new Vector.<DungeonPartyFinderPlayer>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6247;
        }// end function

        public function initDungeonPartyFinderRoomContentMessage(param1:uint = 0, param2:Vector.<DungeonPartyFinderPlayer> = null) : DungeonPartyFinderRoomContentMessage
        {
            this.dungeonId = param1;
            this.players = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.dungeonId = 0;
            this.players = new Vector.<DungeonPartyFinderPlayer>;
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
            this.serializeAs_DungeonPartyFinderRoomContentMessage(param1);
            return;
        }// end function

        public function serializeAs_DungeonPartyFinderRoomContentMessage(param1:IDataOutput) : void
        {
            if (this.dungeonId < 0)
            {
                throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
            }
            param1.writeShort(this.dungeonId);
            param1.writeShort(this.players.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.players.length)
            {
                
                (this.players[_loc_2] as DungeonPartyFinderPlayer).serializeAs_DungeonPartyFinderPlayer(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_DungeonPartyFinderRoomContentMessage(param1);
            return;
        }// end function

        public function deserializeAs_DungeonPartyFinderRoomContentMessage(param1:IDataInput) : void
        {
            var _loc_4:* = null;
            this.dungeonId = param1.readShort();
            if (this.dungeonId < 0)
            {
                throw new Error("Forbidden value (" + this.dungeonId + ") on element of DungeonPartyFinderRoomContentMessage.dungeonId.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new DungeonPartyFinderPlayer();
                _loc_4.deserialize(param1);
                this.players.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
