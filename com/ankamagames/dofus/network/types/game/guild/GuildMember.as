package com.ankamagames.dofus.network.types.game.guild
{
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalInformations;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class GuildMember extends CharacterMinimalInformations implements INetworkType
   {
      
      public function GuildMember() {
         this.status = new PlayerStatus();
         super();
      }
      
      public static const protocolId:uint = 88;
      
      public var breed:int = 0;
      
      public var sex:Boolean = false;
      
      public var rank:uint = 0;
      
      public var givenExperience:Number = 0;
      
      public var experienceGivenPercent:uint = 0;
      
      public var rights:uint = 0;
      
      public var connected:uint = 99;
      
      public var alignmentSide:int = 0;
      
      public var hoursSinceLastConnection:uint = 0;
      
      public var moodSmileyId:int = 0;
      
      public var accountId:uint = 0;
      
      public var achievementPoints:int = 0;
      
      public var status:PlayerStatus;
      
      override public function getTypeId() : uint {
         return 88;
      }
      
      public function initGuildMember(param1:uint=0, param2:uint=0, param3:String="", param4:int=0, param5:Boolean=false, param6:uint=0, param7:Number=0, param8:uint=0, param9:uint=0, param10:uint=99, param11:int=0, param12:uint=0, param13:int=0, param14:uint=0, param15:int=0, param16:PlayerStatus=null) : GuildMember {
         super.initCharacterMinimalInformations(param1,param2,param3);
         this.breed = param4;
         this.sex = param5;
         this.rank = param6;
         this.givenExperience = param7;
         this.experienceGivenPercent = param8;
         this.rights = param9;
         this.connected = param10;
         this.alignmentSide = param11;
         this.hoursSinceLastConnection = param12;
         this.moodSmileyId = param13;
         this.accountId = param14;
         this.achievementPoints = param15;
         this.status = param16;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.breed = 0;
         this.sex = false;
         this.rank = 0;
         this.givenExperience = 0;
         this.experienceGivenPercent = 0;
         this.rights = 0;
         this.connected = 99;
         this.alignmentSide = 0;
         this.hoursSinceLastConnection = 0;
         this.moodSmileyId = 0;
         this.accountId = 0;
         this.achievementPoints = 0;
         this.status = new PlayerStatus();
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GuildMember(param1);
      }
      
      public function serializeAs_GuildMember(param1:IDataOutput) : void {
         super.serializeAs_CharacterMinimalInformations(param1);
         param1.writeByte(this.breed);
         param1.writeBoolean(this.sex);
         if(this.rank < 0)
         {
            throw new Error("Forbidden value (" + this.rank + ") on element rank.");
         }
         else
         {
            param1.writeShort(this.rank);
            if(this.givenExperience < 0)
            {
               throw new Error("Forbidden value (" + this.givenExperience + ") on element givenExperience.");
            }
            else
            {
               param1.writeDouble(this.givenExperience);
               if(this.experienceGivenPercent < 0 || this.experienceGivenPercent > 100)
               {
                  throw new Error("Forbidden value (" + this.experienceGivenPercent + ") on element experienceGivenPercent.");
               }
               else
               {
                  param1.writeByte(this.experienceGivenPercent);
                  if(this.rights < 0 || this.rights > 4.294967295E9)
                  {
                     throw new Error("Forbidden value (" + this.rights + ") on element rights.");
                  }
                  else
                  {
                     param1.writeUnsignedInt(this.rights);
                     param1.writeByte(this.connected);
                     param1.writeByte(this.alignmentSide);
                     if(this.hoursSinceLastConnection < 0 || this.hoursSinceLastConnection > 65535)
                     {
                        throw new Error("Forbidden value (" + this.hoursSinceLastConnection + ") on element hoursSinceLastConnection.");
                     }
                     else
                     {
                        param1.writeShort(this.hoursSinceLastConnection);
                        param1.writeByte(this.moodSmileyId);
                        if(this.accountId < 0)
                        {
                           throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
                        }
                        else
                        {
                           param1.writeInt(this.accountId);
                           param1.writeInt(this.achievementPoints);
                           param1.writeShort(this.status.getTypeId());
                           this.status.serialize(param1);
                           return;
                        }
                     }
                  }
               }
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GuildMember(param1);
      }
      
      public function deserializeAs_GuildMember(param1:IDataInput) : void {
         super.deserialize(param1);
         this.breed = param1.readByte();
         this.sex = param1.readBoolean();
         this.rank = param1.readShort();
         if(this.rank < 0)
         {
            throw new Error("Forbidden value (" + this.rank + ") on element of GuildMember.rank.");
         }
         else
         {
            this.givenExperience = param1.readDouble();
            if(this.givenExperience < 0)
            {
               throw new Error("Forbidden value (" + this.givenExperience + ") on element of GuildMember.givenExperience.");
            }
            else
            {
               this.experienceGivenPercent = param1.readByte();
               if(this.experienceGivenPercent < 0 || this.experienceGivenPercent > 100)
               {
                  throw new Error("Forbidden value (" + this.experienceGivenPercent + ") on element of GuildMember.experienceGivenPercent.");
               }
               else
               {
                  this.rights = param1.readUnsignedInt();
                  if(this.rights < 0 || this.rights > 4.294967295E9)
                  {
                     throw new Error("Forbidden value (" + this.rights + ") on element of GuildMember.rights.");
                  }
                  else
                  {
                     this.connected = param1.readByte();
                     if(this.connected < 0)
                     {
                        throw new Error("Forbidden value (" + this.connected + ") on element of GuildMember.connected.");
                     }
                     else
                     {
                        this.alignmentSide = param1.readByte();
                        this.hoursSinceLastConnection = param1.readUnsignedShort();
                        if(this.hoursSinceLastConnection < 0 || this.hoursSinceLastConnection > 65535)
                        {
                           throw new Error("Forbidden value (" + this.hoursSinceLastConnection + ") on element of GuildMember.hoursSinceLastConnection.");
                        }
                        else
                        {
                           this.moodSmileyId = param1.readByte();
                           this.accountId = param1.readInt();
                           if(this.accountId < 0)
                           {
                              throw new Error("Forbidden value (" + this.accountId + ") on element of GuildMember.accountId.");
                           }
                           else
                           {
                              this.achievementPoints = param1.readInt();
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
         }
      }
   }
}
