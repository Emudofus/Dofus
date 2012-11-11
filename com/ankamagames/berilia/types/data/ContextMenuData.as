package com.ankamagames.berilia.types.data
{
    import com.ankamagames.jerakine.interfaces.*;

    public class ContextMenuData extends Object implements IDataCenter
    {
        public var data:Object;
        public var makerName:String;
        public var content:UnsecureArray;

        public function ContextMenuData(param1, param2:String, param3:Array)
        {
            var _loc_4:* = undefined;
            this.data = param1;
            this.makerName = param2;
            this.content = new UnsecureArray();
            for each (_loc_4 in param3)
            {
                
                this.content.push(_loc_4);
            }
            return;
        }// end function

    }
}
