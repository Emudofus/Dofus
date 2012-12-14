package com.ankamagames.dofus.types.entities
{
    import com.ankamagames.tiphon.types.*;
    import com.ankamagames.tiphon.types.look.*;

    public class BreedSkinModifier extends Object implements ISkinModifier
    {

        public function BreedSkinModifier()
        {
            return;
        }// end function

        public function getModifiedSkin(param1:Skin, param2:String, param3:TiphonEntityLook) : String
        {
            var _loc_5:* = null;
            if (!param3 || !param3.skins || !param2 || !param1)
            {
                return param2;
            }
            var _loc_4:* = param2.split("_");
            var _loc_6:* = param3.skins.length - 1;
            while (_loc_6 >= 0)
            {
                
                _loc_5 = _loc_4[0] + "_" + param3.skins[_loc_6] + "_" + _loc_4[1];
                if (param1.getPart(_loc_5) != null)
                {
                    return _loc_5;
                }
                _loc_6 = _loc_6 - 1;
            }
            return param2;
        }// end function

    }
}
