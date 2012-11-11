package com.ankamagames.dofus.uiApi
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.dofus.datacenter.mounts.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.misc.*;
    import com.ankamagames.tiphon.types.look.*;

    public class MountApi extends Object implements IApi
    {

        public function MountApi()
        {
            return;
        }// end function

        private function get mountFrame() : MountFrame
        {
            return Kernel.getWorker().getFrame(MountFrame) as MountFrame;
        }// end function

        private function get inventoryFrame() : InventoryManagementFrame
        {
            return Kernel.getWorker().getFrame(InventoryManagementFrame) as InventoryManagementFrame;
        }// end function

        private function get roleplayContextFrame() : RoleplayContextFrame
        {
            return Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
        }// end function

        public function getRiderEntityLook(param1) : TiphonEntityLook
        {
            return EntityLookAdapter.getRiderLook(param1);
        }// end function

        public function getMount(param1:uint) : Mount
        {
            return Mount.getMountById(param1);
        }// end function

        public function getStableList() : Array
        {
            return this.mountFrame.stableList;
        }// end function

        public function getPaddockList() : Array
        {
            return this.mountFrame.paddockList;
        }// end function

        public function getInventoryList() : Vector.<ItemWrapper>
        {
            return InventoryManager.getInstance().inventory.getView("certificate").content;
        }// end function

        public function getCurrentPaddock() : Object
        {
            return this.roleplayContextFrame.currentPaddock;
        }// end function

        public function isCertificateValid(param1:ItemWrapper) : Boolean
        {
            if (param1.effects.length > 1)
            {
                return true;
            }
            return false;
        }// end function

    }
}
