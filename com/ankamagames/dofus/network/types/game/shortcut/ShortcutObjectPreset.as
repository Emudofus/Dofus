package com.ankamagames.dofus.network.types.game.shortcut
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class ShortcutObjectPreset extends ShortcutObject implements INetworkType
   {
      
      public function ShortcutObjectPreset() {
         super();
      }
      
      public static const protocolId:uint = 370;
      
      public var presetId:uint = 0;
      
      override public function getTypeId() : uint {
         return 370;
      }
      
      public function initShortcutObjectPreset(slot:uint=0, presetId:uint=0) : ShortcutObjectPreset {
         super.initShortcutObject(slot);
         this.presetId = presetId;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.presetId = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ShortcutObjectPreset(output);
      }
      
      public function serializeAs_ShortcutObjectPreset(output:IDataOutput) : void {
         super.serializeAs_ShortcutObject(output);
         if(this.presetId < 0)
         {
            throw new Error("Forbidden value (" + this.presetId + ") on element presetId.");
         }
         else
         {
            output.writeByte(this.presetId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ShortcutObjectPreset(input);
      }
      
      public function deserializeAs_ShortcutObjectPreset(input:IDataInput) : void {
         super.deserialize(input);
         this.presetId = input.readByte();
         if(this.presetId < 0)
         {
            throw new Error("Forbidden value (" + this.presetId + ") on element of ShortcutObjectPreset.presetId.");
         }
         else
         {
            return;
         }
      }
   }
}
