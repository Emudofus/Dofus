package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class NamedPartyTeamWithOutcome extends Object implements INetworkType
   {
      
      public function NamedPartyTeamWithOutcome()
      {
         this.team = new NamedPartyTeam();
         super();
      }
      
      public static const protocolId:uint = 470;
      
      public var team:NamedPartyTeam;
      
      public var outcome:uint = 0;
      
      public function getTypeId() : uint
      {
         return 470;
      }
      
      public function initNamedPartyTeamWithOutcome(param1:NamedPartyTeam = null, param2:uint = 0) : NamedPartyTeamWithOutcome
      {
         this.team = param1;
         this.outcome = param2;
         return this;
      }
      
      public function reset() : void
      {
         this.team = new NamedPartyTeam();
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_NamedPartyTeamWithOutcome(param1);
      }
      
      public function serializeAs_NamedPartyTeamWithOutcome(param1:ICustomDataOutput) : void
      {
         this.team.serializeAs_NamedPartyTeam(param1);
         param1.writeVarShort(this.outcome);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_NamedPartyTeamWithOutcome(param1);
      }
      
      public function deserializeAs_NamedPartyTeamWithOutcome(param1:ICustomDataInput) : void
      {
         this.team = new NamedPartyTeam();
         this.team.deserialize(param1);
         this.outcome = param1.readVarUhShort();
         if(this.outcome < 0)
         {
            throw new Error("Forbidden value (" + this.outcome + ") on element of NamedPartyTeamWithOutcome.outcome.");
         }
         else
         {
            return;
         }
      }
   }
}
