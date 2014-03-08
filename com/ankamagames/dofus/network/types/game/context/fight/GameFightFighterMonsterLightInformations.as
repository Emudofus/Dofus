package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GameFightFighterMonsterLightInformations extends GameFightFighterLightInformations implements INetworkType
   {
      
      public function GameFightFighterMonsterLightInformations() {
         super();
      }
      
      public static const protocolId:uint = 455;
      
      public var creatureGenericId:uint = 0;
      
      override public function getTypeId() : uint {
         return 455;
      }
      
      public function initGameFightFighterMonsterLightInformations(param1:int=0, param2:uint=0, param3:int=0, param4:Boolean=false, param5:Boolean=false, param6:uint=0) : GameFightFighterMonsterLightInformations {
         super.initGameFightFighterLightInformations(param1,param2,param3,param4,param5);
         this.creatureGenericId = param6;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.creatureGenericId = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameFightFighterMonsterLightInformations(param1);
      }
      
      public function serializeAs_GameFightFighterMonsterLightInformations(param1:IDataOutput) : void {
         super.serializeAs_GameFightFighterLightInformations(param1);
         if(this.creatureGenericId < 0)
         {
            throw new Error("Forbidden value (" + this.creatureGenericId + ") on element creatureGenericId.");
         }
         else
         {
            param1.writeShort(this.creatureGenericId);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameFightFighterMonsterLightInformations(param1);
      }
      
      public function deserializeAs_GameFightFighterMonsterLightInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.creatureGenericId = param1.readShort();
         if(this.creatureGenericId < 0)
         {
            throw new Error("Forbidden value (" + this.creatureGenericId + ") on element of GameFightFighterMonsterLightInformations.creatureGenericId.");
         }
         else
         {
            return;
         }
      }
   }
}
