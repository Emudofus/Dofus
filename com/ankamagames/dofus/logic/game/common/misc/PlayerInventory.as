package com.ankamagames.dofus.logic.game.common.misc
{
    import com.ankamagames.dofus.logic.game.common.managers.*;

    public class PlayerInventory extends Inventory
    {

        public function PlayerInventory()
        {
            return;
        }// end function

        override public function set kamas(param1:int) : void
        {
            if (PlayedCharacterManager.getInstance().characteristics)
            {
                PlayedCharacterManager.getInstance().characteristics.kamas = param1;
            }
            super.kamas = param1;
            return;
        }// end function

    }
}
