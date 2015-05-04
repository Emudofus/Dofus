package com.ankamagames.dofus.network.types.game.house
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class HouseInformationsForGuild extends Object implements INetworkType
   {
      
      public function HouseInformationsForGuild()
      {
         this.skillListIds = new Vector.<int>();
         super();
      }
      
      public static const protocolId:uint = 170;
      
      public var houseId:uint = 0;
      
      public var modelId:uint = 0;
      
      public var ownerName:String = "";
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var mapId:int = 0;
      
      public var subAreaId:uint = 0;
      
      public var skillListIds:Vector.<int>;
      
      public var guildshareParams:uint = 0;
      
      public function getTypeId() : uint
      {
         return 170;
      }
      
      public function initHouseInformationsForGuild(param1:uint = 0, param2:uint = 0, param3:String = "", param4:int = 0, param5:int = 0, param6:int = 0, param7:uint = 0, param8:Vector.<int> = null, param9:uint = 0) : HouseInformationsForGuild
      {
         this.houseId = param1;
         this.modelId = param2;
         this.ownerName = param3;
         this.worldX = param4;
         this.worldY = param5;
         this.mapId = param6;
         this.subAreaId = param7;
         this.skillListIds = param8;
         this.guildshareParams = param9;
         return this;
      }
      
      public function reset() : void
      {
         this.houseId = 0;
         this.modelId = 0;
         this.ownerName = "";
         this.worldX = 0;
         this.worldY = 0;
         this.mapId = 0;
         this.subAreaId = 0;
         this.skillListIds = new Vector.<int>();
         this.guildshareParams = 0;
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_HouseInformationsForGuild(param1);
      }
      
      public function serializeAs_HouseInformationsForGuild(param1:ICustomDataOutput) : void
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
               param1.writeVarInt(this.modelId);
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
                     param1.writeInt(this.mapId);
                     if(this.subAreaId < 0)
                     {
                        throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
                     }
                     else
                     {
                        param1.writeVarShort(this.subAreaId);
                        param1.writeShort(this.skillListIds.length);
                        var _loc2_:uint = 0;
                        while(_loc2_ < this.skillListIds.length)
                        {
                           param1.writeInt(this.skillListIds[_loc2_]);
                           _loc2_++;
                        }
                        if(this.guildshareParams < 0)
                        {
                           throw new Error("Forbidden value (" + this.guildshareParams + ") on element guildshareParams.");
                        }
                        else
                        {
                           param1.writeVarInt(this.guildshareParams);
                           return;
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_HouseInformationsForGuild(param1);
      }
      
      public function deserializeAs_HouseInformationsForGuild(param1:ICustomDataInput) : void
      {
         var _loc4_:* = 0;
         this.houseId = param1.readVarUhInt();
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element of HouseInformationsForGuild.houseId.");
         }
         else
         {
            this.modelId = param1.readVarUhInt();
            if(this.modelId < 0)
            {
               throw new Error("Forbidden value (" + this.modelId + ") on element of HouseInformationsForGuild.modelId.");
            }
            else
            {
               this.ownerName = param1.readUTF();
               this.worldX = param1.readShort();
               if(this.worldX < -255 || this.worldX > 255)
               {
                  throw new Error("Forbidden value (" + this.worldX + ") on element of HouseInformationsForGuild.worldX.");
               }
               else
               {
                  this.worldY = param1.readShort();
                  if(this.worldY < -255 || this.worldY > 255)
                  {
                     throw new Error("Forbidden value (" + this.worldY + ") on element of HouseInformationsForGuild.worldY.");
                  }
                  else
                  {
                     this.mapId = param1.readInt();
                     this.subAreaId = param1.readVarUhShort();
                     if(this.subAreaId < 0)
                     {
                        throw new Error("Forbidden value (" + this.subAreaId + ") on element of HouseInformationsForGuild.subAreaId.");
                     }
                     else
                     {
                        var _loc2_:uint = param1.readUnsignedShort();
                        var _loc3_:uint = 0;
                        while(_loc3_ < _loc2_)
                        {
                           _loc4_ = param1.readInt();
                           this.skillListIds.push(_loc4_);
                           _loc3_++;
                        }
                        this.guildshareParams = param1.readVarUhInt();
                        if(this.guildshareParams < 0)
                        {
                           throw new Error("Forbidden value (" + this.guildshareParams + ") on element of HouseInformationsForGuild.guildshareParams.");
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
}
