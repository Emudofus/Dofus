package com.ankamagames.dofus.network.types.game.shortcut
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class Shortcut extends Object implements INetworkType
   {
      
      public function Shortcut() {
         super();
      }
      
      public static const protocolId:uint = 369;
      
      public var slot:uint = 0;
      
      public function getTypeId() : uint {
         return 369;
      }
      
      public function initShortcut(slot:uint=0) : Shortcut {
         this.slot = slot;
         return this;
      }
      
      public function reset() : void {
         this.slot = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_Shortcut(output);
      }
      
      public function serializeAs_Shortcut(output:IDataOutput) : void {
         if((this.slot < 0) || (this.slot > 99))
         {
            throw new Error("Forbidden value (" + this.slot + ") on element slot.");
         }
         else
         {
            output.writeInt(this.slot);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_Shortcut(input);
      }
      
      public function deserializeAs_Shortcut(input:IDataInput) : void {
         this.slot = input.readInt();
         if((this.slot < 0) || (this.slot > 99))
         {
            throw new Error("Forbidden value (" + this.slot + ") on element of Shortcut.slot.");
         }
         else
         {
            return;
         }
      }
   }
}
