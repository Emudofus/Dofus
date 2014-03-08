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
      
      public function initFightTeamMemberWithAllianceCharacterInformations(id:int=0, name:String="", level:uint=0, allianceInfos:BasicAllianceInformations=null) : FightTeamMemberWithAllianceCharacterInformations {
         super.initFightTeamMemberCharacterInformations(id,name,level);
         this.allianceInfos = allianceInfos;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.allianceInfos = new BasicAllianceInformations();
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_FightTeamMemberWithAllianceCharacterInformations(output);
      }
      
      public function serializeAs_FightTeamMemberWithAllianceCharacterInformations(output:IDataOutput) : void {
         super.serializeAs_FightTeamMemberCharacterInformations(output);
         this.allianceInfos.serializeAs_BasicAllianceInformations(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FightTeamMemberWithAllianceCharacterInformations(input);
      }
      
      public function deserializeAs_FightTeamMemberWithAllianceCharacterInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.allianceInfos = new BasicAllianceInformations();
         this.allianceInfos.deserialize(input);
      }
   }
}
