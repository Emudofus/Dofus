package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.dofus.network.enums.PlayableBreedEnum;
   
   public class DungeonPartyFinderPlayer extends Object implements INetworkType
   {
      
      public function DungeonPartyFinderPlayer()
      {
         super();
      }
      
      public static const protocolId:uint = 373;
      
      public var playerId:uint = 0;
      
      public var playerName:String = "";
      
      public var breed:int = 0;
      
      public var sex:Boolean = false;
      
      public var level:uint = 0;
      
      public function getTypeId() : uint
      {
         return 373;
      }
      
      public function initDungeonPartyFinderPlayer(param1:uint = 0, param2:String = "", param3:int = 0, param4:Boolean = false, param5:uint = 0) : DungeonPartyFinderPlayer
      {
         this.playerId = param1;
         this.playerName = param2;
         this.breed = param3;
         this.sex = param4;
         this.level = param5;
         return this;
      }
      
      public function reset() : void
      {
         this.playerId = 0;
         this.playerName = "";
         this.breed = 0;
         this.sex = false;
         this.level = 0;
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_DungeonPartyFinderPlayer(param1);
      }
      
      public function serializeAs_DungeonPartyFinderPlayer(param1:ICustomDataOutput) : void
      {
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         else
         {
            param1.writeVarInt(this.playerId);
            param1.writeUTF(this.playerName);
            param1.writeByte(this.breed);
            param1.writeBoolean(this.sex);
            if(this.level < 0 || this.level > 255)
            {
               throw new Error("Forbidden value (" + this.level + ") on element level.");
            }
            else
            {
               param1.writeByte(this.level);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_DungeonPartyFinderPlayer(param1);
      }
      
      public function deserializeAs_DungeonPartyFinderPlayer(param1:ICustomDataInput) : void
      {
         this.playerId = param1.readVarUhInt();
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of DungeonPartyFinderPlayer.playerId.");
         }
         else
         {
            this.playerName = param1.readUTF();
            this.breed = param1.readByte();
            if(this.breed < PlayableBreedEnum.Feca || this.breed > PlayableBreedEnum.Eliotrope)
            {
               throw new Error("Forbidden value (" + this.breed + ") on element of DungeonPartyFinderPlayer.breed.");
            }
            else
            {
               this.sex = param1.readBoolean();
               this.level = param1.readUnsignedByte();
               if(this.level < 0 || this.level > 255)
               {
                  throw new Error("Forbidden value (" + this.level + ") on element of DungeonPartyFinderPlayer.level.");
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
