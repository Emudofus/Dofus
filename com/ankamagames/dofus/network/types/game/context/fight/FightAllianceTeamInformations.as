package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class FightAllianceTeamInformations extends FightTeamInformations implements INetworkType
   {
      
      public function FightAllianceTeamInformations()
      {
         super();
      }
      
      public static const protocolId:uint = 439;
      
      public var relation:uint = 0;
      
      override public function getTypeId() : uint
      {
         return 439;
      }
      
      public function initFightAllianceTeamInformations(param1:uint = 2, param2:int = 0, param3:int = 0, param4:uint = 0, param5:uint = 0, param6:Vector.<FightTeamMemberInformations> = null, param7:uint = 0) : FightAllianceTeamInformations
      {
         super.initFightTeamInformations(param1,param2,param3,param4,param5,param6);
         this.relation = param7;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.relation = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_FightAllianceTeamInformations(param1);
      }
      
      public function serializeAs_FightAllianceTeamInformations(param1:ICustomDataOutput) : void
      {
         super.serializeAs_FightTeamInformations(param1);
         param1.writeByte(this.relation);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_FightAllianceTeamInformations(param1);
      }
      
      public function deserializeAs_FightAllianceTeamInformations(param1:ICustomDataInput) : void
      {
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
