package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import com.ankamagames.jerakine.utils.misc.CheckCompatibility;
    import com.ankamagames.berilia.interfaces.IMenuMaker;
    import com.ankamagames.berilia.factories.MenusFactory;
    import com.ankamagames.berilia.utils.errors.ApiError;
    import com.ankamagames.berilia.managers.SecureCenter;
    import com.ankamagames.berilia.types.data.ContextMenuData;

    [InstanciedApi]
    public class ContextMenuApi implements IApi 
    {


        [Untrusted]
        public function registerMenuMaker(makerName:String, makerClass:Class):void
        {
            if (CheckCompatibility.isCompatible(IMenuMaker, makerClass))
            {
                MenusFactory.registerMaker(makerName, makerClass);
            }
            else
            {
                throw (new ApiError((makerName + " maker class is not compatible with IMenuMaker")));
            };
        }

        [Untrusted]
        public function create(data:*, makerName:String=null, makerParams:Array=null):ContextMenuData
        {
            var menu:ContextMenuData = MenusFactory.create(SecureCenter.unsecure(data), makerName, SecureCenter.unsecure(makerParams));
            return (menu);
        }

        [Untrusted]
        [NoBoxing]
        public function getMenuMaker(makerName:String):Object
        {
            return (MenusFactory.getMenuMaker(makerName));
        }


    }
}//package com.ankamagames.dofus.uiApi

