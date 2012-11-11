package com.ankamagames.dofus.types.entities
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.effects.instances.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.dofus.types.enums.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.events.*;
    import com.ankamagames.tiphon.types.*;

    public class RiderBehavior extends Object implements ISubEntityBehavior
    {
        private var _subentity:TiphonSprite;
        private var _parentData:BehaviorData;
        private var _animation:String;

        public function RiderBehavior()
        {
            return;
        }// end function

        public function updateFromParentEntity(param1:TiphonSprite, param2:BehaviorData) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = false;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            this._subentity = param1;
            this._parentData = param2;
            if (param1.animationModifiers && param1.animationModifiers.length)
            {
                for each (_loc_3 in param1.animationModifiers)
                {
                    
                    this._animation = _loc_3.getModifiedAnimation(param2.animation, param1.look);
                }
            }
            else
            {
                this._animation = param2.animation;
            }
            switch(true)
            {
                case this._parentData.animation == AnimationEnum.ANIM_MARCHE:
                case this._parentData.animation == AnimationEnum.ANIM_COURSE:
                {
                    this._animation = AnimationEnum.ANIM_STATIQUE;
                    break;
                }
                case this._parentData.animation.indexOf("AnimEmoteRest") != -1:
                case this._parentData.animation.indexOf("AnimEmoteSit") != -1:
                case this._parentData.animation.indexOf("AnimEmoteRest") != -1:
                case this._parentData.animation.indexOf("AnimEmoteOups") != -1:
                case this._parentData.animation.indexOf("AnimEmoteShit") != -1:
                {
                    this._animation = AnimationEnum.ANIM_STATIQUE;
                    break;
                }
                case this._parentData.animation.indexOf("AnimArme") != -1:
                {
                    if (this._parentData.animation == "AnimArme0")
                    {
                        this._animation = AnimationEnum.ANIM_STATIQUE;
                    }
                    else
                    {
                        this._parentData.animation = AnimationEnum.ANIM_STATIQUE;
                    }
                    break;
                }
                case this._parentData.animation.indexOf("AnimAttaque") != -1:
                {
                    this._parentData.animation = AnimationEnum.ANIM_STATIQUE;
                    _loc_5 = FightSequenceFrame.lastCastingSpell;
                    if (_loc_5)
                    {
                        _loc_6 = _loc_5.spellRank.effects;
                        if (_loc_6)
                        {
                            for each (_loc_7 in _loc_6)
                            {
                                
                                if (_loc_7.category == 2)
                                {
                                    _loc_4 = true;
                                    break;
                                }
                            }
                        }
                    }
                    this._animation = "AnimAttaque" + (_loc_4 ? (1) : (0));
                    break;
                }
                case this._parentData.animation.indexOf("AnimCueillir") != -1:
                case this._parentData.animation.indexOf("AnimFaucher") != -1:
                case this._parentData.animation.indexOf("AnimPioche") != -1:
                case this._parentData.animation.indexOf("AnimHache") != -1:
                case this._parentData.animation.indexOf("AnimPeche") != -1:
                case this._parentData.animation.indexOf("AnimEmote") != -1:
                {
                    this._parentData.animation = AnimationEnum.ANIM_STATIQUE;
                    break;
                }
                default:
                {
                    break;
                }
            }
            param2.parent.addEventListener(TiphonEvent.RENDER_FATHER_SUCCEED, this.onFatherRendered);
            return;
        }// end function

        public function remove() : void
        {
            if (this._parentData && this._parentData.parent)
            {
                this._parentData.parent.removeEventListener(TiphonEvent.RENDER_FATHER_SUCCEED, this.onFatherRendered);
            }
            this._parentData = null;
            this._subentity = null;
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
