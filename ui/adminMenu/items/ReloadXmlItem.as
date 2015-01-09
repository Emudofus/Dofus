package adminMenu.items
{
    public class ReloadXmlItem extends SendCommandItem 
    {

        public function ReloadXmlItem()
        {
            super(null);
        }

        override public function get callbackFunction():Function
        {
            return (Admin.getInstance().reloadXml);
        }

        override public function getcallbackArgs(replaceParam:Object):Array
        {
            return ([]);
        }


    }
}//package adminMenu.items

