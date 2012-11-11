package com.ankamagames.dofus.logic.game.fight.miscs
{
    import com.ankamagames.dofus.types.enums.*;
    import com.ankamagames.tiphon.types.*;
    import com.ankamagames.tiphon.types.look.*;

    public class CarrierAnimationModifier extends Object implements IAnimationModifier
    {
        private static var _self:CarrierAnimationModifier;

        public function CarrierAnimationModifier()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return AnimationModifierPriority.HIGH;
        }// end function

        public function getModifiedAnimation(param1:String, param2:TiphonEntityLook) : String
        {
            switch(param1)
            {
                case AnimationEnum.ANIM_STATIQUE:
                {
                    return AnimationEnum.ANIM_STATIQUE_CARRYING;
                }
                case AnimationEnum.ANIM_MARCHE:
                {
                    return AnimationEnum.ANIM_MARCHE_CARRYING;
                }
                case AnimationEnum.ANIM_COURSE:
                {
                    return AnimationEnum.ANIM_COURSE_CARRYING;
                }
                case AnimationEnum.ANIM_HIT:
                {
                    return AnimationEnum.ANIM_HIT_CARRYING;
                }
                case AnimationEnum.ANIM_MORT:
                {
                    return AnimationEnum.ANIM_MORT_CARRYING;
                }
                case AnimationEnum.ANIM_TACLE:
                {
                    return AnimationEnum.ANIM_TACLE_CARRYING;
                }
                default:
                {
                    return param1;
                    break;
                }
            }
        }// end function

        public static function getInstance() : CarrierAnimationModifier
        {
            if (!_self)
            {
                _self = new CarrierAnimationModifier;
            }
            return _self;
        }// end function

    }
}
