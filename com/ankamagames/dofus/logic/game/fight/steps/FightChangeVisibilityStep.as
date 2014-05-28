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
      
      public function FightChangeVisibilityStep(entityId:int, visibilityState:int) {
         super();
         var fighterInfos:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(entityId) as GameFightFighterInformations;
         this._oldVisibilityState = fighterInfos.stats.invisibilityState;
         this._entityId = entityId;
         this._visibilityState = visibilityState;
      }
      
      private var _entityId:int;
      
      private var _visibilityState:int;
      
      private var _oldVisibilityState:int;
      
      public function get stepType() : String {
         return "changeVisibility";
      }
      
      override public function start() : void {
         var dispatchedState:uint = 0;
         var invisibleEntity:DisplayObject = null;
         switch(this._visibilityState)
         {
            case GameActionFightInvisibilityStateEnum.VISIBLE:
               if(Atouin.getInstance().options.transparentOverlayMode)
               {
                  invisibleEntity = this.respawnEntity();
                  invisibleEntity.alpha = AtouinConstants.OVERLAY_MODE_ALPHA;
               }
               else
               {
                  invisibleEntity = this.respawnEntity();
                  invisibleEntity.alpha = 1;
               }
               if(invisibleEntity is AnimatedCharacter)
               {
                  AnimatedCharacter(invisibleEntity).setCanSeeThrough(false);
               }
               if((this._oldVisibilityState == GameActionFightInvisibilityStateEnum.DETECTED) || (this._oldVisibilityState == GameActionFightInvisibilityStateEnum.INVISIBLE))
               {
                  dispatchedState = GameActionFightInvisibilityStateEnum.VISIBLE;
               }
               break;
            case GameActionFightInvisibilityStateEnum.DETECTED:
               if(this._oldVisibilityState == GameActionFightInvisibilityStateEnum.VISIBLE)
               {
                  dispatchedState = GameActionFightInvisibilityStateEnum.INVISIBLE;
               }
               invisibleEntity = this.respawnEntity();
               if(invisibleEntity is AnimatedCharacter)
               {
                  AnimatedCharacter(invisibleEntity).setCanSeeThrough(true);
               }
               invisibleEntity.alpha = 0.5;
               break;
            case GameActionFightInvisibilityStateEnum.INVISIBLE:
               if(this._oldVisibilityState == GameActionFightInvisibilityStateEnum.VISIBLE)
               {
                  dispatchedState = GameActionFightInvisibilityStateEnum.INVISIBLE;
               }
               this.unspawnEntity();
               break;
         }
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_VISIBILITY_CHANGED,[this._entityId,dispatchedState],this._entityId,castingSpellId);
         var fighterInfos:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._entityId) as GameFightFighterInformations;
         fighterInfos.stats.invisibilityState = this._visibilityState;
         executeCallbacks();
      }
      
      private function unspawnEntity() : void {
         if(FightEntitiesHolder.getInstance().getEntity(this._entityId))
         {
            return;
         }
         var entity:IDisplayable = DofusEntities.getEntity(this._entityId) as IDisplayable;
         FightEntitiesHolder.getInstance().holdEntity(entity as IEntity);
         entity.remove();
      }
      
      private function respawnEntity() : DisplayObject {
         var fightEntitiesFrame:FightEntitiesFrame = null;
         var entity:IDisplayable = null;
         var tiphonSprite:TiphonSprite = DofusEntities.getEntity(this._entityId) as TiphonSprite;
         if((tiphonSprite) && (tiphonSprite.parentSprite))
         {
            fightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
            if(fightEntitiesFrame)
            {
               fightEntitiesFrame.addOrUpdateActor(fightEntitiesFrame.getEntityInfos(this._entityId));
            }
            if(FightEntitiesHolder.getInstance().getEntity(this._entityId))
            {
               FightEntitiesHolder.getInstance().unholdEntity(this._entityId);
            }
            return tiphonSprite;
         }
         if(FightEntitiesHolder.getInstance().getEntity(this._entityId))
         {
            entity = DofusEntities.getEntity(this._entityId) as IDisplayable;
            entity.display();
            FightEntitiesHolder.getInstance().unholdEntity(this._entityId);
         }
         return DofusEntities.getEntity(this._entityId) as DisplayObject;
      }
   }
}
