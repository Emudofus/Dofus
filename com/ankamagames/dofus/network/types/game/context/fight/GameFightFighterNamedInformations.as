package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GameFightFighterNamedInformations extends GameFightFighterInformations implements INetworkType
   {
      
      public function GameFightFighterNamedInformations() {
         this.status = new PlayerStatus();
         super();
      }
      
      public static const protocolId:uint = 158;
      
      public var name:String = "";
      
      public var status:PlayerStatus;
      
      override public function getTypeId() : uint {
         return 158;
      }
      
      public function initGameFightFighterNamedInformations(param1:int=0, param2:EntityLook=null, param3:EntityDispositionInformations=null, param4:uint=2, param5:Boolean=false, param6:GameFightMinimalStats=null, param7:String="", param8:PlayerStatus=null) : GameFightFighterNamedInformations {
         super.initGameFightFighterInformations(param1,param2,param3,param4,param5,param6);
         this.name = param7;
         this.status = param8;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.name = "";
         this.status = new PlayerStatus();
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameFightFighterNamedInformations(param1);
      }
      
      public function serializeAs_GameFightFighterNamedInformations(param1:IDataOutput) : void {
         super.serializeAs_GameFightFighterInformations(param1);
         param1.writeUTF(this.name);
         this.status.serializeAs_PlayerStatus(param1);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameFightFighterNamedInformations(param1);
      }
      
      public function deserializeAs_GameFightFighterNamedInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.name = param1.readUTF();
         this.status = new PlayerStatus();
         this.status.deserialize(param1);
      }
   }
}
