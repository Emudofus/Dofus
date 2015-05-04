package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class FightResultTaxCollectorListEntry extends FightResultFighterListEntry implements INetworkType
   {
      
      public function FightResultTaxCollectorListEntry()
      {
         this.guildInfo = new BasicGuildInformations();
         super();
      }
      
      public static const protocolId:uint = 84;
      
      public var level:uint = 0;
      
      public var guildInfo:BasicGuildInformations;
      
      public var experienceForGuild:int = 0;
      
      override public function getTypeId() : uint
      {
         return 84;
      }
      
      public function initFightResultTaxCollectorListEntry(param1:uint = 0, param2:uint = 0, param3:FightLoot = null, param4:int = 0, param5:Boolean = false, param6:uint = 0, param7:BasicGuildInformations = null, param8:int = 0) : FightResultTaxCollectorListEntry
      {
         super.initFightResultFighterListEntry(param1,param2,param3,param4,param5);
         this.level = param6;
         this.guildInfo = param7;
         this.experienceForGuild = param8;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.level = 0;
         this.guildInfo = new BasicGuildInformations();
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_FightResultTaxCollectorListEntry(param1);
      }
      
      public function serializeAs_FightResultTaxCollectorListEntry(param1:ICustomDataOutput) : void
      {
         super.serializeAs_FightResultFighterListEntry(param1);
         if(this.level < 1 || this.level > 200)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         else
         {
            param1.writeByte(this.level);
            this.guildInfo.serializeAs_BasicGuildInformations(param1);
            param1.writeInt(this.experienceForGuild);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_FightResultTaxCollectorListEntry(param1);
      }
      
      public function deserializeAs_FightResultTaxCollectorListEntry(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.level = param1.readUnsignedByte();
         if(this.level < 1 || this.level > 200)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of FightResultTaxCollectorListEntry.level.");
         }
         else
         {
            this.guildInfo = new BasicGuildInformations();
            this.guildInfo.deserialize(param1);
            this.experienceForGuild = param1.readInt();
            return;
         }
      }
   }
}
