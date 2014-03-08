package com.ankamagames.dofus.network.types.game.house
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class AccountHouseInformations extends Object implements INetworkType
   {
      
      public function AccountHouseInformations() {
         super();
      }
      
      public static const protocolId:uint = 390;
      
      public var houseId:uint = 0;
      
      public var modelId:uint = 0;
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var mapId:int = 0;
      
      public var subAreaId:uint = 0;
      
      public function getTypeId() : uint {
         return 390;
      }
      
      public function initAccountHouseInformations(param1:uint=0, param2:uint=0, param3:int=0, param4:int=0, param5:int=0, param6:uint=0) : AccountHouseInformations {
         this.houseId = param1;
         this.modelId = param2;
         this.worldX = param3;
         this.worldY = param4;
         this.mapId = param5;
         this.subAreaId = param6;
         return this;
      }
      
      public function reset() : void {
         this.houseId = 0;
         this.modelId = 0;
         this.worldX = 0;
         this.worldY = 0;
         this.mapId = 0;
         this.subAreaId = 0;
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_AccountHouseInformations(param1);
      }
      
      public function serializeAs_AccountHouseInformations(param1:IDataOutput) : void {
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element houseId.");
         }
         else
         {
            param1.writeInt(this.houseId);
            if(this.modelId < 0)
            {
               throw new Error("Forbidden value (" + this.modelId + ") on element modelId.");
            }
            else
            {
               param1.writeShort(this.modelId);
               if(this.worldX < -255 || this.worldX > 255)
               {
                  throw new Error("Forbidden value (" + this.worldX + ") on element worldX.");
               }
               else
               {
                  param1.writeShort(this.worldX);
                  if(this.worldY < -255 || this.worldY > 255)
                  {
                     throw new Error("Forbidden value (" + this.worldY + ") on element worldY.");
                  }
                  else
                  {
                     param1.writeShort(this.worldY);
                     param1.writeInt(this.mapId);
                     if(this.subAreaId < 0)
                     {
                        throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
                     }
                     else
                     {
                        param1.writeShort(this.subAreaId);
                        return;
                     }
                  }
               }
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AccountHouseInformations(param1);
      }
      
      public function deserializeAs_AccountHouseInformations(param1:IDataInput) : void {
         this.houseId = param1.readInt();
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element of AccountHouseInformations.houseId.");
         }
         else
         {
            this.modelId = param1.readShort();
            if(this.modelId < 0)
            {
               throw new Error("Forbidden value (" + this.modelId + ") on element of AccountHouseInformations.modelId.");
            }
            else
            {
               this.worldX = param1.readShort();
               if(this.worldX < -255 || this.worldX > 255)
               {
                  throw new Error("Forbidden value (" + this.worldX + ") on element of AccountHouseInformations.worldX.");
               }
               else
               {
                  this.worldY = param1.readShort();
                  if(this.worldY < -255 || this.worldY > 255)
                  {
                     throw new Error("Forbidden value (" + this.worldY + ") on element of AccountHouseInformations.worldY.");
                  }
                  else
                  {
                     this.mapId = param1.readInt();
                     this.subAreaId = param1.readShort();
                     if(this.subAreaId < 0)
                     {
                        throw new Error("Forbidden value (" + this.subAreaId + ") on element of AccountHouseInformations.subAreaId.");
                     }
                     else
                     {
                        return;
                     }
                  }
               }
            }
         }
      }
   }
}
