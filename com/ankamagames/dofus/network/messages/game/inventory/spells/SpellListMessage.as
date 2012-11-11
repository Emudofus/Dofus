package com.ankamagames.dofus.network.messages.game.inventory.spells
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class SpellListMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var spellPrevisualization:Boolean = false;
        public var spells:Vector.<SpellItem>;
        public static const protocolId:uint = 1200;

        public function SpellListMessage()
        {
            this.spells = new Vector.<SpellItem>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 1200;
        }// end function

        public function initSpellListMessage(param1:Boolean = false, param2:Vector.<SpellItem> = null) : SpellListMessage
        {
            this.spellPrevisualization = param1;
            this.spells = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.spellPrevisualization = false;
            this.spells = new Vector.<SpellItem>;
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
            this.serializeAs_SpellListMessage(param1);
            return;
        }// end function

        public function serializeAs_SpellListMessage(param1:IDataOutput) : void
        {
            param1.writeBoolean(this.spellPrevisualization);
            param1.writeShort(this.spells.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.spells.length)
            {
                
                (this.spells[_loc_2] as SpellItem).serializeAs_SpellItem(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_SpellListMessage(param1);
            return;
        }// end function

        public function deserializeAs_SpellListMessage(param1:IDataInput) : void
        {
            var _loc_4:* = null;
            this.spellPrevisualization = param1.readBoolean();
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new SpellItem();
                _loc_4.deserialize(param1);
                this.spells.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
