package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class SpellItem extends Item implements INetworkType
   {
      
      public function SpellItem() {
         super();
      }
      
      public static const protocolId:uint = 49;
      
      public var position:uint = 0;
      
      public var spellId:int = 0;
      
      public var spellLevel:int = 0;
      
      override public function getTypeId() : uint {
         return 49;
      }
      
      public function initSpellItem(position:uint = 0, spellId:int = 0, spellLevel:int = 0) : SpellItem {
         this.position = position;
         this.spellId = spellId;
         this.spellLevel = spellLevel;
         return this;
      }
      
      override public function reset() : void {
         this.position = 0;
         this.spellId = 0;
         this.spellLevel = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_SpellItem(output);
      }
      
      public function serializeAs_SpellItem(output:IDataOutput) : void {
         super.serializeAs_Item(output);
         if((this.position < 63) || (this.position > 255))
         {
            throw new Error("Forbidden value (" + this.position + ") on element position.");
         }
         else
         {
            output.writeByte(this.position);
            output.writeInt(this.spellId);
            if((this.spellLevel < 1) || (this.spellLevel > 6))
            {
               throw new Error("Forbidden value (" + this.spellLevel + ") on element spellLevel.");
            }
            else
            {
               output.writeByte(this.spellLevel);
               return;
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_SpellItem(input);
      }
      
      public function deserializeAs_SpellItem(input:IDataInput) : void {
         super.deserialize(input);
         this.position = input.readUnsignedByte();
         if((this.position < 63) || (this.position > 255))
         {
            throw new Error("Forbidden value (" + this.position + ") on element of SpellItem.position.");
         }
         else
         {
            this.spellId = input.readInt();
            this.spellLevel = input.readByte();
            if((this.spellLevel < 1) || (this.spellLevel > 6))
            {
               throw new Error("Forbidden value (" + this.spellLevel + ") on element of SpellItem.spellLevel.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
