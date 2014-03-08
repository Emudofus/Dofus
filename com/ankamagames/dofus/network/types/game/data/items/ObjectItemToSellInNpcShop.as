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
      
      public function initObjectItemToSellInNpcShop(param1:uint=0, param2:Vector.<ObjectEffect>=null, param3:uint=0, param4:String="") : ObjectItemToSellInNpcShop {
         super.initObjectItemMinimalInformation(param1,param2);
         this.objectPrice = param3;
         this.buyCriterion = param4;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.objectPrice = 0;
         this.buyCriterion = "";
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ObjectItemToSellInNpcShop(param1);
      }
      
      public function serializeAs_ObjectItemToSellInNpcShop(param1:IDataOutput) : void {
         super.serializeAs_ObjectItemMinimalInformation(param1);
         if(this.objectPrice < 0)
         {
            throw new Error("Forbidden value (" + this.objectPrice + ") on element objectPrice.");
         }
         else
         {
            param1.writeInt(this.objectPrice);
            param1.writeUTF(this.buyCriterion);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ObjectItemToSellInNpcShop(param1);
      }
      
      public function deserializeAs_ObjectItemToSellInNpcShop(param1:IDataInput) : void {
         super.deserialize(param1);
         this.objectPrice = param1.readInt();
         if(this.objectPrice < 0)
         {
            throw new Error("Forbidden value (" + this.objectPrice + ") on element of ObjectItemToSellInNpcShop.objectPrice.");
         }
         else
         {
            this.buyCriterion = param1.readUTF();
            return;
         }
      }
   }
}
