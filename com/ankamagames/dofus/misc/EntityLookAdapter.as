package com.ankamagames.dofus.misc
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.tiphon.types.look.*;

    public class EntityLookAdapter extends Object
    {

        public function EntityLookAdapter()
        {
            return;
        }// end function

        public static function fromNetwork(param1:EntityLook) : TiphonEntityLook
        {
            var _loc_3:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_2:* = new TiphonEntityLook();
            _loc_2.lock();
            _loc_2.setBone(param1.bonesId);
            for each (_loc_3 in param1.skins)
            {
                
                _loc_2.addSkin(_loc_3);
            }
            if (param1.bonesId == 1 || param1.bonesId == 2)
            {
                _loc_2.defaultSkin = 1965;
            }
            var _loc_4:* = 0;
            while (_loc_4 < param1.indexedColors.length)
            {
                
                _loc_6 = param1.indexedColors[_loc_4] >> 24 & 255;
                _loc_7 = param1.indexedColors[_loc_4] & 16777215;
                _loc_2.setColor(_loc_6, _loc_7);
                _loc_4 = _loc_4 + 1;
            }
            if (param1.scales.length == 1)
            {
                _loc_2.setScales(param1.scales[0] / 100, param1.scales[0] / 100);
            }
            else if (param1.scales.length == 2)
            {
                _loc_2.setScales(param1.scales[0] / 100, param1.scales[1] / 100);
            }
            for each (_loc_5 in param1.subentities)
            {
                
                _loc_2.addSubEntity(_loc_5.bindingPointCategory, _loc_5.bindingPointIndex, EntityLookAdapter.fromNetwork(_loc_5.subEntityLook));
            }
            _loc_2.unlock(true);
            return _loc_2;
        }// end function

        public static function toNetwork(param1:TiphonEntityLook) : EntityLook
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_2:* = new EntityLook();
            _loc_2.bonesId = param1.getBone();
            _loc_2.skins = param1.getSkins(false, false);
            var _loc_3:* = param1.getColors(true);
            for (_loc_4 in _loc_3)
            {
                
                _loc_7 = parseInt(_loc_4);
                _loc_8 = _loc_3[_loc_4];
                _loc_9 = (_loc_7 & 255) << 24 | _loc_8 & 16777215;
                _loc_2.indexedColors.push(_loc_9);
            }
            _loc_2.scales.push(uint(param1.getScaleX() * 100));
            _loc_2.scales.push(uint(param1.getScaleY() * 100));
            _loc_5 = param1.getSubEntities(true);
            for (_loc_6 in _loc_5)
            {
                
                _loc_10 = parseInt(_loc_6);
                for (_loc_11 in _loc_5[_loc_6])
                {
                    
                    _loc_12 = parseInt(_loc_11);
                    _loc_13 = new SubEntity();
                    _loc_13.initSubEntity(_loc_10, _loc_12, EntityLookAdapter.toNetwork(_loc_5[_loc_6][_loc_11]));
                    _loc_2.subentities.push(_loc_13);
                }
            }
            return _loc_2;
        }// end function

        public static function tiphonizeLook(param1) : TiphonEntityLook
        {
            var _loc_2:* = null;
            param1 = SecureCenter.unsecure(param1);
            if (param1 is TiphonEntityLook)
            {
                _loc_2 = param1 as TiphonEntityLook;
            }
            if (param1 is EntityLook)
            {
                _loc_2 = fromNetwork(param1);
            }
            if (param1 is String)
            {
                _loc_2 = TiphonEntityLook.fromString(param1);
            }
            return _loc_2;
        }// end function

        public static function getRiderLook(param1) : TiphonEntityLook
        {
            param1 = SecureCenter.unsecure(param1);
            var _loc_2:* = tiphonizeLook(param1);
            var _loc_3:* = _loc_2.clone();
            var _loc_4:* = _loc_3.getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0);
            if (_loc_3.getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0))
            {
                if (_loc_4.getBone() == 2)
                {
                    _loc_4.setBone(1);
                }
                _loc_3 = _loc_4;
            }
            return _loc_3;
        }// end function

    }
}
