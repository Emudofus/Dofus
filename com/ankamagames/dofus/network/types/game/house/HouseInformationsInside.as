package com.ankamagames.dofus.network.types.game.house
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class HouseInformationsInside extends Object implements INetworkType
   {
      
      public function HouseInformationsInside() {
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
      
      public function getTypeId() : uint {
         return 218;
      }
      
      public function initHouseInformationsInside(houseId:uint = 0, modelId:uint = 0, ownerId:int = 0, ownerName:String = "", worldX:int = 0, worldY:int = 0, price:uint = 0, isLocked:Boolean = false) : HouseInformationsInside {
         this.houseId = houseId;
         this.modelId = modelId;
         this.ownerId = ownerId;
         this.ownerName = ownerName;
         this.worldX = worldX;
         this.worldY = worldY;
         this.price = price;
         this.isLocked = isLocked;
         return this;
      }
      
      public function reset() : void {
         this.houseId = 0;
         this.modelId = 0;
         this.ownerId = 0;
         this.ownerName = "";
         this.worldX = 0;
         this.worldY = 0;
         this.price = 0;
         this.isLocked = false;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_HouseInformationsInside(output);
      }
      
      public function serializeAs_HouseInformationsInside(output:IDataOutput) : void {
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element houseId.");
         }
         else
         {
            output.writeInt(this.houseId);
            if(this.modelId < 0)
            {
               throw new Error("Forbidden value (" + this.modelId + ") on element modelId.");
            }
            else
            {
               output.writeShort(this.modelId);
               output.writeInt(this.ownerId);
               output.writeUTF(this.ownerName);
               if((this.worldX < -255) || (this.worldX > 255))
               {
                  throw new Error("Forbidden value (" + this.worldX + ") on element worldX.");
               }
               else
               {
                  output.writeShort(this.worldX);
                  if((this.worldY < -255) || (this.worldY > 255))
                  {
                     throw new Error("Forbidden value (" + this.worldY + ") on element worldY.");
                  }
                  else
                  {
                     output.writeShort(this.worldY);
                     if((this.price < 0) || (this.price > 4.294967295E9))
                     {
                        throw new Error("Forbidden value (" + this.price + ") on element price.");
                     }
                     else
                     {
                        output.writeUnsignedInt(this.price);
                        output.writeBoolean(this.isLocked);
                        return;
                     }
                  }
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_HouseInformationsInside(input);
      }
      
      public function deserializeAs_HouseInformationsInside(input:IDataInput) : void {
         this.houseId = input.readInt();
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element of HouseInformationsInside.houseId.");
         }
         else
         {
            this.modelId = input.readShort();
            if(this.modelId < 0)
            {
               throw new Error("Forbidden value (" + this.modelId + ") on element of HouseInformationsInside.modelId.");
            }
            else
            {
               this.ownerId = input.readInt();
               this.ownerName = input.readUTF();
               this.worldX = input.readShort();
               if((this.worldX < -255) || (this.worldX > 255))
               {
                  throw new Error("Forbidden value (" + this.worldX + ") on element of HouseInformationsInside.worldX.");
               }
               else
               {
                  this.worldY = input.readShort();
                  if((this.worldY < -255) || (this.worldY > 255))
                  {
                     throw new Error("Forbidden value (" + this.worldY + ") on element of HouseInformationsInside.worldY.");
                  }
                  else
                  {
                     this.price = input.readUnsignedInt();
                     if((this.price < 0) || (this.price > 4.294967295E9))
                     {
                        throw new Error("Forbidden value (" + this.price + ") on element of HouseInformationsInside.price.");
                     }
                     else
                     {
                        this.isLocked = input.readBoolean();
                        return;
                     }
                  }
               }
            }
         }
      }
   }
}
