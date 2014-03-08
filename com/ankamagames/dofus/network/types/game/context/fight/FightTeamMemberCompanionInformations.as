package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class FightTeamMemberCompanionInformations extends FightTeamMemberInformations implements INetworkType
   {
      
      public function FightTeamMemberCompanionInformations() {
         super();
      }
      
      public static const protocolId:uint = 451;
      
      public var companionId:int = 0;
      
      public var level:uint = 0;
      
      public var masterId:int = 0;
      
      override public function getTypeId() : uint {
         return 451;
      }
      
      public function initFightTeamMemberCompanionInformations(id:int=0, companionId:int=0, level:uint=0, masterId:int=0) : FightTeamMemberCompanionInformations {
         super.initFightTeamMemberInformations(id);
         this.companionId = companionId;
         this.level = level;
         this.masterId = masterId;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.companionId = 0;
         this.level = 0;
         this.masterId = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_FightTeamMemberCompanionInformations(output);
      }
      
      public function serializeAs_FightTeamMemberCompanionInformations(output:IDataOutput) : void {
         super.serializeAs_FightTeamMemberInformations(output);
         output.writeInt(this.companionId);
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         else
         {
            output.writeShort(this.level);
            output.writeInt(this.masterId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FightTeamMemberCompanionInformations(input);
      }
      
      public function deserializeAs_FightTeamMemberCompanionInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.companionId = input.readInt();
         this.level = input.readShort();
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of FightTeamMemberCompanionInformations.level.");
         }
         else
         {
            this.masterId = input.readInt();
            return;
         }
      }
   }
}
