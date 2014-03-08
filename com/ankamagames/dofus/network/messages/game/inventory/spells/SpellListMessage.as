package com.ankamagames.dofus.network.messages.game.inventory.spells
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.data.items.SpellItem;
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
      
      public function initSpellListMessage(param1:Boolean=false, param2:Vector.<SpellItem>=null) : SpellListMessage {
         this.spellPrevisualization = param1;
         this.spells = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.spellPrevisualization = false;
         this.spells = new Vector.<SpellItem>();
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_SpellListMessage(param1);
      }
      
      public function serializeAs_SpellListMessage(param1:IDataOutput) : void {
         param1.writeBoolean(this.spellPrevisualization);
         param1.writeShort(this.spells.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.spells.length)
         {
            (this.spells[_loc2_] as SpellItem).serializeAs_SpellItem(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_SpellListMessage(param1);
      }
      
      public function deserializeAs_SpellListMessage(param1:IDataInput) : void {
         var _loc4_:SpellItem = null;
         this.spellPrevisualization = param1.readBoolean();
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new SpellItem();
            _loc4_.deserialize(param1);
            this.spells.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
