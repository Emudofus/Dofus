package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.Vector;
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
      
      public function initFightAllianceTeamInformations(param1:uint=2, param2:int=0, param3:int=0, param4:uint=0, param5:Vector.<FightTeamMemberInformations>=null, param6:uint=0) : FightAllianceTeamInformations {
         super.initFightTeamInformations(param1,param2,param3,param4,param5);
         this.relation = param6;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.relation = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_FightAllianceTeamInformations(param1);
      }
      
      public function serializeAs_FightAllianceTeamInformations(param1:IDataOutput) : void {
         super.serializeAs_FightTeamInformations(param1);
         param1.writeByte(this.relation);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_FightAllianceTeamInformations(param1);
      }
      
      public function deserializeAs_FightAllianceTeamInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.relation = param1.readByte();
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
