package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class FightTeamMemberCharacterInformations extends FightTeamMemberInformations implements INetworkType
   {
      
      public function FightTeamMemberCharacterInformations() {
         super();
      }
      
      public static const protocolId:uint = 13;
      
      public var name:String = "";
      
      public var level:uint = 0;
      
      override public function getTypeId() : uint {
         return 13;
      }
      
      public function initFightTeamMemberCharacterInformations(param1:int=0, param2:String="", param3:uint=0) : FightTeamMemberCharacterInformations {
         super.initFightTeamMemberInformations(param1);
         this.name = param2;
         this.level = param3;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.name = "";
         this.level = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_FightTeamMemberCharacterInformations(param1);
      }
      
      public function serializeAs_FightTeamMemberCharacterInformations(param1:IDataOutput) : void {
         super.serializeAs_FightTeamMemberInformations(param1);
         param1.writeUTF(this.name);
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         else
         {
            param1.writeShort(this.level);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_FightTeamMemberCharacterInformations(param1);
      }
      
      public function deserializeAs_FightTeamMemberCharacterInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.name = param1.readUTF();
         this.level = param1.readShort();
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of FightTeamMemberCharacterInformations.level.");
         }
         else
         {
            return;
         }
      }
   }
}
