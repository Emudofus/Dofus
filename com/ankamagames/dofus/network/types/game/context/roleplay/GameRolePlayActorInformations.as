package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GameRolePlayActorInformations extends GameContextActorInformations implements INetworkType
   {
      
      public function GameRolePlayActorInformations() {
         super();
      }
      
      public static const protocolId:uint = 141;
      
      override public function getTypeId() : uint {
         return 141;
      }
      
      public function initGameRolePlayActorInformations(param1:int=0, param2:EntityLook=null, param3:EntityDispositionInformations=null) : GameRolePlayActorInformations {
         super.initGameContextActorInformations(param1,param2,param3);
         return this;
      }
      
      override public function reset() : void {
         super.reset();
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameRolePlayActorInformations(param1);
      }
      
      public function serializeAs_GameRolePlayActorInformations(param1:IDataOutput) : void {
         super.serializeAs_GameContextActorInformations(param1);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameRolePlayActorInformations(param1);
      }
      
      public function deserializeAs_GameRolePlayActorInformations(param1:IDataInput) : void {
         super.deserialize(param1);
      }
   }
}
