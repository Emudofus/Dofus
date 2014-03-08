package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GameFightAIInformations extends GameFightFighterInformations implements INetworkType
   {
      
      public function GameFightAIInformations() {
         super();
      }
      
      public static const protocolId:uint = 151;
      
      override public function getTypeId() : uint {
         return 151;
      }
      
      public function initGameFightAIInformations(param1:int=0, param2:EntityLook=null, param3:EntityDispositionInformations=null, param4:uint=2, param5:Boolean=false, param6:GameFightMinimalStats=null) : GameFightAIInformations {
         super.initGameFightFighterInformations(param1,param2,param3,param4,param5,param6);
         return this;
      }
      
      override public function reset() : void {
         super.reset();
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameFightAIInformations(param1);
      }
      
      public function serializeAs_GameFightAIInformations(param1:IDataOutput) : void {
         super.serializeAs_GameFightFighterInformations(param1);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameFightAIInformations(param1);
      }
      
      public function deserializeAs_GameFightAIInformations(param1:IDataInput) : void {
         super.deserialize(param1);
      }
   }
}
