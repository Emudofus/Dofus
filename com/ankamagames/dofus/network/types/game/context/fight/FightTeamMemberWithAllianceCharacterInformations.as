package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicAllianceInformations;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class FightTeamMemberWithAllianceCharacterInformations extends FightTeamMemberCharacterInformations implements INetworkType
   {
      
      public function FightTeamMemberWithAllianceCharacterInformations() {
         this.allianceInfos = new BasicAllianceInformations();
         super();
      }
      
      public static const protocolId:uint = 426;
      
      public var allianceInfos:BasicAllianceInformations;
      
      override public function getTypeId() : uint {
         return 426;
      }
      
      public function initFightTeamMemberWithAllianceCharacterInformations(param1:int=0, param2:String="", param3:uint=0, param4:BasicAllianceInformations=null) : FightTeamMemberWithAllianceCharacterInformations {
         super.initFightTeamMemberCharacterInformations(param1,param2,param3);
         this.allianceInfos = param4;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.allianceInfos = new BasicAllianceInformations();
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_FightTeamMemberWithAllianceCharacterInformations(param1);
      }
      
      public function serializeAs_FightTeamMemberWithAllianceCharacterInformations(param1:IDataOutput) : void {
         super.serializeAs_FightTeamMemberCharacterInformations(param1);
         this.allianceInfos.serializeAs_BasicAllianceInformations(param1);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_FightTeamMemberWithAllianceCharacterInformations(param1);
      }
      
      public function deserializeAs_FightTeamMemberWithAllianceCharacterInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.allianceInfos = new BasicAllianceInformations();
         this.allianceInfos.deserialize(param1);
      }
   }
}
