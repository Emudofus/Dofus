package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameFightMutantInformations extends GameFightFighterNamedInformations implements INetworkType
   {
      
      public function GameFightMutantInformations()
      {
         super();
      }
      
      public static const protocolId:uint = 50;
      
      public var powerLevel:uint = 0;
      
      override public function getTypeId() : uint
      {
         return 50;
      }
      
      public function initGameFightMutantInformations(param1:int = 0, param2:EntityLook = null, param3:EntityDispositionInformations = null, param4:uint = 2, param5:uint = 0, param6:Boolean = false, param7:GameFightMinimalStats = null, param8:Vector.<uint> = null, param9:String = "", param10:PlayerStatus = null, param11:uint = 0) : GameFightMutantInformations
      {
         super.initGameFightFighterNamedInformations(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10);
         this.powerLevel = param11;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.powerLevel = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_GameFightMutantInformations(param1);
      }
      
      public function serializeAs_GameFightMutantInformations(param1:ICustomDataOutput) : void
      {
         super.serializeAs_GameFightFighterNamedInformations(param1);
         if(this.powerLevel < 0)
         {
            throw new Error("Forbidden value (" + this.powerLevel + ") on element powerLevel.");
         }
         else
         {
            param1.writeByte(this.powerLevel);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightMutantInformations(param1);
      }
      
      public function deserializeAs_GameFightMutantInformations(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.powerLevel = param1.readByte();
         if(this.powerLevel < 0)
         {
            throw new Error("Forbidden value (" + this.powerLevel + ") on element of GameFightMutantInformations.powerLevel.");
         }
         else
         {
            return;
         }
      }
   }
}
