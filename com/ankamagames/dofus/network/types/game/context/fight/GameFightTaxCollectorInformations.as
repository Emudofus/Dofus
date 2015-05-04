package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameFightTaxCollectorInformations extends GameFightAIInformations implements INetworkType
   {
      
      public function GameFightTaxCollectorInformations()
      {
         super();
      }
      
      public static const protocolId:uint = 48;
      
      public var firstNameId:uint = 0;
      
      public var lastNameId:uint = 0;
      
      public var level:uint = 0;
      
      override public function getTypeId() : uint
      {
         return 48;
      }
      
      public function initGameFightTaxCollectorInformations(param1:int = 0, param2:EntityLook = null, param3:EntityDispositionInformations = null, param4:uint = 2, param5:uint = 0, param6:Boolean = false, param7:GameFightMinimalStats = null, param8:Vector.<uint> = null, param9:uint = 0, param10:uint = 0, param11:uint = 0) : GameFightTaxCollectorInformations
      {
         super.initGameFightAIInformations(param1,param2,param3,param4,param5,param6,param7,param8);
         this.firstNameId = param9;
         this.lastNameId = param10;
         this.level = param11;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.firstNameId = 0;
         this.lastNameId = 0;
         this.level = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_GameFightTaxCollectorInformations(param1);
      }
      
      public function serializeAs_GameFightTaxCollectorInformations(param1:ICustomDataOutput) : void
      {
         super.serializeAs_GameFightAIInformations(param1);
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
               if(this.level < 0 || this.level > 255)
               {
                  throw new Error("Forbidden value (" + this.level + ") on element level.");
               }
               else
               {
                  param1.writeByte(this.level);
                  return;
               }
            }
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightTaxCollectorInformations(param1);
      }
      
      public function deserializeAs_GameFightTaxCollectorInformations(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.firstNameId = param1.readVarUhShort();
         if(this.firstNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firstNameId + ") on element of GameFightTaxCollectorInformations.firstNameId.");
         }
         else
         {
            this.lastNameId = param1.readVarUhShort();
            if(this.lastNameId < 0)
            {
               throw new Error("Forbidden value (" + this.lastNameId + ") on element of GameFightTaxCollectorInformations.lastNameId.");
            }
            else
            {
               this.level = param1.readUnsignedByte();
               if(this.level < 0 || this.level > 255)
               {
                  throw new Error("Forbidden value (" + this.level + ") on element of GameFightTaxCollectorInformations.level.");
               }
               else
               {
                  return;
               }
            }
         }
      }
   }
}
