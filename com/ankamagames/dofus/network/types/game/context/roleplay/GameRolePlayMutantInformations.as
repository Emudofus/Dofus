package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameRolePlayMutantInformations extends GameRolePlayHumanoidInformations implements INetworkType
   {
      
      public function GameRolePlayMutantInformations()
      {
         super();
      }
      
      public static const protocolId:uint = 3;
      
      public var monsterId:uint = 0;
      
      public var powerLevel:int = 0;
      
      override public function getTypeId() : uint
      {
         return 3;
      }
      
      public function initGameRolePlayMutantInformations(param1:int = 0, param2:EntityLook = null, param3:EntityDispositionInformations = null, param4:String = "", param5:HumanInformations = null, param6:uint = 0, param7:uint = 0, param8:int = 0) : GameRolePlayMutantInformations
      {
         super.initGameRolePlayHumanoidInformations(param1,param2,param3,param4,param5,param6);
         this.monsterId = param7;
         this.powerLevel = param8;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.monsterId = 0;
         this.powerLevel = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_GameRolePlayMutantInformations(param1);
      }
      
      public function serializeAs_GameRolePlayMutantInformations(param1:ICustomDataOutput) : void
      {
         super.serializeAs_GameRolePlayHumanoidInformations(param1);
         if(this.monsterId < 0)
         {
            throw new Error("Forbidden value (" + this.monsterId + ") on element monsterId.");
         }
         else
         {
            param1.writeVarShort(this.monsterId);
            param1.writeByte(this.powerLevel);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayMutantInformations(param1);
      }
      
      public function deserializeAs_GameRolePlayMutantInformations(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.monsterId = param1.readVarUhShort();
         if(this.monsterId < 0)
         {
            throw new Error("Forbidden value (" + this.monsterId + ") on element of GameRolePlayMutantInformations.monsterId.");
         }
         else
         {
            this.powerLevel = param1.readByte();
            return;
         }
      }
   }
}
