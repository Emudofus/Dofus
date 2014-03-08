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
      
      public function updateFromParentEntity(param1:TiphonSprite, param2:BehaviorData) : void {
         this._subentity = param1;
         this._parentData = param2;
         this._animation = AnimationEnum.ANIM_STATIQUE;
         param2.parent.addEventListener(TiphonEvent.RENDER_FATHER_SUCCEED,this.onFatherRendered);
      }
      
      public function remove() : void {
         this._parentData.parent.removeEventListener(TiphonEvent.RENDER_FATHER_SUCCEED,this.onFatherRendered);
         this._subentity = null;
         this._parentData = null;
      }
      
      private function onFatherRendered(param1:TiphonEvent) : void {
         var _loc2_:TiphonSprite = param1.target as TiphonSprite;
         this._parentData.parent.removeEventListener(TiphonEvent.RENDER_FATHER_SUCCEED,this.onFatherRendered);
         this._subentity.setAnimationAndDirection(this._animation,this._parentData.direction);
      }
   }
}
