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
      
      public function initFightTeamMemberCharacterInformations(id:int=0, name:String="", level:uint=0) : FightTeamMemberCharacterInformations {
         super.initFightTeamMemberInformations(id);
         this.name = name;
         this.level = level;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.name = "";
         this.level = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_FightTeamMemberCharacterInformations(output);
      }
      
      public function serializeAs_FightTeamMemberCharacterInformations(output:IDataOutput) : void {
         super.serializeAs_FightTeamMemberInformations(output);
         output.writeUTF(this.name);
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         else
         {
            output.writeShort(this.level);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FightTeamMemberCharacterInformations(input);
      }
      
      public function deserializeAs_FightTeamMemberCharacterInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.name = input.readUTF();
         this.level = input.readShort();
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
