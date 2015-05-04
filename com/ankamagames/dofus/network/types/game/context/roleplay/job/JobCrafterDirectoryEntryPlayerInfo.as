package com.ankamagames.dofus.network.types.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.dofus.network.enums.PlayableBreedEnum;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class JobCrafterDirectoryEntryPlayerInfo extends Object implements INetworkType
   {
      
      public function JobCrafterDirectoryEntryPlayerInfo()
      {
         this.status = new PlayerStatus();
         super();
      }
      
      public static const protocolId:uint = 194;
      
      public var playerId:uint = 0;
      
      public var playerName:String = "";
      
      public var alignmentSide:int = 0;
      
      public var breed:int = 0;
      
      public var sex:Boolean = false;
      
      public var isInWorkshop:Boolean = false;
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var mapId:int = 0;
      
      public var subAreaId:uint = 0;
      
      public var status:PlayerStatus;
      
      public function getTypeId() : uint
      {
         return 194;
      }
      
      public function initJobCrafterDirectoryEntryPlayerInfo(param1:uint = 0, param2:String = "", param3:int = 0, param4:int = 0, param5:Boolean = false, param6:Boolean = false, param7:int = 0, param8:int = 0, param9:int = 0, param10:uint = 0, param11:PlayerStatus = null) : JobCrafterDirectoryEntryPlayerInfo
      {
         this.playerId = param1;
         this.playerName = param2;
         this.alignmentSide = param3;
         this.breed = param4;
         this.sex = param5;
         this.isInWorkshop = param6;
         this.worldX = param7;
         this.worldY = param8;
         this.mapId = param9;
         this.subAreaId = param10;
         this.status = param11;
         return this;
      }
      
      public function reset() : void
      {
         this.playerId = 0;
         this.playerName = "";
         this.alignmentSide = 0;
         this.breed = 0;
         this.sex = false;
         this.isInWorkshop = false;
         this.worldX = 0;
         this.worldY = 0;
         this.mapId = 0;
         this.subAreaId = 0;
         this.status = new PlayerStatus();
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_JobCrafterDirectoryEntryPlayerInfo(param1);
      }
      
      public function serializeAs_JobCrafterDirectoryEntryPlayerInfo(param1:ICustomDataOutput) : void
      {
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         else
         {
            param1.writeVarInt(this.playerId);
            param1.writeUTF(this.playerName);
            param1.writeByte(this.alignmentSide);
            param1.writeByte(this.breed);
            param1.writeBoolean(this.sex);
            param1.writeBoolean(this.isInWorkshop);
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
                     param1.writeShort(this.status.getTypeId());
                     this.status.serialize(param1);
                     return;
                  }
               }
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_JobCrafterDirectoryEntryPlayerInfo(param1);
      }
      
      public function deserializeAs_JobCrafterDirectoryEntryPlayerInfo(param1:ICustomDataInput) : void
      {
         this.playerId = param1.readVarUhInt();
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of JobCrafterDirectoryEntryPlayerInfo.playerId.");
         }
         else
         {
            this.playerName = param1.readUTF();
            this.alignmentSide = param1.readByte();
            this.breed = param1.readByte();
            if(this.breed < PlayableBreedEnum.Feca || this.breed > PlayableBreedEnum.Eliotrope)
            {
               throw new Error("Forbidden value (" + this.breed + ") on element of JobCrafterDirectoryEntryPlayerInfo.breed.");
            }
            else
            {
               this.sex = param1.readBoolean();
               this.isInWorkshop = param1.readBoolean();
               this.worldX = param1.readShort();
               if(this.worldX < -255 || this.worldX > 255)
               {
                  throw new Error("Forbidden value (" + this.worldX + ") on element of JobCrafterDirectoryEntryPlayerInfo.worldX.");
               }
               else
               {
                  this.worldY = param1.readShort();
                  if(this.worldY < -255 || this.worldY > 255)
                  {
                     throw new Error("Forbidden value (" + this.worldY + ") on element of JobCrafterDirectoryEntryPlayerInfo.worldY.");
                  }
                  else
                  {
                     this.mapId = param1.readInt();
                     this.subAreaId = param1.readVarUhShort();
                     if(this.subAreaId < 0)
                     {
                        throw new Error("Forbidden value (" + this.subAreaId + ") on element of JobCrafterDirectoryEntryPlayerInfo.subAreaId.");
                     }
                     else
                     {
                        var _loc2_:uint = param1.readUnsignedShort();
                        this.status = ProtocolTypeManager.getInstance(PlayerStatus,_loc2_);
                        this.status.deserialize(param1);
                        return;
                     }
                  }
               }
            }
         }
      }
   }
}
