package com.ankamagames.dofus.network.types.game.paddock
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class PaddockPrivateInformations extends PaddockAbandonnedInformations implements INetworkType
   {
      
      public function PaddockPrivateInformations()
      {
         this.guildInfo = new GuildInformations();
         super();
      }
      
      public static const protocolId:uint = 131;
      
      public var guildInfo:GuildInformations;
      
      override public function getTypeId() : uint
      {
         return 131;
      }
      
      public function initPaddockPrivateInformations(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:Boolean = false, param5:int = 0, param6:GuildInformations = null) : PaddockPrivateInformations
      {
         super.initPaddockAbandonnedInformations(param1,param2,param3,param4,param5);
         this.guildInfo = param6;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.guildInfo = new GuildInformations();
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_PaddockPrivateInformations(param1);
      }
      
      public function serializeAs_PaddockPrivateInformations(param1:ICustomDataOutput) : void
      {
         super.serializeAs_PaddockAbandonnedInformations(param1);
         this.guildInfo.serializeAs_GuildInformations(param1);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_PaddockPrivateInformations(param1);
      }
      
      public function deserializeAs_PaddockPrivateInformations(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.guildInfo = new GuildInformations();
         this.guildInfo.deserialize(param1);
      }
   }
}
