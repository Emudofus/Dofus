package com.ankamagames.berilia.components.params
{
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.berilia.utils.*;
    import com.ankamagames.jerakine.utils.memory.*;

    public class GridScriptProperties extends UiProperties
    {
        public var data:Object;
        public var selected:Boolean;
        public var grid:WeakProxyReference;

        public function GridScriptProperties(param1, param2:Boolean = false, param3:Grid = null)
        {
            this.data = param1;
            this.selected = param2;
            this.grid = new WeakProxyReference(param3);
            return;
        }// end function

    }
}
