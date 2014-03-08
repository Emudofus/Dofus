package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.dofus.network.types.game.social.AbstractSocialGroupInfos;
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class BasicGuildInformations extends AbstractSocialGroupInfos implements INetworkType
   {
      
      public function BasicGuildInformations() {
         super();
      }
      
      public static const protocolId:uint = 365;
      
      public var guildId:uint = 0;
      
      public var guildName:String = "";
      
      override public function getTypeId() : uint {
         return 365;
      }
      
      public function initBasicGuildInformations(guildId:uint=0, guildName:String="") : BasicGuildInformations {
         this.guildId = guildId;
         this.guildName = guildName;
         return this;
      }
      
      override public function reset() : void {
         this.guildId = 0;
         this.guildName = "";
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_BasicGuildInformations(output);
      }
      
      public function serializeAs_BasicGuildInformations(output:IDataOutput) : void {
         super.serializeAs_AbstractSocialGroupInfos(output);
         if(this.guildId < 0)
         {
            throw new Error("Forbidden value (" + this.guildId + ") on element guildId.");
         }
         else
         {
            output.writeInt(this.guildId);
            output.writeUTF(this.guildName);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_BasicGuildInformations(input);
      }
      
      public function deserializeAs_BasicGuildInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.guildId = input.readInt();
         if(this.guildId < 0)
         {
            throw new Error("Forbidden value (" + this.guildId + ") on element of BasicGuildInformations.guildId.");
         }
         else
         {
            this.guildName = input.readUTF();
            return;
         }
      }
   }
}
