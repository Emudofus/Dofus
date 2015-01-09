package com.ankamagames.dofus.misc.utils
{
    import com.ankamagames.tiphon.types.ISkinPartTransformProvider;
    import com.ankamagames.dofus.datacenter.appearance.SkinPosition;
    import com.ankamagames.tiphon.types.Skin;

    public class SkinPartTransformProvider implements ISkinPartTransformProvider 
    {


        public function init(skin:Skin):void
        {
            var skinId:uint;
            var sp:SkinPosition;
            var i:uint;
            for each (skinId in skin.skinList)
            {
                sp = SkinPosition.getSkinPositionById(skinId);
                if (sp)
                {
                    i = 0;
                    while (i < sp.skin.length)
                    {
                        skin.addTransform(sp.clip[i], sp.skin[i], sp.transformation[i]);
                        i++;
                    };
                };
            };
        }


    }
}//package com.ankamagames.dofus.misc.utils

