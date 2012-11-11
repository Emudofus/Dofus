package com.ankamagames.jerakine.utils.memory
{
    import flash.utils.*;

    public class SoftReference extends Object
    {
        private var value:Object;
        private var keptTime:uint;
        private var timeout:uint;

        public function SoftReference(param1, param2:uint = 10000)
        {
            this.value = param1;
            this.keptTime = param2;
            this.resetTimeout();
            return;
        }// end function

        public function get object()
        {
            this.resetTimeout();
            return this.value;
        }// end function

        private function resetTimeout() : void
        {
            clearTimeout(this.timeout);
            if (this.value)
            {
                this.timeout = setTimeout(this.clearReference, this.keptTime);
            }
            return;
        }// end function

        private function clearReference() : void
        {
            this.value = null;
            return;
        }// end function

    }
}
