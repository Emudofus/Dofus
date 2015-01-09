package com.ankamagames.dofus.logic.game.fight.miscs
{
    import com.ankamagames.tiphon.types.IAnimationModifier;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.tiphon.types.AnimationModifierPriority;
    import com.ankamagames.jerakine.types.Swl;
    import com.ankamagames.tiphon.engine.Tiphon;
    import com.ankamagames.dofus.types.enums.AnimationEnum;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;

    public class CustomAnimStatiqueAnimationModifier implements IAnimationModifier 
    {

        private static const _log:Logger = Log.getLogger(getQualifiedClassName(CustomAnimStatiqueAnimationModifier));

        public var randomStatique:Boolean;


        public function get priority():int
        {
            return (AnimationModifierPriority.NORMAL);
        }

        public function getModifiedAnimation(pAnimation:String, pLook:TiphonEntityLook):String
        {
            var lib:Swl;
            var statics:Array;
            var anim:String;
            var animName:String;
            var random:int;
            var _local_8:int;
            var animDeathName:String;
            switch (pAnimation)
            {
                case AnimationEnum.ANIM_STATIQUE:
                    if (pLook.getBone() == 1)
                    {
                        if (this.randomStatique)
                        {
                            lib = Tiphon.skullLibrary.getResourceById(pLook.getBone(), AnimationEnum.ANIM_STATIQUE);
                            statics = new Array();
                            if (lib)
                            {
                                for each (anim in lib.getDefinitions())
                                {
                                    if (anim.indexOf((AnimationEnum.ANIM_STATIQUE + pLook.firstSkin.toString())) == 0)
                                    {
                                        animName = anim.split("_")[0];
                                        if (statics.indexOf(animName) == -1)
                                        {
                                            statics.push(animName);
                                        };
                                    };
                                };
                            }
                            else
                            {
                                statics.push((AnimationEnum.ANIM_STATIQUE + pLook.firstSkin.toString()));
                            };
                            if (statics.length > 1)
                            {
                                random = Math.floor((Math.random() * statics.length));
                                return (statics[random]);
                            };
                            return (statics[0]);
                        };
                        _local_8 = pLook.firstSkin;
                        if ((((((((((_local_8 == 1114)) || ((_local_8 == 1115)))) || ((_local_8 == 1402)))) || ((_local_8 == 1463)))) || ((_local_8 == pLook.defaultSkin))))
                        {
                            return (AnimationEnum.ANIM_STATIQUE);
                        };
                        return ((AnimationEnum.ANIM_STATIQUE + pLook.firstSkin.toString()));
                    }
                    else
                    {
                        return (pAnimation);
                    };
                case AnimationEnum.ANIM_MORT:
                    if (pLook.getBone() == 1)
                    {
                        animDeathName = (AnimationEnum.ANIM_MORT + pLook.firstSkin.toString());
                        lib = Tiphon.skullLibrary.getResourceById(pLook.getBone(), animDeathName);
                        if (lib)
                        {
                            return (animDeathName);
                        };
                    };
                    return (pAnimation);
                default:
                    return (pAnimation);
            };
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.miscs

