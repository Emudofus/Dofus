package com.ankamagames.dofus.network.types.game.paddock
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.ObjectItemInRolePlay;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.mount.ItemDurability;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class PaddockItem extends ObjectItemInRolePlay implements INetworkType
   {
      
      public function PaddockItem() {
         this.durability = new ItemDurability();
         super();
      }
      
      public static const protocolId:uint = 185;
      
      public var durability:ItemDurability;
      
      override public function getTypeId() : uint {
         return 185;
      }
      
      public function initPaddockItem(cellId:uint=0, objectGID:uint=0, durability:ItemDurability=null) : PaddockItem {
         super.initObjectItemInRolePlay(cellId,objectGID);
         this.durability = durability;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.durability = new ItemDurability();
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_PaddockItem(output);
      }
      
      public function serializeAs_PaddockItem(output:IDataOutput) : void {
         super.serializeAs_ObjectItemInRolePlay(output);
         this.durability.serializeAs_ItemDurability(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PaddockItem(input);
      }
      
      public function deserializeAs_PaddockItem(input:IDataInput) : void {
         super.deserialize(input);
         this.durability = new ItemDurability();
         this.durability.deserialize(input);
      }
   }
}
