package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameFightMonsterInformations extends GameFightAIInformations implements INetworkType
   {
      
      public function GameFightMonsterInformations()
      {
         super();
      }
      
      public static const protocolId:uint = 29;
      
      public var creatureGenericId:uint = 0;
      
      public var creatureGrade:uint = 0;
      
      override public function getTypeId() : uint
      {
         return 29;
      }
      
      public function initGameFightMonsterInformations(param1:int = 0, param2:EntityLook = null, param3:EntityDispositionInformations = null, param4:uint = 2, param5:uint = 0, param6:Boolean = false, param7:GameFightMinimalStats = null, param8:Vector.<uint> = null, param9:uint = 0, param10:uint = 0) : GameFightMonsterInformations
      {
         super.initGameFightAIInformations(param1,param2,param3,param4,param5,param6,param7,param8);
         this.creatureGenericId = param9;
         this.creatureGrade = param10;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.creatureGenericId = 0;
         this.creatureGrade = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_GameFightMonsterInformations(param1);
      }
      
      public function serializeAs_GameFightMonsterInformations(param1:ICustomDataOutput) : void
      {
         super.serializeAs_GameFightAIInformations(param1);
         if(this.creatureGenericId < 0)
         {
            throw new Error("Forbidden value (" + this.creatureGenericId + ") on element creatureGenericId.");
         }
         else
         {
            param1.writeVarShort(this.creatureGenericId);
            if(this.creatureGrade < 0)
            {
               throw new Error("Forbidden value (" + this.creatureGrade + ") on element creatureGrade.");
            }
            else
            {
               param1.writeByte(this.creatureGrade);
               return;
            }
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightMonsterInformations(param1);
      }
      
      public function deserializeAs_GameFightMonsterInformations(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.creatureGenericId = param1.readVarUhShort();
         if(this.creatureGenericId < 0)
         {
            throw new Error("Forbidden value (" + this.creatureGenericId + ") on element of GameFightMonsterInformations.creatureGenericId.");
         }
         else
         {
            this.creatureGrade = param1.readByte();
            if(this.creatureGrade < 0)
            {
               throw new Error("Forbidden value (" + this.creatureGrade + ") on element of GameFightMonsterInformations.creatureGrade.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
