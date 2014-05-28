package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class FightAllianceTeamInformations extends FightTeamInformations implements INetworkType
   {
      
      public function FightAllianceTeamInformations() {
         super();
      }
      
      public static const protocolId:uint = 439;
      
      public var relation:uint = 0;
      
      override public function getTypeId() : uint {
         return 439;
      }
      
      public function initFightAllianceTeamInformations(teamId:uint = 2, leaderId:int = 0, teamSide:int = 0, teamTypeId:uint = 0, nbWaves:uint = 0, teamMembers:Vector.<FightTeamMemberInformations> = null, relation:uint = 0) : FightAllianceTeamInformations {
         super.initFightTeamInformations(teamId,leaderId,teamSide,teamTypeId,nbWaves,teamMembers);
         this.relation = relation;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.relation = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_FightAllianceTeamInformations(output);
      }
      
      public function serializeAs_FightAllianceTeamInformations(output:IDataOutput) : void {
         super.serializeAs_FightTeamInformations(output);
         output.writeByte(this.relation);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FightAllianceTeamInformations(input);
      }
      
      public function deserializeAs_FightAllianceTeamInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.relation = input.readByte();
         if(this.relation < 0)
         {
            throw new Error("Forbidden value (" + this.relation + ") on element of FightAllianceTeamInformations.relation.");
         }
         else
         {
            return;
         }
      }
   }
}
