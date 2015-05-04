package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class FightTeamLightInformations extends AbstractFightTeamInformations implements INetworkType
   {
      
      public function FightTeamLightInformations()
      {
         super();
      }
      
      public static const protocolId:uint = 115;
      
      public var teamMembersCount:uint = 0;
      
      public var meanLevel:uint = 0;
      
      public var hasFriend:Boolean = false;
      
      public var hasGuildMember:Boolean = false;
      
      public var hasAllianceMember:Boolean = false;
      
      public var hasGroupMember:Boolean = false;
      
      public var hasMyTaxCollector:Boolean = false;
      
      override public function getTypeId() : uint
      {
         return 115;
      }
      
      public function initFightTeamLightInformations(param1:uint = 2, param2:int = 0, param3:int = 0, param4:uint = 0, param5:uint = 0, param6:uint = 0, param7:uint = 0, param8:Boolean = false, param9:Boolean = false, param10:Boolean = false, param11:Boolean = false, param12:Boolean = false) : FightTeamLightInformations
      {
         super.initAbstractFightTeamInformations(param1,param2,param3,param4,param5);
         this.teamMembersCount = param6;
         this.meanLevel = param7;
         this.hasFriend = param8;
         this.hasGuildMember = param9;
         this.hasAllianceMember = param10;
         this.hasGroupMember = param11;
         this.hasMyTaxCollector = param12;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.teamMembersCount = 0;
         this.meanLevel = 0;
         this.hasFriend = false;
         this.hasGuildMember = false;
         this.hasAllianceMember = false;
         this.hasGroupMember = false;
         this.hasMyTaxCollector = false;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_FightTeamLightInformations(param1);
      }
      
      public function serializeAs_FightTeamLightInformations(param1:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractFightTeamInformations(param1);
         var _loc2_:uint = 0;
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,0,this.hasFriend);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,1,this.hasGuildMember);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,2,this.hasAllianceMember);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,3,this.hasGroupMember);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,4,this.hasMyTaxCollector);
         param1.writeByte(_loc2_);
         if(this.teamMembersCount < 0)
         {
            throw new Error("Forbidden value (" + this.teamMembersCount + ") on element teamMembersCount.");
         }
         else
         {
            param1.writeByte(this.teamMembersCount);
            if(this.meanLevel < 0)
            {
               throw new Error("Forbidden value (" + this.meanLevel + ") on element meanLevel.");
            }
            else
            {
               param1.writeVarInt(this.meanLevel);
               return;
            }
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_FightTeamLightInformations(param1);
      }
      
      public function deserializeAs_FightTeamLightInformations(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         var _loc2_:uint = param1.readByte();
         this.hasFriend = BooleanByteWrapper.getFlag(_loc2_,0);
         this.hasGuildMember = BooleanByteWrapper.getFlag(_loc2_,1);
         this.hasAllianceMember = BooleanByteWrapper.getFlag(_loc2_,2);
         this.hasGroupMember = BooleanByteWrapper.getFlag(_loc2_,3);
         this.hasMyTaxCollector = BooleanByteWrapper.getFlag(_loc2_,4);
         this.teamMembersCount = param1.readByte();
         if(this.teamMembersCount < 0)
         {
            throw new Error("Forbidden value (" + this.teamMembersCount + ") on element of FightTeamLightInformations.teamMembersCount.");
         }
         else
         {
            this.meanLevel = param1.readVarUhInt();
            if(this.meanLevel < 0)
            {
               throw new Error("Forbidden value (" + this.meanLevel + ") on element of FightTeamLightInformations.meanLevel.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
