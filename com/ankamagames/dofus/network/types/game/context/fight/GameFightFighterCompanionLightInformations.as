package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GameFightFighterCompanionLightInformations extends GameFightFighterLightInformations implements INetworkType
   {
      
      public function GameFightFighterCompanionLightInformations() {
         super();
      }
      
      public static const protocolId:uint = 454;
      
      public var companionId:int = 0;
      
      public var masterId:int = 0;
      
      override public function getTypeId() : uint {
         return 454;
      }
      
      public function initGameFightFighterCompanionLightInformations(param1:int=0, param2:uint=0, param3:int=0, param4:Boolean=false, param5:Boolean=false, param6:int=0, param7:int=0) : GameFightFighterCompanionLightInformations {
         super.initGameFightFighterLightInformations(param1,param2,param3,param4,param5);
         this.companionId = param6;
         this.masterId = param7;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.companionId = 0;
         this.masterId = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameFightFighterCompanionLightInformations(param1);
      }
      
      public function serializeAs_GameFightFighterCompanionLightInformations(param1:IDataOutput) : void {
         super.serializeAs_GameFightFighterLightInformations(param1);
         param1.writeInt(this.companionId);
         param1.writeInt(this.masterId);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameFightFighterCompanionLightInformations(param1);
      }
      
      public function deserializeAs_GameFightFighterCompanionLightInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.companionId = param1.readInt();
         this.masterId = param1.readInt();
      }
   }
}
