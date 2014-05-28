package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.character.alignment.ActorAlignmentInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GameFightMonsterWithAlignmentInformations extends GameFightMonsterInformations implements INetworkType
   {
      
      public function GameFightMonsterWithAlignmentInformations() {
         this.alignmentInfos = new ActorAlignmentInformations();
         super();
      }
      
      public static const protocolId:uint = 203;
      
      public var alignmentInfos:ActorAlignmentInformations;
      
      override public function getTypeId() : uint {
         return 203;
      }
      
      public function initGameFightMonsterWithAlignmentInformations(contextualId:int = 0, look:EntityLook = null, disposition:EntityDispositionInformations = null, teamId:uint = 2, wave:uint = 0, alive:Boolean = false, stats:GameFightMinimalStats = null, creatureGenericId:uint = 0, creatureGrade:uint = 0, alignmentInfos:ActorAlignmentInformations = null) : GameFightMonsterWithAlignmentInformations {
         super.initGameFightMonsterInformations(contextualId,look,disposition,teamId,wave,alive,stats,creatureGenericId,creatureGrade);
         this.alignmentInfos = alignmentInfos;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.alignmentInfos = new ActorAlignmentInformations();
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameFightMonsterWithAlignmentInformations(output);
      }
      
      public function serializeAs_GameFightMonsterWithAlignmentInformations(output:IDataOutput) : void {
         super.serializeAs_GameFightMonsterInformations(output);
         this.alignmentInfos.serializeAs_ActorAlignmentInformations(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightMonsterWithAlignmentInformations(input);
      }
      
      public function deserializeAs_GameFightMonsterWithAlignmentInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.alignmentInfos = new ActorAlignmentInformations();
         this.alignmentInfos.deserialize(input);
      }
   }
}
