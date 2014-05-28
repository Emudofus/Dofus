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
      
      public function initGuildMember(id:uint = 0, level:uint = 0, name:String = "", breed:int = 0, sex:Boolean = false, rank:uint = 0, givenExperience:Number = 0, experienceGivenPercent:uint = 0, rights:uint = 0, connected:uint = 99, alignmentSide:int = 0, hoursSinceLastConnection:uint = 0, moodSmileyId:int = 0, accountId:uint = 0, achievementPoints:int = 0, status:PlayerStatus = null) : GuildMember {
         super.initCharacterMinimalInformations(id,level,name);
         this.breed = breed;
         this.sex = sex;
         this.rank = rank;
         this.givenExperience = givenExperience;
         this.experienceGivenPercent = experienceGivenPercent;
         this.rights = rights;
         this.connected = connected;
         this.alignmentSide = alignmentSide;
         this.hoursSinceLastConnection = hoursSinceLastConnection;
         this.moodSmileyId = moodSmileyId;
         this.accountId = accountId;
         this.achievementPoints = achievementPoints;
         this.status = status;
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GuildMember(output);
      }
      
      public function serializeAs_GuildMember(output:IDataOutput) : void {
         super.serializeAs_CharacterMinimalInformations(output);
         output.writeByte(this.breed);
         output.writeBoolean(this.sex);
         if(this.rank < 0)
         {
            throw new Error("Forbidden value (" + this.rank + ") on element rank.");
         }
         else
         {
            output.writeShort(this.rank);
            if(this.givenExperience < 0)
            {
               throw new Error("Forbidden value (" + this.givenExperience + ") on element givenExperience.");
            }
            else
            {
               output.writeDouble(this.givenExperience);
               if((this.experienceGivenPercent < 0) || (this.experienceGivenPercent > 100))
               {
                  throw new Error("Forbidden value (" + this.experienceGivenPercent + ") on element experienceGivenPercent.");
               }
               else
               {
                  output.writeByte(this.experienceGivenPercent);
                  if((this.rights < 0) || (this.rights > 4.294967295E9))
                  {
                     throw new Error("Forbidden value (" + this.rights + ") on element rights.");
                  }
                  else
                  {
                     output.writeUnsignedInt(this.rights);
                     output.writeByte(this.connected);
                     output.writeByte(this.alignmentSide);
                     if((this.hoursSinceLastConnection < 0) || (this.hoursSinceLastConnection > 65535))
                     {
                        throw new Error("Forbidden value (" + this.hoursSinceLastConnection + ") on element hoursSinceLastConnection.");
                     }
                     else
                     {
                        output.writeShort(this.hoursSinceLastConnection);
                        output.writeByte(this.moodSmileyId);
                        if(this.accountId < 0)
                        {
                           throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
                        }
                        else
                        {
                           output.writeInt(this.accountId);
                           output.writeInt(this.achievementPoints);
                           output.writeShort(this.status.getTypeId());
                           this.status.serialize(output);
                           return;
                        }
                     }
                  }
               }
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildMember(input);
      }
      
      public function deserializeAs_GuildMember(input:IDataInput) : void {
         super.deserialize(input);
         this.breed = input.readByte();
         this.sex = input.readBoolean();
         this.rank = input.readShort();
         if(this.rank < 0)
         {
            throw new Error("Forbidden value (" + this.rank + ") on element of GuildMember.rank.");
         }
         else
         {
            this.givenExperience = input.readDouble();
            if(this.givenExperience < 0)
            {
               throw new Error("Forbidden value (" + this.givenExperience + ") on element of GuildMember.givenExperience.");
            }
            else
            {
               this.experienceGivenPercent = input.readByte();
               if((this.experienceGivenPercent < 0) || (this.experienceGivenPercent > 100))
               {
                  throw new Error("Forbidden value (" + this.experienceGivenPercent + ") on element of GuildMember.experienceGivenPercent.");
               }
               else
               {
                  this.rights = input.readUnsignedInt();
                  if((this.rights < 0) || (this.rights > 4.294967295E9))
                  {
                     throw new Error("Forbidden value (" + this.rights + ") on element of GuildMember.rights.");
                  }
                  else
                  {
                     this.connected = input.readByte();
                     if(this.connected < 0)
                     {
                        throw new Error("Forbidden value (" + this.connected + ") on element of GuildMember.connected.");
                     }
                     else
                     {
                        this.alignmentSide = input.readByte();
                        this.hoursSinceLastConnection = input.readUnsignedShort();
                        if((this.hoursSinceLastConnection < 0) || (this.hoursSinceLastConnection > 65535))
                        {
                           throw new Error("Forbidden value (" + this.hoursSinceLastConnection + ") on element of GuildMember.hoursSinceLastConnection.");
                        }
                        else
                        {
                           this.moodSmileyId = input.readByte();
                           this.accountId = input.readInt();
                           if(this.accountId < 0)
                           {
                              throw new Error("Forbidden value (" + this.accountId + ") on element of GuildMember.accountId.");
                           }
                           else
                           {
                              this.achievementPoints = input.readInt();
                              _id13 = input.readUnsignedShort();
                              this.status = ProtocolTypeManager.getInstance(PlayerStatus,_id13);
                              this.status.deserialize(input);
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
