package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.tiphon.types.ISubEntityBehavior;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.tiphon.types.TiphonUtility;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import flash.display.DisplayObject;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   
   public class FightAddSubEntityStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightAddSubEntityStep(fighterId:int, carriedEntityId:int, category:uint, slot:uint, subEntityBehaviour:ISubEntityBehavior=null) {
         super();
         this._fighterId = fighterId;
         this._carriedEntityId = carriedEntityId;
         this._category = category;
         this._slot = slot;
         this._subEntityBehaviour = subEntityBehaviour;
      }
      
      private var _fighterId:int;
      
      private var _carriedEntityId:int;
      
      private var _category:uint;
      
      private var _slot:uint;
      
      private var _subEntityBehaviour:ISubEntityBehavior;
      
      public function get stepType() : String {
         return "addSubEntity";
      }
      
      override public function start() : void {
         var parentEntity:IEntity = DofusEntities.getEntity(this._fighterId);
         var carriedEntity:IEntity = DofusEntities.getEntity(this._carriedEntityId);
         var carryingSprite:TiphonSprite = TiphonUtility.getEntityWithoutMount(parentEntity as TiphonSprite) as TiphonSprite;
         if((carriedEntity) && (carryingSprite) && (carryingSprite is TiphonSprite))
         {
            if(this._subEntityBehaviour)
            {
               carryingSprite.setSubEntityBehaviour(this._category,this._subEntityBehaviour);
            }
            carryingSprite.addSubEntity(DisplayObject(carriedEntity),this._category,this._slot);
            if((carryingSprite.getTmpSubEntitiesNb() > 0) && (!carryingSprite.libraryIsAvaible))
            {
               carryingSprite.addEventListener(TiphonEvent.SPRITE_INIT,this.forceRender);
            }
         }
         else
         {
            _log.warn("Unable to add a subentity to fighter " + this._fighterId + ", non-existing or not a sprite.");
         }
         if(parentEntity is IMovable)
         {
            IMovable(parentEntity).movementBehavior.synchroniseSubEntitiesPosition(IMovable(parentEntity));
         }
         executeCallbacks();
      }
      
      private function forceRender(pEvt:TiphonEvent) : void {
         if((pEvt.currentTarget as TiphonSprite).hasEventListener(TiphonEvent.SPRITE_INIT))
         {
            (pEvt.currentTarget as TiphonSprite).removeEventListener(TiphonEvent.SPRITE_INIT,this.forceRender);
            if((pEvt.currentTarget as TiphonSprite).getTmpSubEntitiesNb() > 0)
            {
               (pEvt.currentTarget as TiphonSprite).forceRender();
            }
         }
      }
   }
}
