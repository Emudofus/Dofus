package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.jerakine.network.INetworkType;
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
      
      public function initBidExchangerObjectInfo(objectUID:uint = 0, effects:Vector.<ObjectEffect> = null, prices:Vector.<uint> = null) : BidExchangerObjectInfo {
         this.objectUID = objectUID;
         this.effects = effects;
         this.prices = prices;
         return this;
      }
      
      public function reset() : void {
         this.objectUID = 0;
         this.effects = new Vector.<ObjectEffect>();
         this.prices = new Vector.<uint>();
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_BidExchangerObjectInfo(output);
      }
      
      public function serializeAs_BidExchangerObjectInfo(output:IDataOutput) : void {
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
         }
         else
         {
            output.writeInt(this.objectUID);
            output.writeShort(this.effects.length);
            _i2 = 0;
            while(_i2 < this.effects.length)
            {
               output.writeShort((this.effects[_i2] as ObjectEffect).getTypeId());
               (this.effects[_i2] as ObjectEffect).serialize(output);
               _i2++;
            }
            output.writeShort(this.prices.length);
            _i3 = 0;
            while(_i3 < this.prices.length)
            {
               if(this.prices[_i3] < 0)
               {
                  throw new Error("Forbidden value (" + this.prices[_i3] + ") on element 3 (starting at 1) of prices.");
               }
               else
               {
                  output.writeInt(this.prices[_i3]);
                  _i3++;
                  continue;
               }
            }
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_BidExchangerObjectInfo(input);
      }
      
      public function deserializeAs_BidExchangerObjectInfo(input:IDataInput) : void {
         var _id2:uint = 0;
         var _item2:ObjectEffect = null;
         var _val3:uint = 0;
         this.objectUID = input.readInt();
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element of BidExchangerObjectInfo.objectUID.");
         }
         else
         {
            _effectsLen = input.readUnsignedShort();
            _i2 = 0;
            while(_i2 < _effectsLen)
            {
               _id2 = input.readUnsignedShort();
               _item2 = ProtocolTypeManager.getInstance(ObjectEffect,_id2);
               _item2.deserialize(input);
               this.effects.push(_item2);
               _i2++;
            }
            _pricesLen = input.readUnsignedShort();
            _i3 = 0;
            while(_i3 < _pricesLen)
            {
               _val3 = input.readInt();
               if(_val3 < 0)
               {
                  throw new Error("Forbidden value (" + _val3 + ") on elements of prices.");
               }
               else
               {
                  this.prices.push(_val3);
                  _i3++;
                  continue;
               }
            }
            return;
         }
      }
   }
}
