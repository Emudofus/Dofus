package com.ankamagames.dofus.internalDatacenter.fight
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.tiphon.types.TiphonUtility;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.network.enums.TeamEnum;
   
   public class FighterInformations extends Object implements IDataCenter
   {
      
      public function FighterInformations(fighterId:int) {
         super();
         var fightFrame:Frame = Kernel.getWorker().getFrame(FightContextFrame);
         if((!fightFrame) || (!(fightFrame as FightContextFrame).entitiesFrame))
         {
            return;
         }
         var fighterInfos:GameFightFighterInformations = (fightFrame as FightContextFrame).entitiesFrame.getEntityInfos(fighterId) as GameFightFighterInformations;
         if(!fighterInfos)
         {
            return;
         }
         this._fighterId = fighterId;
         this._look = EntityLookAdapter.fromNetwork(fighterInfos.look);
         this._look = TiphonUtility.getLookWithoutMount(this._look);
         var entity:IEntity = DofusEntities.getEntity(fighterId);
         if((entity) && (entity.position))
         {
            this._currentCell = entity.position.cellId;
         }
         else
         {
            this._currentCell = fighterInfos.disposition.cellId;
         }
         this._currentOrientation = fighterInfos.disposition.direction;
         this._isAlive = fighterInfos.alive;
         switch(fighterInfos.teamId)
         {
            case TeamEnum.TEAM_CHALLENGER:
               this._team = "challenger";
               break;
            case TeamEnum.TEAM_DEFENDER:
               this._team = "defender";
               break;
            case TeamEnum.TEAM_SPECTATOR:
               this._team = "spectator";
               break;
            default:
               _log.warn("Unknown teamId " + fighterInfos.teamId + " ?!");
               this._team = "unknown";
         }
         this._wave = fighterInfos.wave;
         this._lifePoints = fighterInfos.stats.lifePoints;
         this._maxLifePoints = fighterInfos.stats.maxLifePoints;
         this._actionPoints = fighterInfos.stats.actionPoints;
         this._movementPoints = fighterInfos.stats.movementPoints;
         this._paDodge = fighterInfos.stats.dodgePALostProbability;
         this._pmDodge = fighterInfos.stats.dodgePMLostProbability;
         this._shieldPoints = fighterInfos.stats.shieldPoints;
         this._summoner = fighterInfos.stats.summoner;
         this._summoned = fighterInfos.stats.summoned;
         this._invisibility = fighterInfos.stats.invisibilityState;
         this._permanentDamagePercent = fighterInfos.stats.permanentDamagePercent;
         this._tackleBlock = fighterInfos.stats.tackleBlock;
         this._airResist = fighterInfos.stats.airElementResistPercent;
         this._earthResist = fighterInfos.stats.earthElementResistPercent;
         this._fireResist = fighterInfos.stats.fireElementResistPercent;
         this._neutralResist = fighterInfos.stats.neutralElementResistPercent;
         this._waterResist = fighterInfos.stats.waterElementResistPercent;
         this._airFixedResist = fighterInfos.stats.airElementReduction;
         this._earthFixedResist = fighterInfos.stats.earthElementReduction;
         this._fireFixedResist = fighterInfos.stats.fireElementReduction;
         this._neutralFixedResist = fighterInfos.stats.neutralElementReduction;
         this._waterFixedResist = fighterInfos.stats.waterElementReduction;
      }
      
      protected static const _log:Logger;
      
      private var _fighterId:int;
      
      private var _look:TiphonEntityLook;
      
      private var _currentCell:int;
      
      private var _currentOrientation:int;
      
      private var _isAlive:Boolean;
      
      private var _team:String;
      
      private var _wave:int;
      
      private var _lifePoints:int;
      
      private var _maxLifePoints:int;
      
      private var _actionPoints:int;
      
      private var _movementPoints:int;
      
      private var _paDodge:int;
      
      private var _pmDodge:int;
      
      private var _shieldPoints:int;
      
      private var _summoner:int;
      
      private var _summoned:Boolean;
      
      private var _invisibility:int;
      
      private var _permanentDamagePercent:int;
      
      private var _tackleBlock:int;
      
      private var _airResist:int;
      
      private var _earthResist:int;
      
      private var _fireResist:int;
      
      private var _neutralResist:int;
      
      private var _waterResist:int;
      
      private var _airFixedResist:int;
      
      private var _earthFixedResist:int;
      
      private var _fireFixedResist:int;
      
      private var _neutralFixedResist:int;
      
      private var _waterFixedResist:int;
      
      public function get fighterId() : int {
         return this._fighterId;
      }
      
      public function get look() : TiphonEntityLook {
         return this._look;
      }
      
      public function get currentCell() : int {
         return this._currentCell;
      }
      
      public function get currentOrientation() : int {
         return this._currentOrientation;
      }
      
      public function get isAlive() : Boolean {
         return this._isAlive;
      }
      
      public function get team() : String {
         return this._team;
      }
      
      public function get wave() : int {
         return this._wave;
      }
      
      public function get lifePoints() : int {
         return this._lifePoints;
      }
      
      public function get maxLifePoints() : int {
         return this._maxLifePoints;
      }
      
      public function get actionPoints() : int {
         return this._actionPoints;
      }
      
      public function get movementPoints() : int {
         return this._movementPoints;
      }
      
      public function get paDodge() : int {
         return this._paDodge;
      }
      
      public function get pmDodge() : int {
         return this._pmDodge;
      }
      
      public function get shieldPoints() : int {
         return this._shieldPoints;
      }
      
      public function get summoner() : int {
         return this._summoner;
      }
      
      public function get summoned() : Boolean {
         return this._summoned;
      }
      
      public function get invisibility() : int {
         return this._invisibility;
      }
      
      public function get permanentDamagePercent() : int {
         return this._permanentDamagePercent;
      }
      
      public function get tackleBlock() : int {
         return this._tackleBlock;
      }
      
      public function get airResist() : int {
         return this._airResist;
      }
      
      public function get earthResist() : int {
         return this._earthResist;
      }
      
      public function get fireResist() : int {
         return this._fireResist;
      }
      
      public function get neutralResist() : int {
         return this._neutralResist;
      }
      
      public function get waterResist() : int {
         return this._waterResist;
      }
      
      public function get airFixedResist() : int {
         return this._airFixedResist;
      }
      
      public function get earthFixedResist() : int {
         return this._earthFixedResist;
      }
      
      public function get fireFixedResist() : int {
         return this._fireFixedResist;
      }
      
      public function get neutralFixedResist() : int {
         return this._neutralFixedResist;
      }
      
      public function get waterFixedResist() : int {
         return this._waterFixedResist;
      }
   }
}
