package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.companion.PartyCompanionMemberInformations;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class PartyMemberArenaInformations extends PartyMemberInformations implements INetworkType
   {
      
      public function PartyMemberArenaInformations() {
         super();
      }
      
      public static const protocolId:uint = 391;
      
      public var rank:uint = 0;
      
      override public function getTypeId() : uint {
         return 391;
      }
      
      public function initPartyMemberArenaInformations(param1:uint=0, param2:uint=0, param3:String="", param4:EntityLook=null, param5:int=0, param6:Boolean=false, param7:uint=0, param8:uint=0, param9:uint=0, param10:uint=0, param11:uint=0, param12:int=0, param13:int=0, param14:int=0, param15:int=0, param16:uint=0, param17:PlayerStatus=null, param18:Vector.<PartyCompanionMemberInformations>=null, param19:uint=0) : PartyMemberArenaInformations {
         super.initPartyMemberInformations(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13,param14,param15,param16,param17,param18);
         this.rank = param19;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.rank = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_PartyMemberArenaInformations(param1);
      }
      
      public function serializeAs_PartyMemberArenaInformations(param1:IDataOutput) : void {
         super.serializeAs_PartyMemberInformations(param1);
         if(this.rank < 0 || this.rank > 2300)
         {
            throw new Error("Forbidden value (" + this.rank + ") on element rank.");
         }
         else
         {
            param1.writeShort(this.rank);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PartyMemberArenaInformations(param1);
      }
      
      public function deserializeAs_PartyMemberArenaInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.rank = param1.readShort();
         if(this.rank < 0 || this.rank > 2300)
         {
            throw new Error("Forbidden value (" + this.rank + ") on element of PartyMemberArenaInformations.rank.");
         }
         else
         {
            return;
         }
      }
   }
}
