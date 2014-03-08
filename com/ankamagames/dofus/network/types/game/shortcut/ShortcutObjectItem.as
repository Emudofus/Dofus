package com.ankamagames.dofus.network.types.game.shortcut
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class ShortcutObjectItem extends ShortcutObject implements INetworkType
   {
      
      public function ShortcutObjectItem() {
         super();
      }
      
      public static const protocolId:uint = 371;
      
      public var itemUID:int = 0;
      
      public var itemGID:int = 0;
      
      override public function getTypeId() : uint {
         return 371;
      }
      
      public function initShortcutObjectItem(slot:uint=0, itemUID:int=0, itemGID:int=0) : ShortcutObjectItem {
         super.initShortcutObject(slot);
         this.itemUID = itemUID;
         this.itemGID = itemGID;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.itemUID = 0;
         this.itemGID = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ShortcutObjectItem(output);
      }
      
      public function serializeAs_ShortcutObjectItem(output:IDataOutput) : void {
         super.serializeAs_ShortcutObject(output);
         output.writeInt(this.itemUID);
         output.writeInt(this.itemGID);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ShortcutObjectItem(input);
      }
      
      public function deserializeAs_ShortcutObjectItem(input:IDataInput) : void {
         super.deserialize(input);
         this.itemUID = input.readInt();
         this.itemGID = input.readInt();
      }
   }
}
