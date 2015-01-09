package com.ankamagames.dofus.misc.utils
{
    import com.ankamagames.dofus.types.enums.AnimationEnum;

    public class AnimationCleaner 
    {


        public static function cleanBones1AnimName(bones:uint, anim:String=null):String
        {
            var _local_3:String;
            switch (bones)
            {
                case 1:
                    if (anim)
                    {
                        if ((((((anim.length > 12)) && ((anim.slice(0, 12) == AnimationEnum.ANIM_STATIQUE)))) && ((((anim.length < 15)) || (!((anim.slice(12, 15) == "_to")))))))
                        {
                            return (AnimationEnum.ANIM_STATIQUE);
                        };
                    };
                    break;
            };
            return (anim);
        }


    }
}//package com.ankamagames.dofus.misc.utils

