package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.factories.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.utils.errors.*;
    import com.ankamagames.jerakine.utils.misc.*;

    public class ContextMenuApi extends Object implements IApi
    {

        public function ContextMenuApi()
        {
            return;
        }// end function

        public function registerMenuMaker(param1:String, param2:Class) : void
        {
            if (CheckCompatibility.isCompatible(IMenuMaker, param2))
            {
                MenusFactory.registerMaker(param1, param2);
            }
            else
            {
                throw new ApiError(param1 + " maker class is not compatible with IMenuMaker");
            }
            return;
        }// end function

        public function create(param1, param2:String = null, param3:Array = null) : ContextMenuData
        {
            var _loc_4:* = MenusFactory.create(SecureCenter.unsecure(param1), param2, SecureCenter.unsecure(param3));
            return MenusFactory.create(SecureCenter.unsecure(param1), param2, SecureCenter.unsecure(param3));
        }// end function

        public function getMenuMaker(param1:String) : Object
        {
            return MenusFactory.getMenuMaker(param1);
        }// end function

    }
}
