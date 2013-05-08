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
         this.effects=new Vector.<ObjectEffect>();
         this.prices=new Vector.<uint>();
         super();
      }

      public static const protocolId:uint = 122;

      public var objectUID:uint = 0;

      public var powerRate:int = 0;

      public var overMax:Boolean = false;

      public var effects:Vector.<ObjectEffect>;

      public var prices:Vector.<uint>;

      public function getTypeId() : uint {
         return 122;
      }

      public function initBidExchangerObjectInfo(objectUID:uint=0, powerRate:int=0, overMax:Boolean=false, effects:Vector.<ObjectEffect>=null, prices:Vector.<uint>=null) : BidExchangerObjectInfo {
         this.objectUID=objectUID;
         this.powerRate=powerRate;
         this.overMax=overMax;
         this.effects=effects;
         this.prices=prices;
         return this;
      }

      public function reset() : void {
         this.objectUID=0;
         this.powerRate=0;
         this.overMax=false;
         this.effects=new Vector.<ObjectEffect>();
         this.prices=new Vector.<uint>();
      }

      public function serialize(output:IDataOutput) : void {
         this.serializeAs_BidExchangerObjectInfo(output);
      }

      public function serializeAs_BidExchangerObjectInfo(output:IDataOutput) : void {
         if(this.objectUID<0)
         {
            throw new Error("Forbidden value ("+this.objectUID+") on element objectUID.");
         }
         else
         {
            output.writeInt(this.objectUID);
            output.writeShort(this.powerRate);
            output.writeBoolean(this.overMax);
            output.writeShort(this.effects.length);
            _i4=0;
            while(_i4<this.effects.length)
            {
               output.writeShort((this.effects[_i4] as ObjectEffect).getTypeId());
               (this.effects[_i4] as ObjectEffect).serialize(output);
               _i4++;
            }
            output.writeShort(this.prices.length);
            _i5=0;
            while(_i5<this.prices.length)
            {
               if(this.prices[_i5]<0)
               {
                  throw new Error("Forbidden value ("+this.prices[_i5]+") on element 5 (starting at 1) of prices.");
               }
               else
               {
                  output.writeInt(this.prices[_i5]);
                  _i5++;
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
         var _id4:uint = 0;
         var _item4:ObjectEffect = null;
         var _val5:uint = 0;
         this.objectUID=input.readInt();
         if(this.objectUID<0)
         {
            throw new Error("Forbidden value ("+this.objectUID+") on element of BidExchangerObjectInfo.objectUID.");
         }
         else
         {
            this.powerRate=input.readShort();
            this.overMax=input.readBoolean();
            _effectsLen=input.readUnsignedShort();
            _i4=0;
            while(_i4<_effectsLen)
            {
               _id4=input.readUnsignedShort();
               _item4=ProtocolTypeManager.getInstance(ObjectEffect,_id4);
               _item4.deserialize(input);
               this.effects.push(_item4);
               _i4++;
            }
            _pricesLen=input.readUnsignedShort();
            _i5=0;
            while(_i5<_pricesLen)
            {
               _val5=input.readInt();
               if(_val5<0)
               {
                  throw new Error("Forbidden value ("+_val5+") on elements of prices.");
               }
               else
               {
                  this.prices.push(_val5);
                  _i5++;
                  continue;
               }
            }
            return;
         }
      }
   }

}