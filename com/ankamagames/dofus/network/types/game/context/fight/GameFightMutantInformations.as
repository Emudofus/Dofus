package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GameFightMutantInformations extends GameFightFighterNamedInformations implements INetworkType
   {
      
      public function GameFightMutantInformations() {
         super();
      }
      
      public static const protocolId:uint = 50;
      
      public var powerLevel:uint = 0;
      
      override public function getTypeId() : uint {
         return 50;
      }
      
      public function initGameFightMutantInformations(contextualId:int=0, look:EntityLook=null, disposition:EntityDispositionInformations=null, teamId:uint=2, wave:uint=0, alive:Boolean=false, stats:GameFightMinimalStats=null, name:String="", status:PlayerStatus=null, powerLevel:uint=0) : GameFightMutantInformations {
         super.initGameFightFighterNamedInformations(contextualId,look,disposition,teamId,wave,alive,stats,name,status);
         this.powerLevel = powerLevel;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.powerLevel = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameFightMutantInformations(output);
      }
      
      public function serializeAs_GameFightMutantInformations(output:IDataOutput) : void {
         super.serializeAs_GameFightFighterNamedInformations(output);
         if(this.powerLevel < 0)
         {
            throw new Error("Forbidden value (" + this.powerLevel + ") on element powerLevel.");
         }
         else
         {
            output.writeByte(this.powerLevel);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightMutantInformations(input);
      }
      
      public function deserializeAs_GameFightMutantInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.powerLevel = input.readByte();
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
