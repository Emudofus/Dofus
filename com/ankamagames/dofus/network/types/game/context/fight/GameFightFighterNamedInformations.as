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
      
      public function initGameFightFighterNamedInformations(contextualId:int=0, look:EntityLook=null, disposition:EntityDispositionInformations=null, teamId:uint=2, wave:uint=0, alive:Boolean=false, stats:GameFightMinimalStats=null, name:String="", status:PlayerStatus=null) : GameFightFighterNamedInformations {
         super.initGameFightFighterInformations(contextualId,look,disposition,teamId,wave,alive,stats);
         this.name = name;
         this.status = status;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.name = "";
         this.status = new PlayerStatus();
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameFightFighterNamedInformations(output);
      }
      
      public function serializeAs_GameFightFighterNamedInformations(output:IDataOutput) : void {
         super.serializeAs_GameFightFighterInformations(output);
         output.writeUTF(this.name);
         this.status.serializeAs_PlayerStatus(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightFighterNamedInformations(input);
      }
      
      public function deserializeAs_GameFightFighterNamedInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.name = input.readUTF();
         this.status = new PlayerStatus();
         this.status.deserialize(input);
      }
   }
}
