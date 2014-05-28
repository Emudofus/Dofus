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
      
      public function initGameFightAIInformations(contextualId:int = 0, look:EntityLook = null, disposition:EntityDispositionInformations = null, teamId:uint = 2, wave:uint = 0, alive:Boolean = false, stats:GameFightMinimalStats = null) : GameFightAIInformations {
         super.initGameFightFighterInformations(contextualId,look,disposition,teamId,wave,alive,stats);
         return this;
      }
      
      override public function reset() : void {
         super.reset();
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameFightAIInformations(output);
      }
      
      public function serializeAs_GameFightAIInformations(output:IDataOutput) : void {
         super.serializeAs_GameFightFighterInformations(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightAIInformations(input);
      }
      
      public function deserializeAs_GameFightAIInformations(input:IDataInput) : void {
         super.deserialize(input);
      }
   }
}
