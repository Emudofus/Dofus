package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.quest.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class MapNpcsQuestStatusUpdateMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var mapId:int = 0;
        public var npcsIdsWithQuest:Vector.<int>;
        public var questFlags:Vector.<GameRolePlayNpcQuestFlag>;
        public var npcsIdsWithoutQuest:Vector.<int>;
        public static const protocolId:uint = 5642;

        public function MapNpcsQuestStatusUpdateMessage()
        {
            this.npcsIdsWithQuest = new Vector.<int>;
            this.questFlags = new Vector.<GameRolePlayNpcQuestFlag>;
            this.npcsIdsWithoutQuest = new Vector.<int>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5642;
        }// end function

        public function initMapNpcsQuestStatusUpdateMessage(param1:int = 0, param2:Vector.<int> = null, param3:Vector.<GameRolePlayNpcQuestFlag> = null, param4:Vector.<int> = null) : MapNpcsQuestStatusUpdateMessage
        {
            this.mapId = param1;
            this.npcsIdsWithQuest = param2;
            this.questFlags = param3;
            this.npcsIdsWithoutQuest = param4;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.mapId = 0;
            this.npcsIdsWithQuest = new Vector.<int>;
            this.questFlags = new Vector.<GameRolePlayNpcQuestFlag>;
            this.npcsIdsWithoutQuest = new Vector.<int>;
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
            this.serializeAs_MapNpcsQuestStatusUpdateMessage(param1);
            return;
        }// end function

        public function serializeAs_MapNpcsQuestStatusUpdateMessage(param1:IDataOutput) : void
        {
            param1.writeInt(this.mapId);
            param1.writeShort(this.npcsIdsWithQuest.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.npcsIdsWithQuest.length)
            {
                
                param1.writeInt(this.npcsIdsWithQuest[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.questFlags.length);
            var _loc_3:* = 0;
            while (_loc_3 < this.questFlags.length)
            {
                
                (this.questFlags[_loc_3] as GameRolePlayNpcQuestFlag).serializeAs_GameRolePlayNpcQuestFlag(param1);
                _loc_3 = _loc_3 + 1;
            }
            param1.writeShort(this.npcsIdsWithoutQuest.length);
            var _loc_4:* = 0;
            while (_loc_4 < this.npcsIdsWithoutQuest.length)
            {
                
                param1.writeInt(this.npcsIdsWithoutQuest[_loc_4]);
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_MapNpcsQuestStatusUpdateMessage(param1);
            return;
        }// end function

        public function deserializeAs_MapNpcsQuestStatusUpdateMessage(param1:IDataInput) : void
        {
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            this.mapId = param1.readInt();
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_8 = param1.readInt();
                this.npcsIdsWithQuest.push(_loc_8);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_9 = new GameRolePlayNpcQuestFlag();
                _loc_9.deserialize(param1);
                this.questFlags.push(_loc_9);
                _loc_5 = _loc_5 + 1;
            }
            var _loc_6:* = param1.readUnsignedShort();
            var _loc_7:* = 0;
            while (_loc_7 < _loc_6)
            {
                
                _loc_10 = param1.readInt();
                this.npcsIdsWithoutQuest.push(_loc_10);
                _loc_7 = _loc_7 + 1;
            }
            return;
        }// end function

    }
}
