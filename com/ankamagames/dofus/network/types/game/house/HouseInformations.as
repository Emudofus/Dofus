package com.ankamagames.dofus.network.types.game.house
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.Vector;
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
      
      public function initHouseInformations(param1:uint=0, param2:Vector.<uint>=null, param3:String="", param4:Boolean=false, param5:Boolean=false, param6:uint=0) : HouseInformations {
         this.houseId = param1;
         this.doorsOnMap = param2;
         this.ownerName = param3;
         this.isOnSale = param4;
         this.isSaleLocked = param5;
         this.modelId = param6;
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
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_HouseInformations(param1);
      }
      
      public function serializeAs_HouseInformations(param1:IDataOutput) : void {
         var _loc2_:uint = 0;
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,0,this.isOnSale);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,1,this.isSaleLocked);
         param1.writeByte(_loc2_);
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element houseId.");
         }
         else
         {
            param1.writeInt(this.houseId);
            param1.writeShort(this.doorsOnMap.length);
            _loc3_ = 0;
            while(_loc3_ < this.doorsOnMap.length)
            {
               if(this.doorsOnMap[_loc3_] < 0)
               {
                  throw new Error("Forbidden value (" + this.doorsOnMap[_loc3_] + ") on element 2 (starting at 1) of doorsOnMap.");
               }
               else
               {
                  param1.writeInt(this.doorsOnMap[_loc3_]);
                  _loc3_++;
                  continue;
               }
            }
            param1.writeUTF(this.ownerName);
            if(this.modelId < 0)
            {
               throw new Error("Forbidden value (" + this.modelId + ") on element modelId.");
            }
            else
            {
               param1.writeShort(this.modelId);
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_HouseInformations(param1);
      }
      
      public function deserializeAs_HouseInformations(param1:IDataInput) : void {
         var _loc5_:uint = 0;
         var _loc2_:uint = param1.readByte();
         this.isOnSale = BooleanByteWrapper.getFlag(_loc2_,0);
         this.isSaleLocked = BooleanByteWrapper.getFlag(_loc2_,1);
         this.houseId = param1.readInt();
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element of HouseInformations.houseId.");
         }
         else
         {
            _loc3_ = param1.readUnsignedShort();
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc5_ = param1.readInt();
               if(_loc5_ < 0)
               {
                  throw new Error("Forbidden value (" + _loc5_ + ") on elements of doorsOnMap.");
               }
               else
               {
                  this.doorsOnMap.push(_loc5_);
                  _loc4_++;
                  continue;
               }
            }
            this.ownerName = param1.readUTF();
            this.modelId = param1.readShort();
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
