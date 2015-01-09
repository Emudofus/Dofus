package ui.behavior
{
    import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
    import ui.enum.StorageState;

    public class MyselfVendorBehavior extends HumanVendorBehavior 
    {


        override public function detach():void
        {
            Api.ui.unloadUi(UIEnum.MYSELF_VENDOR_STOCK);
            super.detach();
        }

        override public function getName():String
        {
            return (StorageState.MYSELF_VENDOR_MOD);
        }


    }
}//package ui.behavior

