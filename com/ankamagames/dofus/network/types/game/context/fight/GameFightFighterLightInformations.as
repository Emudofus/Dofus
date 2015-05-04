package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameFightFighterLightInformations extends Object implements INetworkType
   {
      
      public function GameFightFighterLightInformations()
      {
         super();
      }
      
      public static const protocolId:uint = 413;
      
      public var id:int = 0;
      
      public var wave:uint = 0;
      
      public var level:uint = 0;
      
      public var breed:int = 0;
      
      public var sex:Boolean = false;
      
      public var alive:Boolean = false;
      
      public function getTypeId() : uint
      {
         return 413;
      }
      
      public function initGameFightFighterLightInformations(param1:int = 0, param2:uint = 0, param3:uint = 0, param4:int = 0, param5:Boolean = false, param6:Boolean = false) : GameFightFighterLightInformations
      {
         this.id = param1;
         this.wave = param2;
         this.level = param3;
         this.breed = param4;
         this.sex = param5;
         this.alive = param6;
         return this;
      }
      
      public function reset() : void
      {
         this.id = 0;
         this.wave = 0;
         this.level = 0;
         this.breed = 0;
         this.sex = false;
         this.alive = false;
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_GameFightFighterLightInformations(param1);
      }
      
      public function serializeAs_GameFightFighterLightInformations(param1:ICustomDataOutput) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,0,this.sex);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,1,this.alive);
         param1.writeByte(_loc2_);
         param1.writeInt(this.id);
         if(this.wave < 0)
         {
            throw new Error("Forbidden value (" + this.wave + ") on element wave.");
         }
         else
         {
            param1.writeByte(this.wave);
            if(this.level < 0)
            {
               throw new Error("Forbidden value (" + this.level + ") on element level.");
            }
            else
            {
               param1.writeVarShort(this.level);
               param1.writeByte(this.breed);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightFighterLightInformations(param1);
      }
      
      public function deserializeAs_GameFightFighterLightInformations(param1:ICustomDataInput) : void
      {
         var _loc2_:uint = param1.readByte();
         this.sex = BooleanByteWrapper.getFlag(_loc2_,0);
         this.alive = BooleanByteWrapper.getFlag(_loc2_,1);
         this.id = param1.readInt();
         this.wave = param1.readByte();
         if(this.wave < 0)
         {
            throw new Error("Forbidden value (" + this.wave + ") on element of GameFightFighterLightInformations.wave.");
         }
         else
         {
            this.level = param1.readVarUhShort();
            if(this.level < 0)
            {
               throw new Error("Forbidden value (" + this.level + ") on element of GameFightFighterLightInformations.level.");
            }
            else
            {
               this.breed = param1.readByte();
               return;
            }
         }
      }
   }
}
