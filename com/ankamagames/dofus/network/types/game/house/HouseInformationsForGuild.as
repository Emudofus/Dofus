package com.ankamagames.dofus.network.types.game.house
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class HouseInformationsForGuild extends Object implements INetworkType
   {
      
      public function HouseInformationsForGuild() {
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
      
      public function getTypeId() : uint {
         return 170;
      }
      
      public function initHouseInformationsForGuild(houseId:uint = 0, modelId:uint = 0, ownerName:String = "", worldX:int = 0, worldY:int = 0, mapId:int = 0, subAreaId:uint = 0, skillListIds:Vector.<int> = null, guildshareParams:uint = 0) : HouseInformationsForGuild {
         this.houseId = houseId;
         this.modelId = modelId;
         this.ownerName = ownerName;
         this.worldX = worldX;
         this.worldY = worldY;
         this.mapId = mapId;
         this.subAreaId = subAreaId;
         this.skillListIds = skillListIds;
         this.guildshareParams = guildshareParams;
         return this;
      }
      
      public function reset() : void {
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
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_HouseInformationsForGuild(output);
      }
      
      public function serializeAs_HouseInformationsForGuild(output:IDataOutput) : void {
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
               output.writeInt(this.modelId);
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
                     output.writeInt(this.mapId);
                     if(this.subAreaId < 0)
                     {
                        throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
                     }
                     else
                     {
                        output.writeShort(this.subAreaId);
                        output.writeShort(this.skillListIds.length);
                        _i8 = 0;
                        while(_i8 < this.skillListIds.length)
                        {
                           output.writeInt(this.skillListIds[_i8]);
                           _i8++;
                        }
                        if((this.guildshareParams < 0) || (this.guildshareParams > 4.294967295E9))
                        {
                           throw new Error("Forbidden value (" + this.guildshareParams + ") on element guildshareParams.");
                        }
                        else
                        {
                           output.writeUnsignedInt(this.guildshareParams);
                           return;
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_HouseInformationsForGuild(input);
      }
      
      public function deserializeAs_HouseInformationsForGuild(input:IDataInput) : void {
         var _val8:* = 0;
         this.houseId = input.readInt();
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element of HouseInformationsForGuild.houseId.");
         }
         else
         {
            this.modelId = input.readInt();
            if(this.modelId < 0)
            {
               throw new Error("Forbidden value (" + this.modelId + ") on element of HouseInformationsForGuild.modelId.");
            }
            else
            {
               this.ownerName = input.readUTF();
               this.worldX = input.readShort();
               if((this.worldX < -255) || (this.worldX > 255))
               {
                  throw new Error("Forbidden value (" + this.worldX + ") on element of HouseInformationsForGuild.worldX.");
               }
               else
               {
                  this.worldY = input.readShort();
                  if((this.worldY < -255) || (this.worldY > 255))
                  {
                     throw new Error("Forbidden value (" + this.worldY + ") on element of HouseInformationsForGuild.worldY.");
                  }
                  else
                  {
                     this.mapId = input.readInt();
                     this.subAreaId = input.readShort();
                     if(this.subAreaId < 0)
                     {
                        throw new Error("Forbidden value (" + this.subAreaId + ") on element of HouseInformationsForGuild.subAreaId.");
                     }
                     else
                     {
                        _skillListIdsLen = input.readUnsignedShort();
                        _i8 = 0;
                        while(_i8 < _skillListIdsLen)
                        {
                           _val8 = input.readInt();
                           this.skillListIds.push(_val8);
                           _i8++;
                        }
                        this.guildshareParams = input.readUnsignedInt();
                        if((this.guildshareParams < 0) || (this.guildshareParams > 4.294967295E9))
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
