package com.ankamagames.dofus.network.types.game.house
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import flash.utils.IDataInput;
   
   public class HouseInformations extends Object implements INetworkType
   {
      
      public function HouseInformations() {
         this.doorsOnMap = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 111;
      
      public var houseId:uint = 0;
      
      public var doorsOnMap:Vector.<uint>;
      
      public var ownerName:String = "";
      
      public var isOnSale:Boolean = false;
      
      public var isSaleLocked:Boolean = false;
      
      public var modelId:uint = 0;
      
      public function getTypeId() : uint {
         return 111;
      }
      
      public function initHouseInformations(houseId:uint = 0, doorsOnMap:Vector.<uint> = null, ownerName:String = "", isOnSale:Boolean = false, isSaleLocked:Boolean = false, modelId:uint = 0) : HouseInformations {
         this.houseId = houseId;
         this.doorsOnMap = doorsOnMap;
         this.ownerName = ownerName;
         this.isOnSale = isOnSale;
         this.isSaleLocked = isSaleLocked;
         this.modelId = modelId;
         return this;
      }
      
      public function reset() : void {
         this.houseId = 0;
         this.doorsOnMap = new Vector.<uint>();
         this.ownerName = "";
         this.isOnSale = false;
         this.isSaleLocked = false;
         this.modelId = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_HouseInformations(output);
      }
      
      public function serializeAs_HouseInformations(output:IDataOutput) : void {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.isOnSale);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.isSaleLocked);
         output.writeByte(_box0);
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element houseId.");
         }
         else
         {
            output.writeInt(this.houseId);
            output.writeShort(this.doorsOnMap.length);
            _i2 = 0;
            while(_i2 < this.doorsOnMap.length)
            {
               if(this.doorsOnMap[_i2] < 0)
               {
                  throw new Error("Forbidden value (" + this.doorsOnMap[_i2] + ") on element 2 (starting at 1) of doorsOnMap.");
               }
               else
               {
                  output.writeInt(this.doorsOnMap[_i2]);
                  _i2++;
                  continue;
               }
            }
            output.writeUTF(this.ownerName);
            if(this.modelId < 0)
            {
               throw new Error("Forbidden value (" + this.modelId + ") on element modelId.");
            }
            else
            {
               output.writeShort(this.modelId);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_HouseInformations(input);
      }
      
      public function deserializeAs_HouseInformations(input:IDataInput) : void {
         var _val2:uint = 0;
         var _box0:uint = input.readByte();
         this.isOnSale = BooleanByteWrapper.getFlag(_box0,0);
         this.isSaleLocked = BooleanByteWrapper.getFlag(_box0,1);
         this.houseId = input.readInt();
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element of HouseInformations.houseId.");
         }
         else
         {
            _doorsOnMapLen = input.readUnsignedShort();
            _i2 = 0;
            while(_i2 < _doorsOnMapLen)
            {
               _val2 = input.readInt();
               if(_val2 < 0)
               {
                  throw new Error("Forbidden value (" + _val2 + ") on elements of doorsOnMap.");
               }
               else
               {
                  this.doorsOnMap.push(_val2);
                  _i2++;
                  continue;
               }
            }
            this.ownerName = input.readUTF();
            this.modelId = input.readShort();
            if(this.modelId < 0)
            {
               throw new Error("Forbidden value (" + this.modelId + ") on element of HouseInformations.modelId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
