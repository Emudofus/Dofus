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

      public function initObjectItemToSellInBid(objectGID:uint=0, powerRate:int=0, overMax:Boolean=false, effects:Vector.<ObjectEffect>=null, objectUID:uint=0, quantity:uint=0, objectPrice:uint=0, unsoldDelay:uint=0) : ObjectItemToSellInBid {
         super.initObjectItemToSell(objectGID,powerRate,overMax,effects,objectUID,quantity,objectPrice);
         this.unsoldDelay=unsoldDelay;
         return this;
      }

      override public function reset() : void {
         super.reset();
         this.unsoldDelay=0;
      }

      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ObjectItemToSellInBid(output);
      }

      public function serializeAs_ObjectItemToSellInBid(output:IDataOutput) : void {
         super.serializeAs_ObjectItemToSell(output);
         if(this.unsoldDelay<0)
         {
            throw new Error("Forbidden value ("+this.unsoldDelay+") on element unsoldDelay.");
         }
         else
         {
            output.writeShort(this.unsoldDelay);
            return;
         }
      }

      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectItemToSellInBid(input);
      }

      public function deserializeAs_ObjectItemToSellInBid(input:IDataInput) : void {
         super.deserialize(input);
         this.unsoldDelay=input.readShort();
         if(this.unsoldDelay<0)
         {
            throw new Error("Forbidden value ("+this.unsoldDelay+") on element of ObjectItemToSellInBid.unsoldDelay.");
         }
         else
         {
            return;
         }
      }
   }

}