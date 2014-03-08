package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import flash.display.DisplayObject;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.network.enums.GameActionFightInvisibilityStateEnum;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.logic.game.fight.miscs.FightEntitiesHolder;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.dofus.kernel.Kernel;
   
   public class FightChangeVisibilityStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightChangeVisibilityStep(param1:int, param2:int) {
         super();
         var _loc3_:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(param1) as GameFightFighterInformations;
         this._oldVisibilityState = _loc3_.stats.invisibilityState;
         this._entityId = param1;
         this._visibilityState = param2;
      }
      
      private var _entityId:int;
      
      private var _visibilityState:int;
      
      private var _oldVisibilityState:int;
      
      public function get stepType() : String {
         return "changeVisibility";
      }
      
      override public function start() : void {
         var _loc1_:uint = 0;
         var _loc2_:DisplayObject = null;
         switch(this._visibilityState)
         {
            case GameActionFightInvisibilityStateEnum.VISIBLE:
               if(Atouin.getInstance().options.transparentOverlayMode)
               {
                  _loc2_ = this.respawnEntity();
                  _loc2_.alpha = AtouinConstants.OVERLAY_MODE_ALPHA;
               }
               else
               {
                  _loc2_ = this.respawnEntity();
                  _loc2_.alpha = 1;
               }
               if(_loc2_ is AnimatedCharacter)
               {
                  AnimatedCharacter(_loc2_).setCanSeeThrough(false);
               }
               if(this._oldVisibilityState == GameActionFightInvisibilityStateEnum.DETECTED || this._oldVisibilityState == GameActionFightInvisibilityStateEnum.INVISIBLE)
               {
                  _loc1_ = GameActionFightInvisibilityStateEnum.VISIBLE;
               }
               break;
            case GameActionFightInvisibilityStateEnum.DETECTED:
               if(this._oldVisibilityState == GameActionFightInvisibilityStateEnum.VISIBLE)
               {
                  _loc1_ = GameActionFightInvisibilityStateEnum.INVISIBLE;
               }
               _loc2_ = this.respawnEntity();
               if(_loc2_ is AnimatedCharacter)
               {
                  AnimatedCharacter(_loc2_).setCanSeeThrough(true);
               }
               _loc2_.alpha = 0.5;
               break;
            case GameActionFightInvisibilityStateEnum.INVISIBLE:
               if(this._oldVisibilityState == GameActionFightInvisibilityStateEnum.VISIBLE)
               {
                  _loc1_ = GameActionFightInvisibilityStateEnum.INVISIBLE;
               }
               this.unspawnEntity();
               break;
         }
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_VISIBILITY_CHANGED,[this._entityId,_loc1_],this._entityId,castingSpellId);
         var _loc3_:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._entityId) as GameFightFighterInformations;
         _loc3_.stats.invisibilityState = this._visibilityState;
         executeCallbacks();
      }
      
      private function unspawnEntity() : void {
         if(FightEntitiesHolder.getInstance().getEntity(this._entityId))
         {
            return;
         }
         var _loc1_:IDisplayable = DofusEntities.getEntity(this._entityId) as IDisplayable;
         FightEntitiesHolder.getInstance().holdEntity(_loc1_ as IEntity);
         _loc1_.remove();
      }
      
      private function respawnEntity() : DisplayObject {
         var _loc2_:FightEntitiesFrame = null;
         var _loc3_:IDisplayable = null;
         var _loc1_:TiphonSprite = DofusEntities.getEntity(this._entityId) as TiphonSprite;
         if((_loc1_) && (_loc1_.parentSprite))
         {
            _loc2_ = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
            if(_loc2_)
            {
               _loc2_.addOrUpdateActor(_loc2_.getEntityInfos(this._entityId));
            }
            if(FightEntitiesHolder.getInstance().getEntity(this._entityId))
            {
               FightEntitiesHolder.getInstance().unholdEntity(this._entityId);
            }
            return _loc1_;
         }
         if(FightEntitiesHolder.getInstance().getEntity(this._entityId))
         {
            _loc3_ = DofusEntities.getEntity(this._entityId) as IDisplayable;
            _loc3_.display();
            FightEntitiesHolder.getInstance().unholdEntity(this._entityId);
         }
         return DofusEntities.getEntity(this._entityId) as DisplayObject;
      }
   }
}
