package com.ankamagames.berilia.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.handlers.FocusHandler;
   import com.ankamagames.jerakine.handlers.HumanInputHandler;
   import com.ankamagames.jerakine.interfaces.ISecurizable;
   import flash.system.ApplicationDomain;
   import com.ankamagames.berilia.api.ReadOnlyObject;
   import flash.geom.Point;
   import com.ankamagames.jerakine.interfaces.Secure;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.interfaces.IModuleUtil;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.jerakine.utils.misc.CallWithParameters;
   import com.ankamagames.jerakine.interfaces.INoBoxing;
   import flash.errors.IllegalOperationError;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class SecureCenter extends Object
   {
      
      public function SecureCenter() {
         super();
      }
      
      protected static var SharedSecureComponent:Class;
      
      protected static var SharedReadOnlyData:Class;
      
      protected static var DirectAccessObject:Class;
      
      public static const ACCESS_KEY:Object = new Object();
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(SecureCenter));
      
      public static function init(sharedSecureComponent:Object, sharedReadOnlyData:Object, directAccessObject:Object) : void {
         SharedSecureComponent = sharedSecureComponent as Class;
         SharedReadOnlyData = sharedReadOnlyData as Class;
         DirectAccessObject = directAccessObject as Class;
         FocusHandler.getInstance().handler = HumanInputHandler.getInstance().handler;
      }
      
      public static function destroy(target:*) : void {
         switch(true)
         {
            case target is SharedSecureComponent:
               SharedSecureComponent["destroy"](target,ACCESS_KEY);
               break;
         }
      }
      
      public static function secure(target:*, trusted:Boolean=false) : * {
         var iDataCenter:* = undefined;
         var iModuleUtil:* = undefined;
         switch(true)
         {
            case target == null:
            case target is uint:
            case target is int:
            case target is Number:
            case target is String:
            case target is Boolean:
            case target is Point:
            case target == undefined:
            case target is Secure:
               return target;
         }
      }
      
      public static function secureContent(target:Array, trusted:Boolean=false) : Array {
         var key:* = undefined;
         var result:Array = [];
         for (key in target)
         {
            result[key] = secure(target[key],trusted);
         }
         return result;
      }
      
      public static function unsecure(target:*) : * {
         switch(null)
         {
            case target is Secure && !(target is INoBoxing):
            case target is SharedSecureComponent:
            case target is SharedReadOnlyData:
            case target is DirectAccessObject:
               return target.getObject(ACCESS_KEY);
            case target is Function:
               return function(... args):*
               {
                  var nb:* = args.length;
                  var i:* = 0;
                  while(i < nb)
                  {
                     args[i] = secure(args[i]);
                     i++;
                  }
                  var result:* = CallWithParameters.callR(target,args);
                  return unsecure(result);
               };
         }
      }
      
      public static function unsecureContent(target:Array) : Array {
         var key:* = undefined;
         var result:Array = [];
         for (key in target)
         {
            result[key] = unsecure(target[key]);
         }
         return result;
      }
      
      public static function checkAccessKey(accessKey:Object) : void {
         if(accessKey != ACCESS_KEY)
         {
            throw new IllegalOperationError("Wrong access key");
         }
         else
         {
            return;
         }
      }
   }
}
