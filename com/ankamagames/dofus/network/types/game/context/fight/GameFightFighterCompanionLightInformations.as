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
      
      public function initGameFightFighterCompanionLightInformations(id:int=0, wave:int=0, level:uint=0, breed:int=0, sex:Boolean=false, alive:Boolean=false, companionId:int=0, masterId:int=0) : GameFightFighterCompanionLightInformations {
         super.initGameFightFighterLightInformations(id,wave,level,breed,sex,alive);
         this.companionId = companionId;
         this.masterId = masterId;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.companionId = 0;
         this.masterId = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameFightFighterCompanionLightInformations(output);
      }
      
      public function serializeAs_GameFightFighterCompanionLightInformations(output:IDataOutput) : void {
         super.serializeAs_GameFightFighterLightInformations(output);
         output.writeInt(this.companionId);
         output.writeInt(this.masterId);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightFighterCompanionLightInformations(input);
      }
      
      public function deserializeAs_GameFightFighterCompanionLightInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.companionId = input.readInt();
         this.masterId = input.readInt();
      }
   }
}
