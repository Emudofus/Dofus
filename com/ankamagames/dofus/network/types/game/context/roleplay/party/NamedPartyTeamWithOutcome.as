package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class NamedPartyTeamWithOutcome extends Object implements INetworkType
   {
      
      public function NamedPartyTeamWithOutcome() {
         this.team = new NamedPartyTeam();
         super();
      }
      
      public static const protocolId:uint = 470;
      
      public var team:NamedPartyTeam;
      
      public var outcome:uint = 0;
      
      public function getTypeId() : uint {
         return 470;
      }
      
      public function initNamedPartyTeamWithOutcome(team:NamedPartyTeam = null, outcome:uint = 0) : NamedPartyTeamWithOutcome {
         this.team = team;
         this.outcome = outcome;
         return this;
      }
      
      public function reset() : void {
         this.team = new NamedPartyTeam();
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_NamedPartyTeamWithOutcome(output);
      }
      
      public function serializeAs_NamedPartyTeamWithOutcome(output:IDataOutput) : void {
         this.team.serializeAs_NamedPartyTeam(output);
         output.writeShort(this.outcome);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_NamedPartyTeamWithOutcome(input);
      }
      
      public function deserializeAs_NamedPartyTeamWithOutcome(input:IDataInput) : void {
         this.team = new NamedPartyTeam();
         this.team.deserialize(input);
         this.outcome = input.readShort();
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
