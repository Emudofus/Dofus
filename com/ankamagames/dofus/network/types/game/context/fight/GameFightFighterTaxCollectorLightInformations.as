package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GameFightFighterTaxCollectorLightInformations extends GameFightFighterLightInformations implements INetworkType
   {
      
      public function GameFightFighterTaxCollectorLightInformations() {
         super();
      }
      
      public static const protocolId:uint = 457;
      
      public var firstNameId:uint = 0;
      
      public var lastNameId:uint = 0;
      
      override public function getTypeId() : uint {
         return 457;
      }
      
      public function initGameFightFighterTaxCollectorLightInformations(param1:int=0, param2:uint=0, param3:int=0, param4:Boolean=false, param5:Boolean=false, param6:uint=0, param7:uint=0) : GameFightFighterTaxCollectorLightInformations {
         super.initGameFightFighterLightInformations(param1,param2,param3,param4,param5);
         this.firstNameId = param6;
         this.lastNameId = param7;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.firstNameId = 0;
         this.lastNameId = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameFightFighterTaxCollectorLightInformations(param1);
      }
      
      public function serializeAs_GameFightFighterTaxCollectorLightInformations(param1:IDataOutput) : void {
         super.serializeAs_GameFightFighterLightInformations(param1);
         if(this.firstNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firstNameId + ") on element firstNameId.");
         }
         else
         {
            param1.writeShort(this.firstNameId);
            if(this.lastNameId < 0)
            {
               throw new Error("Forbidden value (" + this.lastNameId + ") on element lastNameId.");
            }
            else
            {
               param1.writeShort(this.lastNameId);
               return;
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameFightFighterTaxCollectorLightInformations(param1);
      }
      
      public function deserializeAs_GameFightFighterTaxCollectorLightInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.firstNameId = param1.readShort();
         if(this.firstNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firstNameId + ") on element of GameFightFighterTaxCollectorLightInformations.firstNameId.");
         }
         else
         {
            this.lastNameId = param1.readShort();
            if(this.lastNameId < 0)
            {
               throw new Error("Forbidden value (" + this.lastNameId + ") on element of GameFightFighterTaxCollectorLightInformations.lastNameId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
