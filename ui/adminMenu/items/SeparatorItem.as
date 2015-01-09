package adminMenu.items
{
    public class SeparatorItem extends BasicItem 
    {

        private var _label:String;


        override public function getContextMenuItem(replaceParam:Object):Object
        {
            return (Api.contextMod.createContextMenuSeparatorObject());
        }

        override public function get label():String
        {
            return ("");
        }

        override public function set label(l:String):void
        {
        }

        override protected function replace(txt:String, param:Object):String
        {
            return ("");
        }


    }
}//package adminMenu.items

