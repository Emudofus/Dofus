package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.GameRolePlayNpcQuestFlag;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameRolePlayNpcWithQuestInformations extends GameRolePlayNpcInformations implements INetworkType
   {
      
      public function GameRolePlayNpcWithQuestInformations()
      {
         this.questFlag = new GameRolePlayNpcQuestFlag();
         super();
      }
      
      public static const protocolId:uint = 383;
      
      public var questFlag:GameRolePlayNpcQuestFlag;
      
      override public function getTypeId() : uint
      {
         return 383;
      }
      
      public function initGameRolePlayNpcWithQuestInformations(param1:int = 0, param2:EntityLook = null, param3:EntityDispositionInformations = null, param4:uint = 0, param5:Boolean = false, param6:uint = 0, param7:GameRolePlayNpcQuestFlag = null) : GameRolePlayNpcWithQuestInformations
      {
         super.initGameRolePlayNpcInformations(param1,param2,param3,param4,param5,param6);
         this.questFlag = param7;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.questFlag = new GameRolePlayNpcQuestFlag();
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_GameRolePlayNpcWithQuestInformations(param1);
      }
      
      public function serializeAs_GameRolePlayNpcWithQuestInformations(param1:ICustomDataOutput) : void
      {
         super.serializeAs_GameRolePlayNpcInformations(param1);
         this.questFlag.serializeAs_GameRolePlayNpcQuestFlag(param1);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayNpcWithQuestInformations(param1);
      }
      
      public function deserializeAs_GameRolePlayNpcWithQuestInformations(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.questFlag = new GameRolePlayNpcQuestFlag();
         this.questFlag.deserialize(param1);
      }
   }
}
