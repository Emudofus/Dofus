package com.ankamagames.dofus.types.entities
{
    import com.ankamagames.dofus.types.enums.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.events.*;
    import com.ankamagames.tiphon.types.*;

    public class AnimStatiqueSubEntityBehavior extends Object implements ISubEntityBehavior
    {
        private var _subentity:TiphonSprite;
        private var _parentData:BehaviorData;
        private var _animation:String;

        public function AnimStatiqueSubEntityBehavior()
        {
            return;
        }// end function

        public function updateFromParentEntity(param1:TiphonSprite, param2:BehaviorData) : void
        {
            this._subentity = param1;
            this._parentData = param2;
            this._animation = param2.animation;
            switch(true)
            {
                case this._parentData.animation.indexOf(AnimationEnum.ANIM_STATIQUE) != -1:
                case this._parentData.animation.indexOf(AnimationEnum.ANIM_HIT) != -1:
                case this._parentData.animation.indexOf(AnimationEnum.ANIM_ATTAQUE_BASE) != -1:
                case this._parentData.animation.indexOf(AnimationEnum.ANIM_MORT) != -1:
                case this._parentData.animation.indexOf("AnimEmote") != -1:
                {
                    if (!param1.hasAnimation(param2.animation, param2.direction))
                    {
                        this._animation = AnimationEnum.ANIM_STATIQUE;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._subentity && !this._subentity.hasAnimation(this._animation, this._parentData.direction))
            {
                this._animation = AnimationEnum.ANIM_STATIQUE;
            }
            param2.parent.addEventListener(TiphonEvent.RENDER_FATHER_SUCCEED, this.onFatherRendered, false, 0, true);
            return;
        }// end function

        public function remove() : void
        {
            if (this._parentData)
            {
                this._parentData.parent.removeEventListener(TiphonEvent.RENDER_FATHER_SUCCEED, this.onFatherRendered);
            }
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
