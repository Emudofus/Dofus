package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class ObjectItemToSellInNpcShop extends ObjectItemMinimalInformation implements INetworkType
   {
      
      public function ObjectItemToSellInNpcShop() {
         super();
      }
      
      public static const protocolId:uint = 352;
      
      public var objectPrice:uint = 0;
      
      public var buyCriterion:String = "";
      
      override public function getTypeId() : uint {
         return 352;
      }
      
      public function initObjectItemToSellInNpcShop(objectGID:uint=0, effects:Vector.<ObjectEffect>=null, objectPrice:uint=0, buyCriterion:String="") : ObjectItemToSellInNpcShop {
         super.initObjectItemMinimalInformation(objectGID,effects);
         this.objectPrice = objectPrice;
         this.buyCriterion = buyCriterion;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.objectPrice = 0;
         this.buyCriterion = "";
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ObjectItemToSellInNpcShop(output);
      }
      
      public function serializeAs_ObjectItemToSellInNpcShop(output:IDataOutput) : void {
         super.serializeAs_ObjectItemMinimalInformation(output);
         if(this.objectPrice < 0)
         {
            throw new Error("Forbidden value (" + this.objectPrice + ") on element objectPrice.");
         }
         else
         {
            output.writeInt(this.objectPrice);
            output.writeUTF(this.buyCriterion);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectItemToSellInNpcShop(input);
      }
      
      public function deserializeAs_ObjectItemToSellInNpcShop(input:IDataInput) : void {
         super.deserialize(input);
         this.objectPrice = input.readInt();
         if(this.objectPrice < 0)
         {
            throw new Error("Forbidden value (" + this.objectPrice + ") on element of ObjectItemToSellInNpcShop.objectPrice.");
         }
         else
         {
            this.buyCriterion = input.readUTF();
            return;
         }
      }
   }
}
