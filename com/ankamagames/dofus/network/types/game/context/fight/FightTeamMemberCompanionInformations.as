package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class FightTeamMemberCompanionInformations extends FightTeamMemberInformations implements INetworkType
   {
      
      public function FightTeamMemberCompanionInformations()
      {
         super();
      }
      
      public static const protocolId:uint = 451;
      
      public var companionId:uint = 0;
      
      public var level:uint = 0;
      
      public var masterId:int = 0;
      
      override public function getTypeId() : uint
      {
         return 451;
      }
      
      public function initFightTeamMemberCompanionInformations(param1:int = 0, param2:uint = 0, param3:uint = 0, param4:int = 0) : FightTeamMemberCompanionInformations
      {
         super.initFightTeamMemberInformations(param1);
         this.companionId = param2;
         this.level = param3;
         this.masterId = param4;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.companionId = 0;
         this.level = 0;
         this.masterId = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_FightTeamMemberCompanionInformations(param1);
      }
      
      public function serializeAs_FightTeamMemberCompanionInformations(param1:ICustomDataOutput) : void
      {
         super.serializeAs_FightTeamMemberInformations(param1);
         if(this.companionId < 0)
         {
            throw new Error("Forbidden value (" + this.companionId + ") on element companionId.");
         }
         else
         {
            param1.writeByte(this.companionId);
            if(this.level < 1 || this.level > 200)
            {
               throw new Error("Forbidden value (" + this.level + ") on element level.");
            }
            else
            {
               param1.writeByte(this.level);
               param1.writeInt(this.masterId);
               return;
            }
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_FightTeamMemberCompanionInformations(param1);
      }
      
      public function deserializeAs_FightTeamMemberCompanionInformations(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.companionId = param1.readByte();
         if(this.companionId < 0)
         {
            throw new Error("Forbidden value (" + this.companionId + ") on element of FightTeamMemberCompanionInformations.companionId.");
         }
         else
         {
            this.level = param1.readUnsignedByte();
            if(this.level < 1 || this.level > 200)
            {
               throw new Error("Forbidden value (" + this.level + ") on element of FightTeamMemberCompanionInformations.level.");
            }
            else
            {
               this.masterId = param1.readInt();
               return;
            }
         }
      }
   }
}
