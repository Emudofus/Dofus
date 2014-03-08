package com.ankamagames.dofus.network.messages.game.inventory.spells
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.data.items.SpellItem;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class SpellListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function SpellListMessage() {
         this.spells = new Vector.<SpellItem>();
         super();
      }
      
      public static const protocolId:uint = 1200;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var spellPrevisualization:Boolean = false;
      
      public var spells:Vector.<SpellItem>;
      
      override public function getMessageId() : uint {
         return 1200;
      }
      
      public function initSpellListMessage(spellPrevisualization:Boolean=false, spells:Vector.<SpellItem>=null) : SpellListMessage {
         this.spellPrevisualization = spellPrevisualization;
         this.spells = spells;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.spellPrevisualization = false;
         this.spells = new Vector.<SpellItem>();
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_SpellListMessage(output);
      }
      
      public function serializeAs_SpellListMessage(output:IDataOutput) : void {
         output.writeBoolean(this.spellPrevisualization);
         output.writeShort(this.spells.length);
         var _i2:uint = 0;
         while(_i2 < this.spells.length)
         {
            (this.spells[_i2] as SpellItem).serializeAs_SpellItem(output);
            _i2++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_SpellListMessage(input);
      }
      
      public function deserializeAs_SpellListMessage(input:IDataInput) : void {
         var _item2:SpellItem = null;
         this.spellPrevisualization = input.readBoolean();
         var _spellsLen:uint = input.readUnsignedShort();
         var _i2:uint = 0;
         while(_i2 < _spellsLen)
         {
            _item2 = new SpellItem();
            _item2.deserialize(input);
            this.spells.push(_item2);
            _i2++;
         }
      }
   }
}
