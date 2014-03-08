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
      
      public function initGameFightCompanionInformations(param1:int=0, param2:EntityLook=null, param3:EntityDispositionInformations=null, param4:uint=2, param5:Boolean=false, param6:GameFightMinimalStats=null, param7:uint=0, param8:uint=0, param9:int=0) : GameFightCompanionInformations {
         super.initGameFightFighterInformations(param1,param2,param3,param4,param5,param6);
         this.companionGenericId = param7;
         this.level = param8;
         this.masterId = param9;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.companionGenericId = 0;
         this.level = 0;
         this.masterId = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameFightCompanionInformations(param1);
      }
      
      public function serializeAs_GameFightCompanionInformations(param1:IDataOutput) : void {
         super.serializeAs_GameFightFighterInformations(param1);
         if(this.companionGenericId < 0)
         {
            throw new Error("Forbidden value (" + this.companionGenericId + ") on element companionGenericId.");
         }
         else
         {
            param1.writeShort(this.companionGenericId);
            if(this.level < 0)
            {
               throw new Error("Forbidden value (" + this.level + ") on element level.");
            }
            else
            {
               param1.writeShort(this.level);
               param1.writeInt(this.masterId);
               return;
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameFightCompanionInformations(param1);
      }
      
      public function deserializeAs_GameFightCompanionInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.companionGenericId = param1.readShort();
         if(this.companionGenericId < 0)
         {
            throw new Error("Forbidden value (" + this.companionGenericId + ") on element of GameFightCompanionInformations.companionGenericId.");
         }
         else
         {
            this.level = param1.readShort();
            if(this.level < 0)
            {
               throw new Error("Forbidden value (" + this.level + ") on element of GameFightCompanionInformations.level.");
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
