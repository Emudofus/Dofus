package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GameFightFighterNamedLightInformations extends GameFightFighterLightInformations implements INetworkType
   {
      
      public function GameFightFighterNamedLightInformations() {
         super();
      }
      
      public static const protocolId:uint = 456;
      
      public var name:String = "";
      
      override public function getTypeId() : uint {
         return 456;
      }
      
      public function initGameFightFighterNamedLightInformations(param1:int=0, param2:uint=0, param3:int=0, param4:Boolean=false, param5:Boolean=false, param6:String="") : GameFightFighterNamedLightInformations {
         super.initGameFightFighterLightInformations(param1,param2,param3,param4,param5);
         this.name = param6;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.name = "";
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameFightFighterNamedLightInformations(param1);
      }
      
      public function serializeAs_GameFightFighterNamedLightInformations(param1:IDataOutput) : void {
         super.serializeAs_GameFightFighterLightInformations(param1);
         param1.writeUTF(this.name);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameFightFighterNamedLightInformations(param1);
      }
      
      public function deserializeAs_GameFightFighterNamedLightInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.name = param1.readUTF();
      }
   }
}
