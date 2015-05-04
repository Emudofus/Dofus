package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class FightTeamMemberCharacterInformations extends FightTeamMemberInformations implements INetworkType
   {
      
      public function FightTeamMemberCharacterInformations()
      {
         super();
      }
      
      public static const protocolId:uint = 13;
      
      public var name:String = "";
      
      public var level:uint = 0;
      
      override public function getTypeId() : uint
      {
         return 13;
      }
      
      public function initFightTeamMemberCharacterInformations(param1:int = 0, param2:String = "", param3:uint = 0) : FightTeamMemberCharacterInformations
      {
         super.initFightTeamMemberInformations(param1);
         this.name = param2;
         this.level = param3;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.name = "";
         this.level = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_FightTeamMemberCharacterInformations(param1);
      }
      
      public function serializeAs_FightTeamMemberCharacterInformations(param1:ICustomDataOutput) : void
      {
         super.serializeAs_FightTeamMemberInformations(param1);
         param1.writeUTF(this.name);
         if(this.level < 0 || this.level > 255)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         else
         {
            param1.writeByte(this.level);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_FightTeamMemberCharacterInformations(param1);
      }
      
      public function deserializeAs_FightTeamMemberCharacterInformations(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.name = param1.readUTF();
         this.level = param1.readUnsignedByte();
         if(this.level < 0 || this.level > 255)
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
