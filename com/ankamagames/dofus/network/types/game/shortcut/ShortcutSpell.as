package com.ankamagames.dofus.network.types.game.shortcut
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class ShortcutSpell extends Shortcut implements INetworkType
   {
      
      public function ShortcutSpell() {
         super();
      }
      
      public static const protocolId:uint = 368;
      
      public var spellId:uint = 0;
      
      override public function getTypeId() : uint {
         return 368;
      }
      
      public function initShortcutSpell(slot:uint = 0, spellId:uint = 0) : ShortcutSpell {
         super.initShortcut(slot);
         this.spellId = spellId;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.spellId = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ShortcutSpell(output);
      }
      
      public function serializeAs_ShortcutSpell(output:IDataOutput) : void {
         super.serializeAs_Shortcut(output);
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
         }
         else
         {
            output.writeShort(this.spellId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ShortcutSpell(input);
      }
      
      public function deserializeAs_ShortcutSpell(input:IDataInput) : void {
         super.deserialize(input);
         this.spellId = input.readShort();
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element of ShortcutSpell.spellId.");
         }
         else
         {
            return;
         }
      }
   }
}
