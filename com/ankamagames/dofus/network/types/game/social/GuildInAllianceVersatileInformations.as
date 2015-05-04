package com.ankamagames.dofus.network.types.game.social
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GuildInAllianceVersatileInformations extends GuildVersatileInformations implements INetworkType
   {
      
      public function GuildInAllianceVersatileInformations()
      {
         super();
      }
      
      public static const protocolId:uint = 437;
      
      public var allianceId:uint = 0;
      
      override public function getTypeId() : uint
      {
         return 437;
      }
      
      public function initGuildInAllianceVersatileInformations(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:uint = 0, param5:uint = 0) : GuildInAllianceVersatileInformations
      {
         super.initGuildVersatileInformations(param1,param2,param3,param4);
         this.allianceId = param5;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.allianceId = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_GuildInAllianceVersatileInformations(param1);
      }
      
      public function serializeAs_GuildInAllianceVersatileInformations(param1:ICustomDataOutput) : void
      {
         super.serializeAs_GuildVersatileInformations(param1);
         if(this.allianceId < 0)
         {
            throw new Error("Forbidden value (" + this.allianceId + ") on element allianceId.");
         }
         else
         {
            param1.writeVarInt(this.allianceId);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GuildInAllianceVersatileInformations(param1);
      }
      
      public function deserializeAs_GuildInAllianceVersatileInformations(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.allianceId = param1.readVarUhInt();
         if(this.allianceId < 0)
         {
            throw new Error("Forbidden value (" + this.allianceId + ") on element of GuildInAllianceVersatileInformations.allianceId.");
         }
         else
         {
            return;
         }
      }
   }
}
