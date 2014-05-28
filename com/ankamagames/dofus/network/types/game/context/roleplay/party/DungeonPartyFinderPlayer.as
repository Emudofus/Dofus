package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.enums.PlayableBreedEnum;
   
   public class DungeonPartyFinderPlayer extends Object implements INetworkType
   {
      
      public function DungeonPartyFinderPlayer() {
         super();
      }
      
      public static const protocolId:uint = 373;
      
      public var playerId:uint = 0;
      
      public var playerName:String = "";
      
      public var breed:int = 0;
      
      public var sex:Boolean = false;
      
      public var level:uint = 0;
      
      public function getTypeId() : uint {
         return 373;
      }
      
      public function initDungeonPartyFinderPlayer(playerId:uint = 0, playerName:String = "", breed:int = 0, sex:Boolean = false, level:uint = 0) : DungeonPartyFinderPlayer {
         this.playerId = playerId;
         this.playerName = playerName;
         this.breed = breed;
         this.sex = sex;
         this.level = level;
         return this;
      }
      
      public function reset() : void {
         this.playerId = 0;
         this.playerName = "";
         this.breed = 0;
         this.sex = false;
         this.level = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_DungeonPartyFinderPlayer(output);
      }
      
      public function serializeAs_DungeonPartyFinderPlayer(output:IDataOutput) : void {
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         else
         {
            output.writeInt(this.playerId);
            output.writeUTF(this.playerName);
            output.writeByte(this.breed);
            output.writeBoolean(this.sex);
            if(this.level < 0)
            {
               throw new Error("Forbidden value (" + this.level + ") on element level.");
            }
            else
            {
               output.writeShort(this.level);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_DungeonPartyFinderPlayer(input);
      }
      
      public function deserializeAs_DungeonPartyFinderPlayer(input:IDataInput) : void {
         this.playerId = input.readInt();
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of DungeonPartyFinderPlayer.playerId.");
         }
         else
         {
            this.playerName = input.readUTF();
            this.breed = input.readByte();
            if((this.breed < PlayableBreedEnum.Feca) || (this.breed > PlayableBreedEnum.Steamer))
            {
               throw new Error("Forbidden value (" + this.breed + ") on element of DungeonPartyFinderPlayer.breed.");
            }
            else
            {
               this.sex = input.readBoolean();
               this.level = input.readShort();
               if(this.level < 0)
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
