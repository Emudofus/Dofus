package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class FightResultFighterListEntry extends FightResultListEntry implements INetworkType
   {
      
      public function FightResultFighterListEntry()
      {
         super();
      }
      
      public static const protocolId:uint = 189;
      
      public var id:int = 0;
      
      public var alive:Boolean = false;
      
      override public function getTypeId() : uint
      {
         return 189;
      }
      
      public function initFightResultFighterListEntry(param1:uint = 0, param2:uint = 0, param3:FightLoot = null, param4:int = 0, param5:Boolean = false) : FightResultFighterListEntry
      {
         super.initFightResultListEntry(param1,param2,param3);
         this.id = param4;
         this.alive = param5;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.id = 0;
         this.alive = false;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_FightResultFighterListEntry(param1);
      }
      
      public function serializeAs_FightResultFighterListEntry(param1:ICustomDataOutput) : void
      {
         super.serializeAs_FightResultListEntry(param1);
         param1.writeInt(this.id);
         param1.writeBoolean(this.alive);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_FightResultFighterListEntry(param1);
      }
      
      public function deserializeAs_FightResultFighterListEntry(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.id = param1.readInt();
         this.alive = param1.readBoolean();
      }
   }
}
