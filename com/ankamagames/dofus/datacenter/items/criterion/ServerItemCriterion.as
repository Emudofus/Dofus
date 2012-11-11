package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.datacenter.servers.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class ServerItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function ServerItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get text() : String
        {
            var _loc_1:* = Server.getServerById(_criterionValue).name;
            var _loc_2:* = I18n.getUiText("ui.header.server");
            return _loc_2 + " " + _operator.text + " " + _loc_1;
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new ServerItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            return PlayerManager.getInstance().server.id;
        }// end function

    }
}
