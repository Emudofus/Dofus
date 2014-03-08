package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.Vector;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class FightTeamInformations extends AbstractFightTeamInformations implements INetworkType
   {
      
      public function FightTeamInformations() {
         this.teamMembers = new Vector.<FightTeamMemberInformations>();
         super();
      }
      
      public static const protocolId:uint = 33;
      
      public var teamMembers:Vector.<FightTeamMemberInformations>;
      
      override public function getTypeId() : uint {
         return 33;
      }
      
      public function initFightTeamInformations(param1:uint=2, param2:int=0, param3:int=0, param4:uint=0, param5:Vector.<FightTeamMemberInformations>=null) : FightTeamInformations {
         super.initAbstractFightTeamInformations(param1,param2,param3,param4);
         this.teamMembers = param5;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.teamMembers = new Vector.<FightTeamMemberInformations>();
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_FightTeamInformations(param1);
      }
      
      public function serializeAs_FightTeamInformations(param1:IDataOutput) : void {
         super.serializeAs_AbstractFightTeamInformations(param1);
         param1.writeShort(this.teamMembers.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.teamMembers.length)
         {
            param1.writeShort((this.teamMembers[_loc2_] as FightTeamMemberInformations).getTypeId());
            (this.teamMembers[_loc2_] as FightTeamMemberInformations).serialize(param1);
            _loc2_++;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_FightTeamInformations(param1);
      }
      
      public function deserializeAs_FightTeamInformations(param1:IDataInput) : void {
         var _loc4_:uint = 0;
         var _loc5_:FightTeamMemberInformations = null;
         super.deserialize(param1);
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readUnsignedShort();
            _loc5_ = ProtocolTypeManager.getInstance(FightTeamMemberInformations,_loc4_);
            _loc5_.deserialize(param1);
            this.teamMembers.push(_loc5_);
            _loc3_++;
         }
      }
   }
}
