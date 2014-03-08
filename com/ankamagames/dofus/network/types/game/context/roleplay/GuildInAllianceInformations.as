package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GuildInAllianceInformations extends GuildInformations implements INetworkType
   {
      
      public function GuildInAllianceInformations() {
         super();
      }
      
      public static const protocolId:uint = 420;
      
      public var guildLevel:uint = 0;
      
      public var nbMembers:uint = 0;
      
      public var enabled:Boolean = false;
      
      override public function getTypeId() : uint {
         return 420;
      }
      
      public function initGuildInAllianceInformations(param1:uint=0, param2:String="", param3:GuildEmblem=null, param4:uint=0, param5:uint=0, param6:Boolean=false) : GuildInAllianceInformations {
         super.initGuildInformations(param1,param2,param3);
         this.guildLevel = param4;
         this.nbMembers = param5;
         this.enabled = param6;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.guildLevel = 0;
         this.nbMembers = 0;
         this.enabled = false;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GuildInAllianceInformations(param1);
      }
      
      public function serializeAs_GuildInAllianceInformations(param1:IDataOutput) : void {
         super.serializeAs_GuildInformations(param1);
         if(this.guildLevel < 0 || this.guildLevel > 65535)
         {
            throw new Error("Forbidden value (" + this.guildLevel + ") on element guildLevel.");
         }
         else
         {
            param1.writeShort(this.guildLevel);
            if(this.nbMembers < 0 || this.nbMembers > 65535)
            {
               throw new Error("Forbidden value (" + this.nbMembers + ") on element nbMembers.");
            }
            else
            {
               param1.writeShort(this.nbMembers);
               param1.writeBoolean(this.enabled);
               return;
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GuildInAllianceInformations(param1);
      }
      
      public function deserializeAs_GuildInAllianceInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.guildLevel = param1.readUnsignedShort();
         if(this.guildLevel < 0 || this.guildLevel > 65535)
         {
            throw new Error("Forbidden value (" + this.guildLevel + ") on element of GuildInAllianceInformations.guildLevel.");
         }
         else
         {
            this.nbMembers = param1.readUnsignedShort();
            if(this.nbMembers < 0 || this.nbMembers > 65535)
            {
               throw new Error("Forbidden value (" + this.nbMembers + ") on element of GuildInAllianceInformations.nbMembers.");
            }
            else
            {
               this.enabled = param1.readBoolean();
               return;
            }
         }
      }
   }
}
