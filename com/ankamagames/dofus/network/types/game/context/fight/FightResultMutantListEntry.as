package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class FightResultMutantListEntry extends FightResultFighterListEntry implements INetworkType
   {
      
      public function FightResultMutantListEntry()
      {
         super();
      }
      
      public static const protocolId:uint = 216;
      
      public var level:uint = 0;
      
      override public function getTypeId() : uint
      {
         return 216;
      }
      
      public function initFightResultMutantListEntry(param1:uint = 0, param2:uint = 0, param3:FightLoot = null, param4:int = 0, param5:Boolean = false, param6:uint = 0) : FightResultMutantListEntry
      {
         super.initFightResultFighterListEntry(param1,param2,param3,param4,param5);
         this.level = param6;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.level = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_FightResultMutantListEntry(param1);
      }
      
      public function serializeAs_FightResultMutantListEntry(param1:ICustomDataOutput) : void
      {
         super.serializeAs_FightResultFighterListEntry(param1);
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         else
         {
            param1.writeVarShort(this.level);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_FightResultMutantListEntry(param1);
      }
      
      public function deserializeAs_FightResultMutantListEntry(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.level = param1.readVarUhShort();
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of FightResultMutantListEntry.level.");
         }
         else
         {
            return;
         }
      }
   }
}
