package com.ankamagames.dofus.misc.utils
{
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.tiphon.types.look.*;

    public class LookCleaner extends Object
    {

        public function LookCleaner()
        {
            return;
        }// end function

        public static function clean(param1:TiphonEntityLook) : TiphonEntityLook
        {
            var _loc_2:* = param1.clone();
            var _loc_3:* = _loc_2.getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0);
            if (_loc_3)
            {
                if (_loc_3.getBone() == 2)
                {
                    _loc_3.setBone(1);
                }
                return _loc_3;
            }
            return _loc_2;
        }// end function

    }
}
