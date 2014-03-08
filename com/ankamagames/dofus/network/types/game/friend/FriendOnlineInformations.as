package com.ankamagames.dofus.network.types.game.friend
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.enums.PlayableBreedEnum;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class FriendOnlineInformations extends FriendInformations implements INetworkType
   {
      
      public function FriendOnlineInformations() {
         this.guildInfo = new BasicGuildInformations();
         this.status = new PlayerStatus();
         super();
      }
      
      public static const protocolId:uint = 92;
      
      public var playerId:uint = 0;
      
      public var playerName:String = "";
      
      public var level:uint = 0;
      
      public var alignmentSide:int = 0;
      
      public var breed:int = 0;
      
      public var sex:Boolean = false;
      
      public var guildInfo:BasicGuildInformations;
      
      public var moodSmileyId:int = 0;
      
      public var status:PlayerStatus;
      
      override public function getTypeId() : uint {
         return 92;
      }
      
      public function initFriendOnlineInformations(accountId:uint=0, accountName:String="", playerState:uint=99, lastConnection:uint=0, achievementPoints:int=0, playerId:uint=0, playerName:String="", level:uint=0, alignmentSide:int=0, breed:int=0, sex:Boolean=false, guildInfo:BasicGuildInformations=null, moodSmileyId:int=0, status:PlayerStatus=null) : FriendOnlineInformations {
         super.initFriendInformations(accountId,accountName,playerState,lastConnection,achievementPoints);
         this.playerId = playerId;
         this.playerName = playerName;
         this.level = level;
         this.alignmentSide = alignmentSide;
         this.breed = breed;
         this.sex = sex;
         this.guildInfo = guildInfo;
         this.moodSmileyId = moodSmileyId;
         this.status = status;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.playerId = 0;
         this.playerName = "";
         this.level = 0;
         this.alignmentSide = 0;
         this.breed = 0;
         this.sex = false;
         this.guildInfo = new BasicGuildInformations();
         this.status = new PlayerStatus();
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_FriendOnlineInformations(output);
      }
      
      public function serializeAs_FriendOnlineInformations(output:IDataOutput) : void {
         super.serializeAs_FriendInformations(output);
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         else
         {
            output.writeInt(this.playerId);
            output.writeUTF(this.playerName);
            if((this.level < 0) || (this.level > 200))
            {
               throw new Error("Forbidden value (" + this.level + ") on element level.");
            }
            else
            {
               output.writeShort(this.level);
               output.writeByte(this.alignmentSide);
               output.writeByte(this.breed);
               output.writeBoolean(this.sex);
               this.guildInfo.serializeAs_BasicGuildInformations(output);
               output.writeByte(this.moodSmileyId);
               output.writeShort(this.status.getTypeId());
               this.status.serialize(output);
               return;
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FriendOnlineInformations(input);
      }
      
      public function deserializeAs_FriendOnlineInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.playerId = input.readInt();
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of FriendOnlineInformations.playerId.");
         }
         else
         {
            this.playerName = input.readUTF();
            this.level = input.readShort();
            if((this.level < 0) || (this.level > 200))
            {
               throw new Error("Forbidden value (" + this.level + ") on element of FriendOnlineInformations.level.");
            }
            else
            {
               this.alignmentSide = input.readByte();
               this.breed = input.readByte();
               if((this.breed < PlayableBreedEnum.Feca) || (this.breed > PlayableBreedEnum.Steamer))
               {
                  throw new Error("Forbidden value (" + this.breed + ") on element of FriendOnlineInformations.breed.");
               }
               else
               {
                  this.sex = input.readBoolean();
                  this.guildInfo = new BasicGuildInformations();
                  this.guildInfo.deserialize(input);
                  this.moodSmileyId = input.readByte();
                  _id9 = input.readUnsignedShort();
                  this.status = ProtocolTypeManager.getInstance(PlayerStatus,_id9);
                  this.status.deserialize(input);
                  return;
               }
            }
         }
      }
   }
}
