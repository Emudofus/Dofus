package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class FightTeamMemberInformations extends Object implements INetworkType
   {
      
      public function FightTeamMemberInformations() {
         super();
      }
      
      public static const protocolId:uint = 44;
      
      public var id:int = 0;
      
      public function getTypeId() : uint {
         return 44;
      }
      
      public function initFightTeamMemberInformations(id:int=0) : FightTeamMemberInformations {
         this.id = id;
         return this;
      }
      
      public function reset() : void {
         this.id = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_FightTeamMemberInformations(output);
      }
      
      public function serializeAs_FightTeamMemberInformations(output:IDataOutput) : void {
         output.writeInt(this.id);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FightTeamMemberInformations(input);
      }
      
      public function deserializeAs_FightTeamMemberInformations(input:IDataInput) : void {
         this.id = input.readInt();
      }
   }
}
