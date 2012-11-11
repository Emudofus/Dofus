package com.ankamagames.dofus.network.messages.game.inventory.spells
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.character.characteristic.*;
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class SlaveSwitchContextMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var summonerId:int = 0;
        public var slaveId:int = 0;
        public var slaveSpells:Vector.<SpellItem>;
        public var slaveStats:CharacterCharacteristicsInformations;
        public static const protocolId:uint = 6214;

        public function SlaveSwitchContextMessage()
        {
            this.slaveSpells = new Vector.<SpellItem>;
            this.slaveStats = new CharacterCharacteristicsInformations();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6214;
        }// end function

        public function initSlaveSwitchContextMessage(param1:int = 0, param2:int = 0, param3:Vector.<SpellItem> = null, param4:CharacterCharacteristicsInformations = null) : SlaveSwitchContextMessage
        {
            this.summonerId = param1;
            this.slaveId = param2;
            this.slaveSpells = param3;
            this.slaveStats = param4;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.summonerId = 0;
            this.slaveId = 0;
            this.slaveSpells = new Vector.<SpellItem>;
            this.slaveStats = new CharacterCharacteristicsInformations();
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
            this.serializeAs_SlaveSwitchContextMessage(param1);
            return;
        }// end function

        public function serializeAs_SlaveSwitchContextMessage(param1:IDataOutput) : void
        {
            param1.writeInt(this.summonerId);
            param1.writeInt(this.slaveId);
            param1.writeShort(this.slaveSpells.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.slaveSpells.length)
            {
                
                (this.slaveSpells[_loc_2] as SpellItem).serializeAs_SpellItem(param1);
                _loc_2 = _loc_2 + 1;
            }
            this.slaveStats.serializeAs_CharacterCharacteristicsInformations(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_SlaveSwitchContextMessage(param1);
            return;
        }// end function

        public function deserializeAs_SlaveSwitchContextMessage(param1:IDataInput) : void
        {
            var _loc_4:* = null;
            this.summonerId = param1.readInt();
            this.slaveId = param1.readInt();
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new SpellItem();
                _loc_4.deserialize(param1);
                this.slaveSpells.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            this.slaveStats = new CharacterCharacteristicsInformations();
            this.slaveStats.deserialize(param1);
            return;
        }// end function

    }
}
