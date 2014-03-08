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
      
      public function initFightTeamMemberInformations(param1:int=0) : FightTeamMemberInformations {
         this.id = param1;
         return this;
      }
      
      public function reset() : void {
         this.id = 0;
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_FightTeamMemberInformations(param1);
      }
      
      public function serializeAs_FightTeamMemberInformations(param1:IDataOutput) : void {
         param1.writeInt(this.id);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_FightTeamMemberInformations(param1);
      }
      
      public function deserializeAs_FightTeamMemberInformations(param1:IDataInput) : void {
         this.id = param1.readInt();
      }
   }
}
