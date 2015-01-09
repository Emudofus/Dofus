package d2api
{
    import d2data.ContextMenuData;

    public class ContextMenuApi 
    {


        [Untrusted]
        public function registerMenuMaker(makerName:String, makerClass:Class):void
        {
        }

        [Untrusted]
        public function create(data:*, makerName:String=null, makerParams:Object=null):ContextMenuData
        {
            return (null);
        }

        [Untrusted]
        public function getMenuMaker(makerName:String):Object
        {
            return (null);
        }


    }
}//package d2api

