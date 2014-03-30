package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class FightResultTaxCollectorListEntry extends FightResultFighterListEntry implements INetworkType
   {
      
      public function FightResultTaxCollectorListEntry() {
         this.guildInfo = new BasicGuildInformations();
         super();
      }
      
      public static const protocolId:uint = 84;
      
      public var level:uint = 0;
      
      public var guildInfo:BasicGuildInformations;
      
      public var experienceForGuild:int = 0;
      
      override public function getTypeId() : uint {
         return 84;
      }
      
      public function initFightResultTaxCollectorListEntry(outcome:uint=0, wave:uint=0, rewards:FightLoot=null, id:int=0, alive:Boolean=false, level:uint=0, guildInfo:BasicGuildInformations=null, experienceForGuild:int=0) : FightResultTaxCollectorListEntry {
         super.initFightResultFighterListEntry(outcome,wave,rewards,id,alive);
         this.level = level;
         this.guildInfo = guildInfo;
         this.experienceForGuild = experienceForGuild;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.level = 0;
         this.guildInfo = new BasicGuildInformations();
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_FightResultTaxCollectorListEntry(output);
      }
      
      public function serializeAs_FightResultTaxCollectorListEntry(output:IDataOutput) : void {
         super.serializeAs_FightResultFighterListEntry(output);
         if((this.level < 1) || (this.level > 200))
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         else
         {
            output.writeByte(this.level);
            this.guildInfo.serializeAs_BasicGuildInformations(output);
            output.writeInt(this.experienceForGuild);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FightResultTaxCollectorListEntry(input);
      }
      
      public function deserializeAs_FightResultTaxCollectorListEntry(input:IDataInput) : void {
         super.deserialize(input);
         this.level = input.readUnsignedByte();
         if((this.level < 1) || (this.level > 200))
         {
            throw new Error("Forbidden value (" + this.level + ") on element of FightResultTaxCollectorListEntry.level.");
         }
         else
         {
            this.guildInfo = new BasicGuildInformations();
            this.guildInfo.deserialize(input);
            this.experienceForGuild = input.readInt();
            return;
         }
      }
   }
}
