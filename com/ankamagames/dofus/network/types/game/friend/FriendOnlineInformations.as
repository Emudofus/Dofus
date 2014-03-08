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
      
      public function initFriendOnlineInformations(param1:uint=0, param2:String="", param3:uint=99, param4:uint=0, param5:int=0, param6:uint=0, param7:String="", param8:uint=0, param9:int=0, param10:int=0, param11:Boolean=false, param12:BasicGuildInformations=null, param13:int=0, param14:PlayerStatus=null) : FriendOnlineInformations {
         super.initFriendInformations(param1,param2,param3,param4,param5);
         this.playerId = param6;
         this.playerName = param7;
         this.level = param8;
         this.alignmentSide = param9;
         this.breed = param10;
         this.sex = param11;
         this.guildInfo = param12;
         this.moodSmileyId = param13;
         this.status = param14;
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
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_FriendOnlineInformations(param1);
      }
      
      public function serializeAs_FriendOnlineInformations(param1:IDataOutput) : void {
         super.serializeAs_FriendInformations(param1);
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         else
         {
            param1.writeInt(this.playerId);
            param1.writeUTF(this.playerName);
            if(this.level < 0 || this.level > 200)
            {
               throw new Error("Forbidden value (" + this.level + ") on element level.");
            }
            else
            {
               param1.writeShort(this.level);
               param1.writeByte(this.alignmentSide);
               param1.writeByte(this.breed);
               param1.writeBoolean(this.sex);
               this.guildInfo.serializeAs_BasicGuildInformations(param1);
               param1.writeByte(this.moodSmileyId);
               param1.writeShort(this.status.getTypeId());
               this.status.serialize(param1);
               return;
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_FriendOnlineInformations(param1);
      }
      
      public function deserializeAs_FriendOnlineInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.playerId = param1.readInt();
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of FriendOnlineInformations.playerId.");
         }
         else
         {
            this.playerName = param1.readUTF();
            this.level = param1.readShort();
            if(this.level < 0 || this.level > 200)
            {
               throw new Error("Forbidden value (" + this.level + ") on element of FriendOnlineInformations.level.");
            }
            else
            {
               this.alignmentSide = param1.readByte();
               this.breed = param1.readByte();
               if(this.breed < PlayableBreedEnum.Feca || this.breed > PlayableBreedEnum.Steamer)
               {
                  throw new Error("Forbidden value (" + this.breed + ") on element of FriendOnlineInformations.breed.");
               }
               else
               {
                  this.sex = param1.readBoolean();
                  this.guildInfo = new BasicGuildInformations();
                  this.guildInfo.deserialize(param1);
                  this.moodSmileyId = param1.readByte();
                  _loc2_ = param1.readUnsignedShort();
                  this.status = ProtocolTypeManager.getInstance(PlayerStatus,_loc2_);
                  this.status.deserialize(param1);
                  return;
               }
            }
         }
      }
   }
}
