package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GameFightCompanionInformations extends GameFightFighterInformations implements INetworkType
   {
      
      public function GameFightCompanionInformations() {
         super();
      }
      
      public static const protocolId:uint = 450;
      
      public var companionGenericId:uint = 0;
      
      public var level:uint = 0;
      
      public var masterId:int = 0;
      
      override public function getTypeId() : uint {
         return 450;
      }
      
      public function initGameFightCompanionInformations(contextualId:int=0, look:EntityLook=null, disposition:EntityDispositionInformations=null, teamId:uint=2, wave:uint=0, alive:Boolean=false, stats:GameFightMinimalStats=null, companionGenericId:uint=0, level:uint=0, masterId:int=0) : GameFightCompanionInformations {
         super.initGameFightFighterInformations(contextualId,look,disposition,teamId,wave,alive,stats);
         this.companionGenericId = companionGenericId;
         this.level = level;
         this.masterId = masterId;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.companionGenericId = 0;
         this.level = 0;
         this.masterId = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameFightCompanionInformations(output);
      }
      
      public function serializeAs_GameFightCompanionInformations(output:IDataOutput) : void {
         super.serializeAs_GameFightFighterInformations(output);
         if(this.companionGenericId < 0)
         {
            throw new Error("Forbidden value (" + this.companionGenericId + ") on element companionGenericId.");
         }
         else
         {
            output.writeShort(this.companionGenericId);
            if(this.level < 0)
            {
               throw new Error("Forbidden value (" + this.level + ") on element level.");
            }
            else
            {
               output.writeShort(this.level);
               output.writeInt(this.masterId);
               return;
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightCompanionInformations(input);
      }
      
      public function deserializeAs_GameFightCompanionInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.companionGenericId = input.readShort();
         if(this.companionGenericId < 0)
         {
            throw new Error("Forbidden value (" + this.companionGenericId + ") on element of GameFightCompanionInformations.companionGenericId.");
         }
         else
         {
            this.level = input.readShort();
            if(this.level < 0)
            {
               throw new Error("Forbidden value (" + this.level + ") on element of GameFightCompanionInformations.level.");
            }
            else
            {
               this.masterId = input.readInt();
               return;
            }
         }
      }
   }
}
