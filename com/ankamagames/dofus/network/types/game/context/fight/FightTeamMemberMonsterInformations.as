package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class FightTeamMemberMonsterInformations extends FightTeamMemberInformations implements INetworkType
   {
      
      public function FightTeamMemberMonsterInformations() {
         super();
      }
      
      public static const protocolId:uint = 6;
      
      public var monsterId:int = 0;
      
      public var grade:uint = 0;
      
      override public function getTypeId() : uint {
         return 6;
      }
      
      public function initFightTeamMemberMonsterInformations(id:int=0, monsterId:int=0, grade:uint=0) : FightTeamMemberMonsterInformations {
         super.initFightTeamMemberInformations(id);
         this.monsterId = monsterId;
         this.grade = grade;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.monsterId = 0;
         this.grade = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_FightTeamMemberMonsterInformations(output);
      }
      
      public function serializeAs_FightTeamMemberMonsterInformations(output:IDataOutput) : void {
         super.serializeAs_FightTeamMemberInformations(output);
         output.writeInt(this.monsterId);
         if(this.grade < 0)
         {
            throw new Error("Forbidden value (" + this.grade + ") on element grade.");
         }
         else
         {
            output.writeByte(this.grade);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FightTeamMemberMonsterInformations(input);
      }
      
      public function deserializeAs_FightTeamMemberMonsterInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.monsterId = input.readInt();
         this.grade = input.readByte();
         if(this.grade < 0)
         {
            throw new Error("Forbidden value (" + this.grade + ") on element of FightTeamMemberMonsterInformations.grade.");
         }
         else
         {
            return;
         }
      }
   }
}
