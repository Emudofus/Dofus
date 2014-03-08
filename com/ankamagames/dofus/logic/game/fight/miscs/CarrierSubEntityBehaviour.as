package com.ankamagames.dofus.logic.game.fight.miscs
{
   import com.ankamagames.tiphon.types.ISubEntityBehavior;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.types.BehaviorData;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.tiphon.events.TiphonEvent;
   
   public class CarrierSubEntityBehaviour extends Object implements ISubEntityBehavior
   {
      
      public function CarrierSubEntityBehaviour() {
         super();
      }
      
      private var _subentity:TiphonSprite;
      
      private var _parentData:BehaviorData;
      
      private var _animation:String;
      
      public function updateFromParentEntity(target:TiphonSprite, parentData:BehaviorData) : void {
         this._subentity = target;
         this._parentData = parentData;
         this._animation = AnimationEnum.ANIM_STATIQUE;
         parentData.parent.addEventListener(TiphonEvent.RENDER_FATHER_SUCCEED,this.onFatherRendered);
      }
      
      public function remove() : void {
         this._parentData.parent.removeEventListener(TiphonEvent.RENDER_FATHER_SUCCEED,this.onFatherRendered);
         this._subentity = null;
         this._parentData = null;
      }
      
      private function onFatherRendered(e:TiphonEvent) : void {
         var p:TiphonSprite = e.target as TiphonSprite;
         this._parentData.parent.removeEventListener(TiphonEvent.RENDER_FATHER_SUCCEED,this.onFatherRendered);
         this._subentity.setAnimationAndDirection(this._animation,this._parentData.direction);
      }
   }
}
