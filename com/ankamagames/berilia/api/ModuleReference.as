package com.ankamagames.berilia.api
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.utils.memory.*;
    import flash.errors.*;
    import flash.utils.*;

    public class ModuleReference extends Proxy implements Secure
    {
        private var _object:WeakReference;

        public function ModuleReference(param1:Object, param2:Object)
        {
            SecureCenter.checkAccessKey(param2);
            this._object = new WeakReference(param1);
            return;
        }// end function

        public function getObject(param1:Object)
        {
            if (param1 != SecureCenter.ACCESS_KEY)
            {
                throw new IllegalOperationError();
            }
            return this._object.object;
        }// end function

        override function callProperty(param1, ... args)
        {
            args = this._object.object[param1].apply(this, args);
            this.verify(args);
            return args;
        }// end function

        override function getProperty(param1)
        {
            var _loc_2:* = this._object.object[param1];
            if (_loc_2 is Function)
            {
                return _loc_2;
            }
            throw new IllegalOperationError("You cannot access to property. You have access only to functions");
        }// end function

        override function setProperty(param1, param2) : void
        {
            throw new IllegalOperationError("You cannot access to property. You have access only to functions");
        }// end function

        override function hasProperty(param1) : Boolean
        {
            return this._object.object.hasOwnProperty(param1);
        }// end function

        private function verify(param1) : void
        {
            var _loc_2:* = getQualifiedClassName(param1);
            if (_loc_2.indexOf("d2api") == 0)
            {
                throw new IllegalOperationError("You cannot get API from an other module");
            }
            return;
        }// end function

    }
}
