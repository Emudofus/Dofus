package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class BidExchangerObjectInfo extends Object implements INetworkType
   {
      
      public function BidExchangerObjectInfo()
      {
         this.effects = new Vector.<ObjectEffect>();
         this.prices = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 122;
      
      public var objectUID:uint = 0;
      
      public var effects:Vector.<ObjectEffect>;
      
      public var prices:Vector.<uint>;
      
      public function getTypeId() : uint
      {
         return 122;
      }
      
      public function initBidExchangerObjectInfo(param1:uint = 0, param2:Vector.<ObjectEffect> = null, param3:Vector.<uint> = null) : BidExchangerObjectInfo
      {
         this.objectUID = param1;
         this.effects = param2;
         this.prices = param3;
         return this;
      }
      
      public function reset() : void
      {
         this.objectUID = 0;
         this.effects = new Vector.<ObjectEffect>();
         this.prices = new Vector.<uint>();
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_BidExchangerObjectInfo(param1);
      }
      
      public function serializeAs_BidExchangerObjectInfo(param1:ICustomDataOutput) : void
      {
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
         }
         else
         {
            param1.writeVarInt(this.objectUID);
            param1.writeShort(this.effects.length);
            var _loc2_:uint = 0;
            while(_loc2_ < this.effects.length)
            {
               param1.writeShort((this.effects[_loc2_] as ObjectEffect).getTypeId());
               (this.effects[_loc2_] as ObjectEffect).serialize(param1);
               _loc2_++;
            }
            param1.writeShort(this.prices.length);
            var _loc3_:uint = 0;
            while(_loc3_ < this.prices.length)
            {
               if(this.prices[_loc3_] < 0)
               {
                  throw new Error("Forbidden value (" + this.prices[_loc3_] + ") on element 3 (starting at 1) of prices.");
               }
               else
               {
                  param1.writeInt(this.prices[_loc3_]);
                  _loc3_++;
                  continue;
               }
            }
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_BidExchangerObjectInfo(param1);
      }
      
      public function deserializeAs_BidExchangerObjectInfo(param1:ICustomDataInput) : void
      {
         var _loc6_:uint = 0;
         var _loc7_:ObjectEffect = null;
         var _loc8_:uint = 0;
         this.objectUID = param1.readVarUhInt();
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element of BidExchangerObjectInfo.objectUID.");
         }
         else
         {
            var _loc2_:uint = param1.readUnsignedShort();
            var _loc3_:uint = 0;
            while(_loc3_ < _loc2_)
            {
               _loc6_ = param1.readUnsignedShort();
               _loc7_ = ProtocolTypeManager.getInstance(ObjectEffect,_loc6_);
               _loc7_.deserialize(param1);
               this.effects.push(_loc7_);
               _loc3_++;
            }
            var _loc4_:uint = param1.readUnsignedShort();
            var _loc5_:uint = 0;
            while(_loc5_ < _loc4_)
            {
               _loc8_ = param1.readInt();
               if(_loc8_ < 0)
               {
                  throw new Error("Forbidden value (" + _loc8_ + ") on elements of prices.");
               }
               else
               {
                  this.prices.push(_loc8_);
                  _loc5_++;
                  continue;
               }
            }
            return;
         }
      }
   }
}
