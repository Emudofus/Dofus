package ui.behavior
{
    import ui.AbstractStorageUi;

    public class DecraftBehavior extends CraftBehavior 
    {


        override public function attach(storageUi:AbstractStorageUi):void
        {
            _showFilter = false;
            super.attach(storageUi);
        }


    }
}//package ui.behavior

