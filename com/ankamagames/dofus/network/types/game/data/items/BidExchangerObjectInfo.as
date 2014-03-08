package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class BidExchangerObjectInfo extends Object implements INetworkType
   {
      
      public function BidExchangerObjectInfo() {
         this.effects = new Vector.<ObjectEffect>();
         this.prices = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 122;
      
      public var objectUID:uint = 0;
      
      public var effects:Vector.<ObjectEffect>;
      
      public var prices:Vector.<uint>;
      
      public function getTypeId() : uint {
         return 122;
      }
      
      public function initBidExchangerObjectInfo(param1:uint=0, param2:Vector.<ObjectEffect>=null, param3:Vector.<uint>=null) : BidExchangerObjectInfo {
         this.objectUID = param1;
         this.effects = param2;
         this.prices = param3;
         return this;
      }
      
      public function reset() : void {
         this.objectUID = 0;
         this.effects = new Vector.<ObjectEffect>();
         this.prices = new Vector.<uint>();
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_BidExchangerObjectInfo(param1);
      }
      
      public function serializeAs_BidExchangerObjectInfo(param1:IDataOutput) : void {
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
         }
         else
         {
            param1.writeInt(this.objectUID);
            param1.writeShort(this.effects.length);
            _loc2_ = 0;
            while(_loc2_ < this.effects.length)
            {
               param1.writeShort((this.effects[_loc2_] as ObjectEffect).getTypeId());
               (this.effects[_loc2_] as ObjectEffect).serialize(param1);
               _loc2_++;
            }
            param1.writeShort(this.prices.length);
            _loc3_ = 0;
            loop1:
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
                  continue loop1;
               }
            }
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_BidExchangerObjectInfo(param1);
      }
      
      public function deserializeAs_BidExchangerObjectInfo(param1:IDataInput) : void {
         var _loc6_:uint = 0;
         var _loc7_:ObjectEffect = null;
         var _loc8_:uint = 0;
         this.objectUID = param1.readInt();
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element of BidExchangerObjectInfo.objectUID.");
         }
         else
         {
            _loc2_ = param1.readUnsignedShort();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc6_ = param1.readUnsignedShort();
               _loc7_ = ProtocolTypeManager.getInstance(ObjectEffect,_loc6_);
               _loc7_.deserialize(param1);
               this.effects.push(_loc7_);
               _loc3_++;
            }
            _loc4_ = param1.readUnsignedShort();
            _loc5_ = 0;
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
