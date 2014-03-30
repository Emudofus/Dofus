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
      
      public function initGameFightFighterNamedLightInformations(id:int=0, wave:int=0, level:uint=0, breed:int=0, sex:Boolean=false, alive:Boolean=false, name:String="") : GameFightFighterNamedLightInformations {
         super.initGameFightFighterLightInformations(id,wave,level,breed,sex,alive);
         this.name = name;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.name = "";
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameFightFighterNamedLightInformations(output);
      }
      
      public function serializeAs_GameFightFighterNamedLightInformations(output:IDataOutput) : void {
         super.serializeAs_GameFightFighterLightInformations(output);
         output.writeUTF(this.name);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightFighterNamedLightInformations(input);
      }
      
      public function deserializeAs_GameFightFighterNamedLightInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.name = input.readUTF();
      }
   }
}
