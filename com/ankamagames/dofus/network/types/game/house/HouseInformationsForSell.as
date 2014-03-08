package com.ankamagames.dofus.network.types.game.house
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.Vector;
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
      
      public function initHouseInformationsForSell(param1:uint=0, param2:String="", param3:Boolean=false, param4:int=0, param5:int=0, param6:uint=0, param7:int=0, param8:int=0, param9:Vector.<int>=null, param10:Boolean=false, param11:uint=0) : HouseInformationsForSell {
         this.modelId = param1;
         this.ownerName = param2;
         this.ownerConnected = param3;
         this.worldX = param4;
         this.worldY = param5;
         this.subAreaId = param6;
         this.nbRoom = param7;
         this.nbChest = param8;
         this.skillListIds = param9;
         this.isLocked = param10;
         this.price = param11;
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
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_HouseInformationsForSell(param1);
      }
      
      public function serializeAs_HouseInformationsForSell(param1:IDataOutput) : void {
         if(this.modelId < 0)
         {
            throw new Error("Forbidden value (" + this.modelId + ") on element modelId.");
         }
         else
         {
            param1.writeInt(this.modelId);
            param1.writeUTF(this.ownerName);
            param1.writeBoolean(this.ownerConnected);
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
                  if(this.subAreaId < 0)
                  {
                     throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
                  }
                  else
                  {
                     param1.writeShort(this.subAreaId);
                     param1.writeByte(this.nbRoom);
                     param1.writeByte(this.nbChest);
                     param1.writeShort(this.skillListIds.length);
                     _loc2_ = 0;
                     while(_loc2_ < this.skillListIds.length)
                     {
                        param1.writeInt(this.skillListIds[_loc2_]);
                        _loc2_++;
                     }
                     param1.writeBoolean(this.isLocked);
                     if(this.price < 0)
                     {
                        throw new Error("Forbidden value (" + this.price + ") on element price.");
                     }
                     else
                     {
                        param1.writeInt(this.price);
                        return;
                     }
                  }
               }
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_HouseInformationsForSell(param1);
      }
      
      public function deserializeAs_HouseInformationsForSell(param1:IDataInput) : void {
         var _loc4_:* = 0;
         this.modelId = param1.readInt();
         if(this.modelId < 0)
         {
            throw new Error("Forbidden value (" + this.modelId + ") on element of HouseInformationsForSell.modelId.");
         }
         else
         {
            this.ownerName = param1.readUTF();
            this.ownerConnected = param1.readBoolean();
            this.worldX = param1.readShort();
            if(this.worldX < -255 || this.worldX > 255)
            {
               throw new Error("Forbidden value (" + this.worldX + ") on element of HouseInformationsForSell.worldX.");
            }
            else
            {
               this.worldY = param1.readShort();
               if(this.worldY < -255 || this.worldY > 255)
               {
                  throw new Error("Forbidden value (" + this.worldY + ") on element of HouseInformationsForSell.worldY.");
               }
               else
               {
                  this.subAreaId = param1.readShort();
                  if(this.subAreaId < 0)
                  {
                     throw new Error("Forbidden value (" + this.subAreaId + ") on element of HouseInformationsForSell.subAreaId.");
                  }
                  else
                  {
                     this.nbRoom = param1.readByte();
                     this.nbChest = param1.readByte();
                     _loc2_ = param1.readUnsignedShort();
                     _loc3_ = 0;
                     while(_loc3_ < _loc2_)
                     {
                        _loc4_ = param1.readInt();
                        this.skillListIds.push(_loc4_);
                        _loc3_++;
                     }
                     this.isLocked = param1.readBoolean();
                     this.price = param1.readInt();
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
