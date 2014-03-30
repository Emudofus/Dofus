package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class GameFightFighterInformations extends GameContextActorInformations implements INetworkType
   {
      
      public function GameFightFighterInformations() {
         this.stats = new GameFightMinimalStats();
         super();
      }
      
      public static const protocolId:uint = 143;
      
      public var teamId:uint = 2;
      
      public var wave:uint = 0;
      
      public var alive:Boolean = false;
      
      public var stats:GameFightMinimalStats;
      
      override public function getTypeId() : uint {
         return 143;
      }
      
      public function initGameFightFighterInformations(contextualId:int=0, look:EntityLook=null, disposition:EntityDispositionInformations=null, teamId:uint=2, wave:uint=0, alive:Boolean=false, stats:GameFightMinimalStats=null) : GameFightFighterInformations {
         super.initGameContextActorInformations(contextualId,look,disposition);
         this.teamId = teamId;
         this.wave = wave;
         this.alive = alive;
         this.stats = stats;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.teamId = 2;
         this.wave = 0;
         this.alive = false;
         this.stats = new GameFightMinimalStats();
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameFightFighterInformations(output);
      }
      
      public function serializeAs_GameFightFighterInformations(output:IDataOutput) : void {
         super.serializeAs_GameContextActorInformations(output);
         output.writeByte(this.teamId);
         if((this.wave < 0) || (this.wave > 4.294967295E9))
         {
            throw new Error("Forbidden value (" + this.wave + ") on element wave.");
         }
         else
         {
            output.writeUnsignedInt(this.wave);
            output.writeBoolean(this.alive);
            output.writeShort(this.stats.getTypeId());
            this.stats.serialize(output);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightFighterInformations(input);
      }
      
      public function deserializeAs_GameFightFighterInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.teamId = input.readByte();
         if(this.teamId < 0)
         {
            throw new Error("Forbidden value (" + this.teamId + ") on element of GameFightFighterInformations.teamId.");
         }
         else
         {
            this.wave = input.readUnsignedInt();
            if((this.wave < 0) || (this.wave > 4.294967295E9))
            {
               throw new Error("Forbidden value (" + this.wave + ") on element of GameFightFighterInformations.wave.");
            }
            else
            {
               this.alive = input.readBoolean();
               _id4 = input.readUnsignedShort();
               this.stats = ProtocolTypeManager.getInstance(GameFightMinimalStats,_id4);
               this.stats.deserialize(input);
               return;
            }
         }
      }
   }
}
