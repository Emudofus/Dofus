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
      
      public function initGameFightFighterMonsterLightInformations(id:int = 0, wave:int = 0, level:uint = 0, breed:int = 0, sex:Boolean = false, alive:Boolean = false, creatureGenericId:uint = 0) : GameFightFighterMonsterLightInformations {
         super.initGameFightFighterLightInformations(id,wave,level,breed,sex,alive);
         this.creatureGenericId = creatureGenericId;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.creatureGenericId = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameFightFighterMonsterLightInformations(output);
      }
      
      public function serializeAs_GameFightFighterMonsterLightInformations(output:IDataOutput) : void {
         super.serializeAs_GameFightFighterLightInformations(output);
         if(this.creatureGenericId < 0)
         {
            throw new Error("Forbidden value (" + this.creatureGenericId + ") on element creatureGenericId.");
         }
         else
         {
            output.writeShort(this.creatureGenericId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightFighterMonsterLightInformations(input);
      }
      
      public function deserializeAs_GameFightFighterMonsterLightInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.creatureGenericId = input.readShort();
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
