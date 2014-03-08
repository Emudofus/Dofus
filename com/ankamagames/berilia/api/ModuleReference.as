package com.ankamagames.berilia.api
{
   import flash.utils.Proxy;
   import com.ankamagames.jerakine.interfaces.Secure;
   import com.ankamagames.jerakine.utils.memory.WeakReference;
   import com.ankamagames.berilia.managers.SecureCenter;
   import flash.errors.IllegalOperationError;
   import flash.utils.flash_proxy;
   import flash.utils.getQualifiedClassName;
   
   use namespace flash_proxy;
   
   public class ModuleReference extends Proxy implements Secure
   {
      
      public function ModuleReference(o:Object, accessKey:Object) {
         super();
         SecureCenter.checkAccessKey(accessKey);
         this._object = new WeakReference(o);
      }
      
      private var _object:WeakReference;
      
      public function getObject(accessKey:Object) : * {
         if(accessKey != SecureCenter.ACCESS_KEY)
         {
            throw new IllegalOperationError();
         }
         else
         {
            return this._object.object;
         }
      }
      
      override flash_proxy function callProperty(name:*, ... rest) : * {
         var result:* = this._object.object[name].apply(this,rest);
         this.verify(result);
         return result;
      }
      
      override flash_proxy function getProperty(name:*) : * {
         var result:* = this._object.object[name];
         if(result is Function)
         {
            return result;
         }
         throw new IllegalOperationError("You cannot access to property. You have access only to functions");
      }
      
      override flash_proxy function setProperty(name:*, value:*) : void {
         throw new IllegalOperationError("You cannot access to property. You have access only to functions");
      }
      
      override flash_proxy function hasProperty(name:*) : Boolean {
         return this._object.object.hasOwnProperty(name);
      }
      
      private function verify(o:*) : void {
         var pkg:String = getQualifiedClassName(o);
         if(pkg.indexOf("d2api") == 0)
         {
            throw new IllegalOperationError("You cannot get API from an other module");
         }
         else
         {
            return;
         }
      }
   }
}
