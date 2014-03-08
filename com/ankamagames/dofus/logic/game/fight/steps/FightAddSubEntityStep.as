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
      
      public function FightAddSubEntityStep(param1:int, param2:int, param3:uint, param4:uint, param5:ISubEntityBehavior=null) {
         super();
         this._fighterId = param1;
         this._carriedEntityId = param2;
         this._category = param3;
         this._slot = param4;
         this._subEntityBehaviour = param5;
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
         var _loc1_:IEntity = DofusEntities.getEntity(this._fighterId);
         var _loc2_:IEntity = DofusEntities.getEntity(this._carriedEntityId);
         var _loc3_:TiphonSprite = TiphonUtility.getEntityWithoutMount(_loc1_ as TiphonSprite) as TiphonSprite;
         if((_loc2_) && (_loc3_) && _loc3_ is TiphonSprite)
         {
            if(this._subEntityBehaviour)
            {
               _loc3_.setSubEntityBehaviour(this._category,this._subEntityBehaviour);
            }
            _loc3_.addSubEntity(DisplayObject(_loc2_),this._category,this._slot);
            if(_loc3_.getTmpSubEntitiesNb() > 0 && !_loc3_.libraryIsAvaible)
            {
               _loc3_.addEventListener(TiphonEvent.SPRITE_INIT,this.forceRender);
            }
         }
         else
         {
            _log.warn("Unable to add a subentity to fighter " + this._fighterId + ", non-existing or not a sprite.");
         }
         if(_loc1_ is IMovable)
         {
            IMovable(_loc1_).movementBehavior.synchroniseSubEntitiesPosition(IMovable(_loc1_));
         }
         executeCallbacks();
      }
      
      private function forceRender(param1:TiphonEvent) : void {
         if((param1.currentTarget as TiphonSprite).hasEventListener(TiphonEvent.SPRITE_INIT))
         {
            (param1.currentTarget as TiphonSprite).removeEventListener(TiphonEvent.SPRITE_INIT,this.forceRender);
            if((param1.currentTarget as TiphonSprite).getTmpSubEntitiesNb() > 0)
            {
               (param1.currentTarget as TiphonSprite).forceRender();
            }
         }
      }
   }
}
