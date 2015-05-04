package com.ankamagames.dofus.network.types.game.house
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class HouseInformationsInside extends Object implements INetworkType
   {
      
      public function HouseInformationsInside()
      {
         super();
      }
      
      public static const protocolId:uint = 218;
      
      public var houseId:uint = 0;
      
      public var modelId:uint = 0;
      
      public var ownerId:int = 0;
      
      public var ownerName:String = "";
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var price:uint = 0;
      
      public var isLocked:Boolean = false;
      
      public function getTypeId() : uint
      {
         return 218;
      }
      
      public function initHouseInformationsInside(param1:uint = 0, param2:uint = 0, param3:int = 0, param4:String = "", param5:int = 0, param6:int = 0, param7:uint = 0, param8:Boolean = false) : HouseInformationsInside
      {
         this.houseId = param1;
         this.modelId = param2;
         this.ownerId = param3;
         this.ownerName = param4;
         this.worldX = param5;
         this.worldY = param6;
         this.price = param7;
         this.isLocked = param8;
         return this;
      }
      
      public function reset() : void
      {
         this.houseId = 0;
         this.modelId = 0;
         this.ownerId = 0;
         this.ownerName = "";
         this.worldX = 0;
         this.worldY = 0;
         this.price = 0;
         this.isLocked = false;
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_HouseInformationsInside(param1);
      }
      
      public function serializeAs_HouseInformationsInside(param1:ICustomDataOutput) : void
      {
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element houseId.");
         }
         else
         {
            param1.writeVarInt(this.houseId);
            if(this.modelId < 0)
            {
               throw new Error("Forbidden value (" + this.modelId + ") on element modelId.");
            }
            else
            {
               param1.writeVarShort(this.modelId);
               param1.writeInt(this.ownerId);
               param1.writeUTF(this.ownerName);
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
                     if(this.price < 0)
                     {
                        throw new Error("Forbidden value (" + this.price + ") on element price.");
                     }
                     else
                     {
                        param1.writeInt(this.price);
                        param1.writeBoolean(this.isLocked);
                        return;
                     }
                  }
               }
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_HouseInformationsInside(param1);
      }
      
      public function deserializeAs_HouseInformationsInside(param1:ICustomDataInput) : void
      {
         this.houseId = param1.readVarUhInt();
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element of HouseInformationsInside.houseId.");
         }
         else
         {
            this.modelId = param1.readVarUhShort();
            if(this.modelId < 0)
            {
               throw new Error("Forbidden value (" + this.modelId + ") on element of HouseInformationsInside.modelId.");
            }
            else
            {
               this.ownerId = param1.readInt();
               this.ownerName = param1.readUTF();
               this.worldX = param1.readShort();
               if(this.worldX < -255 || this.worldX > 255)
               {
                  throw new Error("Forbidden value (" + this.worldX + ") on element of HouseInformationsInside.worldX.");
               }
               else
               {
                  this.worldY = param1.readShort();
                  if(this.worldY < -255 || this.worldY > 255)
                  {
                     throw new Error("Forbidden value (" + this.worldY + ") on element of HouseInformationsInside.worldY.");
                  }
                  else
                  {
                     this.price = param1.readInt();
                     if(this.price < 0)
                     {
                        throw new Error("Forbidden value (" + this.price + ") on element of HouseInformationsInside.price.");
                     }
                     else
                     {
                        this.isLocked = param1.readBoolean();
                        return;
                     }
                  }
               }
            }
         }
      }
   }
}
