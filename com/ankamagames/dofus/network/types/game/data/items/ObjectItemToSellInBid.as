package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class ObjectItemToSellInBid extends ObjectItemToSell implements INetworkType
   {
      
      public function ObjectItemToSellInBid() {
         super();
      }
      
      public static const protocolId:uint = 164;
      
      public var unsoldDelay:uint = 0;
      
      override public function getTypeId() : uint {
         return 164;
      }
      
      public function initObjectItemToSellInBid(param1:uint=0, param2:Vector.<ObjectEffect>=null, param3:uint=0, param4:uint=0, param5:uint=0, param6:uint=0) : ObjectItemToSellInBid {
         super.initObjectItemToSell(param1,param2,param3,param4,param5);
         this.unsoldDelay = param6;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.unsoldDelay = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ObjectItemToSellInBid(param1);
      }
      
      public function serializeAs_ObjectItemToSellInBid(param1:IDataOutput) : void {
         super.serializeAs_ObjectItemToSell(param1);
         if(this.unsoldDelay < 0)
         {
            throw new Error("Forbidden value (" + this.unsoldDelay + ") on element unsoldDelay.");
         }
         else
         {
            param1.writeInt(this.unsoldDelay);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ObjectItemToSellInBid(param1);
      }
      
      public function deserializeAs_ObjectItemToSellInBid(param1:IDataInput) : void {
         super.deserialize(param1);
         this.unsoldDelay = param1.readInt();
         if(this.unsoldDelay < 0)
         {
            throw new Error("Forbidden value (" + this.unsoldDelay + ") on element of ObjectItemToSellInBid.unsoldDelay.");
         }
         else
         {
            return;
         }
      }
   }
}
