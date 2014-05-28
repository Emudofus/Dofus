package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;


   public class GameRolePlayMerchantWithGuildInformations extends GameRolePlayMerchantInformations implements INetworkType
   {
         

      public function GameRolePlayMerchantWithGuildInformations() {
         this.guildInformations=new GuildInformations();
         super();
      }

      public static const protocolId:uint = 146;

      public var guildInformations:GuildInformations;

      override public function getTypeId() : uint {
         return 146;
      }

      public function initGameRolePlayMerchantWithGuildInformations(contextualId:int=0, look:EntityLook=null, disposition:EntityDispositionInformations=null, name:String="", sellType:uint=0, guildInformations:GuildInformations=null) : GameRolePlayMerchantWithGuildInformations {
         super.initGameRolePlayMerchantInformations(contextualId,look,disposition,name,sellType);
         this.guildInformations=guildInformations;
         return this;
      }

      override public function reset() : void {
         super.reset();
         this.guildInformations=new GuildInformations();
      }

      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameRolePlayMerchantWithGuildInformations(output);
      }

      public function serializeAs_GameRolePlayMerchantWithGuildInformations(output:IDataOutput) : void {
         super.serializeAs_GameRolePlayMerchantInformations(output);
         this.guildInformations.serializeAs_GuildInformations(output);
      }

      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameRolePlayMerchantWithGuildInformations(input);
      }

      public function deserializeAs_GameRolePlayMerchantWithGuildInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.guildInformations=new GuildInformations();
         this.guildInformations.deserialize(input);
      }
   }

}