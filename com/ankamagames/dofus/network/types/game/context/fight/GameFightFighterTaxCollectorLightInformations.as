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
      
      public function initGameFightFighterTaxCollectorLightInformations(id:int=0, wave:int=0, level:uint=0, breed:int=0, sex:Boolean=false, alive:Boolean=false, firstNameId:uint=0, lastNameId:uint=0) : GameFightFighterTaxCollectorLightInformations {
         super.initGameFightFighterLightInformations(id,wave,level,breed,sex,alive);
         this.firstNameId = firstNameId;
         this.lastNameId = lastNameId;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.firstNameId = 0;
         this.lastNameId = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameFightFighterTaxCollectorLightInformations(output);
      }
      
      public function serializeAs_GameFightFighterTaxCollectorLightInformations(output:IDataOutput) : void {
         super.serializeAs_GameFightFighterLightInformations(output);
         if(this.firstNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firstNameId + ") on element firstNameId.");
         }
         else
         {
            output.writeShort(this.firstNameId);
            if(this.lastNameId < 0)
            {
               throw new Error("Forbidden value (" + this.lastNameId + ") on element lastNameId.");
            }
            else
            {
               output.writeShort(this.lastNameId);
               return;
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightFighterTaxCollectorLightInformations(input);
      }
      
      public function deserializeAs_GameFightFighterTaxCollectorLightInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.firstNameId = input.readShort();
         if(this.firstNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firstNameId + ") on element of GameFightFighterTaxCollectorLightInformations.firstNameId.");
         }
         else
         {
            this.lastNameId = input.readShort();
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
