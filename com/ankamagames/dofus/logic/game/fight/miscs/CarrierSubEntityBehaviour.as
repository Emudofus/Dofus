package com.ankamagames.dofus.logic.game.fight.miscs
{
    import com.ankamagames.dofus.types.enums.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.events.*;
    import com.ankamagames.tiphon.types.*;

    public class CarrierSubEntityBehaviour extends Object implements ISubEntityBehavior
    {
        private var _subentity:TiphonSprite;
        private var _parentData:BehaviorData;
        private var _animation:String;

        public function CarrierSubEntityBehaviour()
        {
            return;
        }// end function

        public function updateFromParentEntity(param1:TiphonSprite, param2:BehaviorData) : void
        {
            this._subentity = param1;
            this._parentData = param2;
            this._animation = AnimationEnum.ANIM_STATIQUE;
            param2.parent.addEventListener(TiphonEvent.RENDER_FATHER_SUCCEED, this.onFatherRendered);
            return;
        }// end function

        public function remove() : void
        {
            this._parentData.parent.removeEventListener(TiphonEvent.RENDER_FATHER_SUCCEED, this.onFatherRendered);
            this._subentity = null;
            this._parentData = null;
            return;
        }// end function

        private function onFatherRendered(event:TiphonEvent) : void
        {
            var _loc_2:* = event.target as TiphonSprite;
            this._parentData.parent.removeEventListener(TiphonEvent.RENDER_FATHER_SUCCEED, this.onFatherRendered);
            this._subentity.setAnimationAndDirection(this._animation, this._parentData.direction);
            return;
        }// end function

    }
}
