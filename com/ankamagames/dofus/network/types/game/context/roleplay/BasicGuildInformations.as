package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.dofus.network.types.game.social.AbstractSocialGroupInfos;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class BasicGuildInformations extends AbstractSocialGroupInfos implements INetworkType
   {
      
      public function BasicGuildInformations()
      {
         super();
      }
      
      public static const protocolId:uint = 365;
      
      public var guildId:uint = 0;
      
      public var guildName:String = "";
      
      override public function getTypeId() : uint
      {
         return 365;
      }
      
      public function initBasicGuildInformations(param1:uint = 0, param2:String = "") : BasicGuildInformations
      {
         this.guildId = param1;
         this.guildName = param2;
         return this;
      }
      
      override public function reset() : void
      {
         this.guildId = 0;
         this.guildName = "";
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_BasicGuildInformations(param1);
      }
      
      public function serializeAs_BasicGuildInformations(param1:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractSocialGroupInfos(param1);
         if(this.guildId < 0)
         {
            throw new Error("Forbidden value (" + this.guildId + ") on element guildId.");
         }
         else
         {
            param1.writeVarInt(this.guildId);
            param1.writeUTF(this.guildName);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_BasicGuildInformations(param1);
      }
      
      public function deserializeAs_BasicGuildInformations(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.guildId = param1.readVarUhInt();
         if(this.guildId < 0)
         {
            throw new Error("Forbidden value (" + this.guildId + ") on element of BasicGuildInformations.guildId.");
         }
         else
         {
            this.guildName = param1.readUTF();
            return;
         }
      }
   }
}
