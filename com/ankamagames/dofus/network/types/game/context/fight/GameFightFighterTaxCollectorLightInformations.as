package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameFightFighterTaxCollectorLightInformations extends GameFightFighterLightInformations implements INetworkType
   {
      
      public function GameFightFighterTaxCollectorLightInformations()
      {
         super();
      }
      
      public static const protocolId:uint = 457;
      
      public var firstNameId:uint = 0;
      
      public var lastNameId:uint = 0;
      
      override public function getTypeId() : uint
      {
         return 457;
      }
      
      public function initGameFightFighterTaxCollectorLightInformations(param1:int = 0, param2:uint = 0, param3:uint = 0, param4:int = 0, param5:Boolean = false, param6:Boolean = false, param7:uint = 0, param8:uint = 0) : GameFightFighterTaxCollectorLightInformations
      {
         super.initGameFightFighterLightInformations(param1,param2,param3,param4,param5,param6);
         this.firstNameId = param7;
         this.lastNameId = param8;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.firstNameId = 0;
         this.lastNameId = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_GameFightFighterTaxCollectorLightInformations(param1);
      }
      
      public function serializeAs_GameFightFighterTaxCollectorLightInformations(param1:ICustomDataOutput) : void
      {
         super.serializeAs_GameFightFighterLightInformations(param1);
         if(this.firstNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firstNameId + ") on element firstNameId.");
         }
         else
         {
            param1.writeVarShort(this.firstNameId);
            if(this.lastNameId < 0)
            {
               throw new Error("Forbidden value (" + this.lastNameId + ") on element lastNameId.");
            }
            else
            {
               param1.writeVarShort(this.lastNameId);
               return;
            }
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightFighterTaxCollectorLightInformations(param1);
      }
      
      public function deserializeAs_GameFightFighterTaxCollectorLightInformations(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.firstNameId = param1.readVarUhShort();
         if(this.firstNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firstNameId + ") on element of GameFightFighterTaxCollectorLightInformations.firstNameId.");
         }
         else
         {
            this.lastNameId = param1.readVarUhShort();
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
