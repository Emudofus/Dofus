package com.ankamagames.jerakine.utils.memory
{
    import flash.utils.*;

    dynamic public class WeakProxyReference extends Proxy
    {
        protected var dictionary:Dictionary;

        public function WeakProxyReference(param1:Object)
        {
            this.dictionary = new Dictionary(true);
            this.dictionary[param1] = null;
            return;
        }// end function

        public function get object() : Object
        {
            var _loc_1:* = null;
            for (_loc_1 in this.dictionary)
            {
                
                return _loc_1;
            }
            return null;
        }// end function

        private function getObject() : Object
        {
            var _loc_1:* = null;
            for (_loc_1 in this.dictionary)
            {
                
                return _loc_1;
            }
            throw new ReferenceError("Reference Error: Object is no longer available through WeakProxyReference, it may have been removed from memory.");
        }// end function

        override function callProperty(param1, ... args)
        {
            args = this.getObject()[param1];
            if (!(args is Function))
            {
                throw new TypeError("TypeError: Cannot call " + param1.toString() + " through WeakProxyReference, it is not a function.");
            }
            return args.apply(null, args);
        }// end function

        override function getProperty(param1)
        {
            return this.getObject()[param1];
        }// end function

        override function setProperty(param1, param2) : void
        {
            this.getObject()[param1] = param2;
            return;
        }// end function

        override function deleteProperty(param1) : Boolean
        {
            return delete this.getObject()[param1];
        }// end function

    }
}
