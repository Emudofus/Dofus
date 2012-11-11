package com.ankamagames.jerakine.utils.memory
{
    import flash.utils.*;

    public class WeakReference extends Object
    {
        private var dictionary:Dictionary;

        public function WeakReference(param1)
        {
            this.dictionary = new Dictionary(true);
            this.dictionary[param1] = null;
            return;
        }// end function

        public function get object()
        {
            var _loc_1:* = undefined;
            for (_loc_1 in this.dictionary)
            {
                
                return _loc_1;
            }
            return null;
        }// end function

        public function destroy() : void
        {
            this.dictionary = null;
            return;
        }// end function

    }
}
