package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;


   public class FightResultListEntry extends Object implements INetworkType
   {
         

      public function FightResultListEntry() {
         this.rewards=new FightLoot();
         super();
      }

      public static const protocolId:uint = 16;

      public var outcome:uint = 0;

      public var rewards:FightLoot;

      public function getTypeId() : uint {
         return 16;
      }

      public function initFightResultListEntry(outcome:uint=0, rewards:FightLoot=null) : FightResultListEntry {
         this.outcome=outcome;
         this.rewards=rewards;
         return this;
      }

      public function reset() : void {
         this.outcome=0;
         this.rewards=new FightLoot();
      }

      public function serialize(output:IDataOutput) : void {
         this.serializeAs_FightResultListEntry(output);
      }

      public function serializeAs_FightResultListEntry(output:IDataOutput) : void {
         output.writeShort(this.outcome);
         this.rewards.serializeAs_FightLoot(output);
      }

      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FightResultListEntry(input);
      }

      public function deserializeAs_FightResultListEntry(input:IDataInput) : void {
         this.outcome=input.readShort();
         if(this.outcome<0)
         {
            throw new Error("Forbidden value ("+this.outcome+") on element of FightResultListEntry.outcome.");
         }
         else
         {
            this.rewards=new FightLoot();
            this.rewards.deserialize(input);
            return;
         }
      }
   }

}