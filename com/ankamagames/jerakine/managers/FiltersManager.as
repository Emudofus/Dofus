package com.ankamagames.jerakine.managers
{
    import flash.utils.Dictionary;
    import flash.display.DisplayObject;
    import flash.filters.BitmapFilter;

    public class FiltersManager 
    {

        private static var _self:FiltersManager;

        private var dFilters:Dictionary;

        public function FiltersManager(pvt:PrivateClass):void
        {
            this.dFilters = new Dictionary(true);
        }

        public static function getInstance():FiltersManager
        {
            if (_self == null)
            {
                _self = new (FiltersManager)(new PrivateClass());
            };
            return (_self);
        }


        public function addEffect(pTarget:DisplayObject, pFilter:BitmapFilter):void
        {
            var filters:Array = (this.dFilters[pTarget] as Array);
            if (filters == null)
            {
                filters = (this.dFilters[pTarget] = pTarget.filters);
            };
            filters.push(pFilter);
            pTarget.filters = filters;
        }

        public function removeEffect(pTarget:DisplayObject, pFilter:BitmapFilter):void
        {
            var filters:Array = (this.dFilters[pTarget] as Array);
            if (filters == null)
            {
                filters = (this.dFilters[pTarget] = pTarget.filters);
            };
            var index:int = this.indexOf(filters, pFilter);
            if (index != -1)
            {
                filters.splice(index, 1);
                pTarget.filters = filters;
            };
        }

        public function indexOf(pFilters:Array, pFilter:BitmapFilter):int
        {
            var f:BitmapFilter;
            var index:int = pFilters.length;
            while (index--)
            {
                f = pFilters[index];
                if (f == pFilter)
                {
                    return (index);
                };
            };
            return (-1);
        }


    }
}//package com.ankamagames.jerakine.managers

class PrivateClass 
{


}

