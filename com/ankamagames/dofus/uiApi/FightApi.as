package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.dofus.internalDatacenter.fight.FighterInformations;
   import com.ankamagames.berilia.utils.errors.ApiError;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightBattleFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightPreparationFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
   import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
   import com.ankamagames.dofus.internalDatacenter.spells.EffectsWrapper;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceInteger;
   import com.ankamagames.dofus.internalDatacenter.spells.EffectsListWrapper;
   import com.ankamagames.dofus.logic.game.fight.frames.FightSpellCastFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.network.enums.FightTypeEnum;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.jerakine.messages.Frame;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.network.enums.TeamEnum;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class FightApi extends Object implements IApi
   {
      
      public function FightApi() {
         this._log = Log.getLogger(getQualifiedClassName(FightApi));
         super();
      }
      
      private static var UNKNOWN_FIGHTER_NAME:String = "???";
      
      protected var _log:Logger;
      
      private var _module:UiModule;
      
      public function set module(value:UiModule) : void {
         this._module = value;
      }
      
      public function destroy() : void {
         this._module = null;
      }
      
      public function getFighterInformations(fighterId:int) : FighterInformations {
         var fighterInfos:FighterInformations = new FighterInformations(fighterId);
         return fighterInfos;
      }
      
      public function getFighterName(fighterId:int) : String {
         try
         {
            return this.getFightFrame().getFighterName(fighterId);
         }
         catch(apiErr:ApiError)
         {
            return UNKNOWN_FIGHTER_NAME;
         }
         return null;
      }
      
      public function getFighterLevel(fighterId:int) : uint {
         return this.getFightFrame().getFighterLevel(fighterId);
      }
      
      public function getFighters() : Vector.<int> {
         if((Kernel.getWorker().getFrame(FightBattleFrame)) && (!Kernel.getWorker().getFrame(FightPreparationFrame)))
         {
            return this.getFightFrame().battleFrame.fightersList;
         }
         return this.getFightFrame().entitiesFrame.getOrdonnedPreFighters();
      }
      
      public function getMonsterId(id:int) : int {
         var gffi:GameFightFighterInformations = this.getFighterInfos(id);
         if(gffi is GameFightMonsterInformations)
         {
            return GameFightMonsterInformations(gffi).creatureGenericId;
         }
         return -1;
      }
      
      public function getDeadFighters() : Vector.<int> {
         if(Kernel.getWorker().getFrame(FightBattleFrame))
         {
            return this.getFightFrame().battleFrame.deadFightersList;
         }
         return new Vector.<int>();
      }
      
      public function getFightType() : uint {
         return this.getFightFrame().fightType;
      }
      
      public function getBuffList(targetId:int) : Array {
         return BuffManager.getInstance().getAllBuff(targetId);
      }
      
      public function getBuffById(buffId:uint, playerId:int) : BasicBuff {
         return BuffManager.getInstance().getBuff(buffId,playerId);
      }
      
      public function createEffectsWrapper(spell:Spell, effects:Array, name:String) : EffectsWrapper {
         return new EffectsWrapper(effects,spell,name);
      }
      
      public function getCastingSpellBuffEffects(targetId:int, castingSpellId:uint) : EffectsWrapper {
         var spell:Spell = null;
         var buffItem:BasicBuff = null;
         var effects:EffectsWrapper = null;
         var ei:EffectInstance = null;
         var eii:EffectInstanceInteger = null;
         var res:Array = new Array();
         var buffs:Array = BuffManager.getInstance().getAllBuff(targetId);
         var triggerList:Array = new Array();
         for each(buffItem in buffs)
         {
            if(buffItem.castingSpell.castingSpellId == castingSpellId)
            {
               ei = buffItem.effects;
               if((ei.trigger) && (ei is EffectInstanceInteger))
               {
                  eii = ei as EffectInstanceInteger;
                  if(triggerList[eii.effectId + "," + eii.value])
                  {
                     continue;
                  }
                  triggerList[eii.effectId + "," + eii.value] = true;
                  res.push(ei);
               }
               else
               {
                  res.push(ei);
               }
               if(!spell)
               {
                  spell = buffItem.castingSpell.spell;
               }
            }
         }
         effects = new EffectsWrapper(res,spell,"");
         return effects;
      }
      
      public function getAllBuffEffects(targetId:int) : EffectsListWrapper {
         return new EffectsListWrapper(BuffManager.getInstance().getAllBuff(targetId));
      }
      
      public function isCastingSpell() : Boolean {
         return Kernel.getWorker().contains(FightSpellCastFrame);
      }
      
      public function cancelSpell() : void {
         if(Kernel.getWorker().contains(FightSpellCastFrame))
         {
            Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(FightSpellCastFrame));
         }
      }
      
      public function getChallengeList() : Array {
         return this.getFightFrame().challengesList;
      }
      
      public function getCurrentPlayedFighterId() : int {
         return CurrentPlayedFighterManager.getInstance().currentFighterId;
      }
      
      public function getCurrentPlayedCharacteristicsInformations() : CharacterCharacteristicsInformations {
         return CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations();
      }
      
      public function preFightIsActive() : Boolean {
         return FightContextFrame.preFightIsActive;
      }
      
      public function isWaitingBeforeFight() : Boolean {
         if((this.getFightFrame().fightType == FightTypeEnum.FIGHT_TYPE_PvMA) || (this.getFightFrame().fightType == FightTypeEnum.FIGHT_TYPE_PvT))
         {
            return true;
         }
         return false;
      }
      
      public function isFightLeader() : Boolean {
         return this.getFightFrame().isFightLeader;
      }
      
      public function isSpectator() : Boolean {
         return PlayedCharacterManager.getInstance().isSpectator;
      }
      
      public function isDematerializated() : Boolean {
         return this.getFightFrame().entitiesFrame.dematerialization;
      }
      
      public function getTurnsCount() : int {
         return this.getFightFrame().battleFrame.turnsCount;
      }
      
      public function getFighterStatus(fighterId:uint) : int {
         var frame:Frame = Kernel.getWorker().getFrame(FightEntitiesFrame);
         var fightersStatus:Dictionary = FightEntitiesFrame(frame).lastKnownPlayerStatus;
         if(fightersStatus[fighterId])
         {
            return fightersStatus[fighterId];
         }
         return -1;
      }
      
      public function isMouseOverFighter(fighterId:uint) : Boolean {
         var fcf:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         return (this.getFighterInfos(fighterId).disposition.cellId == FightContextFrame.currentCell) || (fcf.timelineOverEntity) && (fighterId == fcf.timelineOverEntityId);
      }
      
      private function getFighterInfos(fighterId:int) : GameFightFighterInformations {
         return this.getFightFrame().entitiesFrame.getEntityInfos(fighterId) as GameFightFighterInformations;
      }
      
      private function getFightFrame() : FightContextFrame {
         var frame:Frame = Kernel.getWorker().getFrame(FightContextFrame);
         if(!frame)
         {
            throw new ApiError("Unallowed call of FightApi method while not fighting.");
         }
         else
         {
            return frame as FightContextFrame;
         }
      }
      
      private function getFighterTeam(fighterInfos:GameFightFighterInformations) : String {
         switch(fighterInfos.teamId)
         {
            case TeamEnum.TEAM_CHALLENGER:
               return "challenger";
            case TeamEnum.TEAM_DEFENDER:
               return "defender";
            case TeamEnum.TEAM_SPECTATOR:
               return "spectator";
            default:
               this._log.warn("Unknown teamId " + fighterInfos.teamId + " ?!");
               return "unknown";
         }
      }
   }
}
