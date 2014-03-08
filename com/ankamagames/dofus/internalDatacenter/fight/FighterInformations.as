package com.ankamagames.dofus.internalDatacenter.fight
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.tiphon.types.TiphonUtility;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.network.enums.TeamEnum;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   
   public class FighterInformations extends Object implements IDataCenter
   {
      
      public function FighterInformations(param1:int) {
         var _loc5_:CharacterCharacteristicsInformations = null;
         super();
         var _loc2_:Frame = Kernel.getWorker().getFrame(FightContextFrame);
         if(!_loc2_ || !(_loc2_ as FightContextFrame).entitiesFrame)
         {
            return;
         }
         var _loc3_:GameFightFighterInformations = (_loc2_ as FightContextFrame).entitiesFrame.getEntityInfos(param1) as GameFightFighterInformations;
         if(!_loc3_)
         {
            return;
         }
         this._fighterId = param1;
         this._look = EntityLookAdapter.fromNetwork(_loc3_.look);
         this._look = TiphonUtility.getLookWithoutMount(this._look);
         var _loc4_:IEntity = DofusEntities.getEntity(param1);
         if((_loc4_) && (_loc4_.position))
         {
            this._currentCell = _loc4_.position.cellId;
         }
         else
         {
            this._currentCell = _loc3_.disposition.cellId;
         }
         this._currentOrientation = _loc3_.disposition.direction;
         this._isAlive = _loc3_.alive;
         switch(_loc3_.teamId)
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
               _log.warn("Unknown teamId " + _loc3_.teamId + " ?!");
               this._team = "unknown";
         }
         if(param1 == PlayedCharacterManager.getInstance().id)
         {
            _loc5_ = PlayedCharacterManager.getInstance().characteristics;
            _loc3_.stats.actionPoints = _loc5_.actionPointsCurrent;
            _loc3_.stats.movementPoints = _loc5_.movementPointsCurrent;
         }
         this._lifePoints = _loc3_.stats.lifePoints;
         this._maxLifePoints = _loc3_.stats.maxLifePoints;
         this._actionPoints = _loc3_.stats.actionPoints;
         this._movementPoints = _loc3_.stats.movementPoints;
         this._paDodge = _loc3_.stats.dodgePALostProbability;
         this._pmDodge = _loc3_.stats.dodgePMLostProbability;
         this._shieldPoints = _loc3_.stats.shieldPoints;
         this._summoner = _loc3_.stats.summoner;
         this._summoned = _loc3_.stats.summoned;
         this._invisibility = _loc3_.stats.invisibilityState;
         this._permanentDamagePercent = _loc3_.stats.permanentDamagePercent;
         this._tackleBlock = _loc3_.stats.tackleBlock;
         this._airResist = _loc3_.stats.airElementResistPercent;
         this._earthResist = _loc3_.stats.earthElementResistPercent;
         this._fireResist = _loc3_.stats.fireElementResistPercent;
         this._neutralResist = _loc3_.stats.neutralElementResistPercent;
         this._waterResist = _loc3_.stats.waterElementResistPercent;
         this._airFixedResist = _loc3_.stats.airElementReduction;
         this._earthFixedResist = _loc3_.stats.earthElementReduction;
         this._fireFixedResist = _loc3_.stats.fireElementReduction;
         this._neutralFixedResist = _loc3_.stats.neutralElementReduction;
         this._waterFixedResist = _loc3_.stats.waterElementReduction;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FighterInformations));
      
      private var _fighterId:int;
      
      private var _look:TiphonEntityLook;
      
      private var _currentCell:int;
      
      private var _currentOrientation:int;
      
      private var _isAlive:Boolean;
      
      private var _team:String;
      
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
