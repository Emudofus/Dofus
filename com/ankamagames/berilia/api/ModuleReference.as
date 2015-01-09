package com.ankamagames.berilia.api
{
    import flash.utils.Proxy;
    import com.ankamagames.jerakine.interfaces.Secure;
    import com.ankamagames.jerakine.utils.memory.WeakReference;
    import com.ankamagames.berilia.managers.SecureCenter;
    import flash.errors.IllegalOperationError;
    import flash.utils.getQualifiedClassName;
    import flash.utils.flash_proxy; 

    use namespace flash.utils.flash_proxy;

    public class ModuleReference extends Proxy implements Secure 
    {

        private var _object:WeakReference;

        public function ModuleReference(o:Object, accessKey:Object)
        {
            SecureCenter.checkAccessKey(accessKey);
            this._object = new WeakReference(o);
        }

        public function getObject(accessKey:Object)
        {
            if (accessKey != SecureCenter.ACCESS_KEY)
            {
                throw (new IllegalOperationError());
            };
            return (this._object.object);
        }

        override flash_proxy function callProperty(name:*, ... rest)
        {
            var result:* = this._object.object[name].apply(this, rest);
            this.verify(result);
            return (result);
        }

        override flash_proxy function getProperty(name:*)
        {
            var result:* = this._object.object[name];
            if ((result is Function))
            {
                return (result);
            };
            throw (new IllegalOperationError("You cannot access to property. You have access only to functions"));
        }

        override flash_proxy function setProperty(name:*, value:*):void
        {
            throw (new IllegalOperationError("You cannot access to property. You have access only to functions"));
        }

        override flash_proxy function hasProperty(name:*):Boolean
        {
            return (this._object.object.hasOwnProperty(name));
        }

        private function verify(o:*):void
        {
            var pkg:String = getQualifiedClassName(o);
            if (pkg.indexOf("d2api") == 0)
            {
                throw (new IllegalOperationError("You cannot get API from an other module"));
            };
        }


    }
}//package com.ankamagames.berilia.api

