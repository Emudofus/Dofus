package com.ankamagames.dofus.network.types.game.house
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class HouseInformationsForSell extends Object implements INetworkType
   {
      
      public function HouseInformationsForSell() {
         this.skillListIds = new Vector.<int>();
         super();
      }
      
      public static const protocolId:uint = 221;
      
      public var modelId:uint = 0;
      
      public var ownerName:String = "";
      
      public var ownerConnected:Boolean = false;
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var subAreaId:uint = 0;
      
      public var nbRoom:int = 0;
      
      public var nbChest:int = 0;
      
      public var skillListIds:Vector.<int>;
      
      public var isLocked:Boolean = false;
      
      public var price:uint = 0;
      
      public function getTypeId() : uint {
         return 221;
      }
      
      public function initHouseInformationsForSell(modelId:uint = 0, ownerName:String = "", ownerConnected:Boolean = false, worldX:int = 0, worldY:int = 0, subAreaId:uint = 0, nbRoom:int = 0, nbChest:int = 0, skillListIds:Vector.<int> = null, isLocked:Boolean = false, price:uint = 0) : HouseInformationsForSell {
         this.modelId = modelId;
         this.ownerName = ownerName;
         this.ownerConnected = ownerConnected;
         this.worldX = worldX;
         this.worldY = worldY;
         this.subAreaId = subAreaId;
         this.nbRoom = nbRoom;
         this.nbChest = nbChest;
         this.skillListIds = skillListIds;
         this.isLocked = isLocked;
         this.price = price;
         return this;
      }
      
      public function reset() : void {
         this.modelId = 0;
         this.ownerName = "";
         this.ownerConnected = false;
         this.worldX = 0;
         this.worldY = 0;
         this.subAreaId = 0;
         this.nbRoom = 0;
         this.nbChest = 0;
         this.skillListIds = new Vector.<int>();
         this.isLocked = false;
         this.price = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_HouseInformationsForSell(output);
      }
      
      public function serializeAs_HouseInformationsForSell(output:IDataOutput) : void {
         if(this.modelId < 0)
         {
            throw new Error("Forbidden value (" + this.modelId + ") on element modelId.");
         }
         else
         {
            output.writeInt(this.modelId);
            output.writeUTF(this.ownerName);
            output.writeBoolean(this.ownerConnected);
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
                  if(this.subAreaId < 0)
                  {
                     throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
                  }
                  else
                  {
                     output.writeShort(this.subAreaId);
                     output.writeByte(this.nbRoom);
                     output.writeByte(this.nbChest);
                     output.writeShort(this.skillListIds.length);
                     _i9 = 0;
                     while(_i9 < this.skillListIds.length)
                     {
                        output.writeInt(this.skillListIds[_i9]);
                        _i9++;
                     }
                     output.writeBoolean(this.isLocked);
                     if(this.price < 0)
                     {
                        throw new Error("Forbidden value (" + this.price + ") on element price.");
                     }
                     else
                     {
                        output.writeInt(this.price);
                        return;
                     }
                  }
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_HouseInformationsForSell(input);
      }
      
      public function deserializeAs_HouseInformationsForSell(input:IDataInput) : void {
         var _val9:* = 0;
         this.modelId = input.readInt();
         if(this.modelId < 0)
         {
            throw new Error("Forbidden value (" + this.modelId + ") on element of HouseInformationsForSell.modelId.");
         }
         else
         {
            this.ownerName = input.readUTF();
            this.ownerConnected = input.readBoolean();
            this.worldX = input.readShort();
            if((this.worldX < -255) || (this.worldX > 255))
            {
               throw new Error("Forbidden value (" + this.worldX + ") on element of HouseInformationsForSell.worldX.");
            }
            else
            {
               this.worldY = input.readShort();
               if((this.worldY < -255) || (this.worldY > 255))
               {
                  throw new Error("Forbidden value (" + this.worldY + ") on element of HouseInformationsForSell.worldY.");
               }
               else
               {
                  this.subAreaId = input.readShort();
                  if(this.subAreaId < 0)
                  {
                     throw new Error("Forbidden value (" + this.subAreaId + ") on element of HouseInformationsForSell.subAreaId.");
                  }
                  else
                  {
                     this.nbRoom = input.readByte();
                     this.nbChest = input.readByte();
                     _skillListIdsLen = input.readUnsignedShort();
                     _i9 = 0;
                     while(_i9 < _skillListIdsLen)
                     {
                        _val9 = input.readInt();
                        this.skillListIds.push(_val9);
                        _i9++;
                     }
                     this.isLocked = input.readBoolean();
                     this.price = input.readInt();
                     if(this.price < 0)
                     {
                        throw new Error("Forbidden value (" + this.price + ") on element of HouseInformationsForSell.price.");
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
