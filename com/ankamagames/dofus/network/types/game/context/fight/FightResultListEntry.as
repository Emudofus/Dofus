package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class FightResultListEntry extends Object implements INetworkType
   {
      
      public function FightResultListEntry() {
         this.rewards = new FightLoot();
         super();
      }
      
      public static const protocolId:uint = 16;
      
      public var outcome:uint = 0;
      
      public var wave:uint = 0;
      
      public var rewards:FightLoot;
      
      public function getTypeId() : uint {
         return 16;
      }
      
      public function initFightResultListEntry(outcome:uint=0, wave:uint=0, rewards:FightLoot=null) : FightResultListEntry {
         this.outcome = outcome;
         this.wave = wave;
         this.rewards = rewards;
         return this;
      }
      
      public function reset() : void {
         this.outcome = 0;
         this.wave = 0;
         this.rewards = new FightLoot();
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_FightResultListEntry(output);
      }
      
      public function serializeAs_FightResultListEntry(output:IDataOutput) : void {
         output.writeShort(this.outcome);
         if((this.wave < 0) || (this.wave > 4.294967295E9))
         {
            throw new Error("Forbidden value (" + this.wave + ") on element wave.");
         }
         else
         {
            output.writeUnsignedInt(this.wave);
            this.rewards.serializeAs_FightLoot(output);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FightResultListEntry(input);
      }
      
      public function deserializeAs_FightResultListEntry(input:IDataInput) : void {
         this.outcome = input.readShort();
         if(this.outcome < 0)
         {
            throw new Error("Forbidden value (" + this.outcome + ") on element of FightResultListEntry.outcome.");
         }
         else
         {
            this.wave = input.readUnsignedInt();
            if((this.wave < 0) || (this.wave > 4.294967295E9))
            {
               throw new Error("Forbidden value (" + this.wave + ") on element of FightResultListEntry.wave.");
            }
            else
            {
               this.rewards = new FightLoot();
               this.rewards.deserialize(input);
               return;
            }
         }
      }
   }
}
