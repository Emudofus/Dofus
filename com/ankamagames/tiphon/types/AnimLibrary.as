package com.ankamagames.tiphon.types
{
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.tiphon.engine.*;

    public class AnimLibrary extends GraphicLibrary
    {

        public function AnimLibrary(param1:uint, param2:Boolean = false)
        {
            super(param1, param2);
            return;
        }// end function

        override public function addSwl(param1:Swl, param2:String) : void
        {
            var _loc_3:String = null;
            var _loc_4:Array = null;
            super.addSwl(param1, param2);
            for each (_loc_3 in param1.getDefinitions())
            {
                
                if (_loc_3.indexOf("_to_") != -1)
                {
                    _loc_4 = _loc_3.split("_");
                    BoneIndexManager.getInstance().addTransition(gfxId, _loc_4[0], _loc_4[2], parseInt(_loc_4[3]), _loc_4[0] + "_to_" + _loc_4[2]);
                }
            }
            return;
        }// end function

    }
}
