package com.ankamagames.berilia.api
{
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import com.ankamagames.berilia.types.data.UiModule;
   import flash.system.ApplicationDomain;
   import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.utils.errors.ApiError;
   import com.ankamagames.berilia.managers.SecureCenter;
   import com.ankamagames.jerakine.utils.misc.CallWithParameters;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class ApiBinder extends Object
   {
      
      public function ApiBinder() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ApiBinder));
      
      private static var _apiClass:Array = new Array();
      
      private static var _apiInstance:Array = new Array();
      
      private static var _apiData:Array = new Array();
      
      private static var _isComplexFctCache:Dictionary = new Dictionary();
      
      public static function addApi(param1:String, param2:Class) : void {
         _apiClass[param1] = param2;
      }
      
      public static function removeApi(param1:String) : void {
         delete _apiClass[[param1]];
      }
      
      public static function reset() : void {
         _apiInstance = [];
         _apiData = [];
      }
      
      public static function addApiData(param1:String, param2:*) : void {
         _apiData[param1] = param2;
      }
      
      public static function getApiData(param1:String) : * {
         return _apiData[param1];
      }
      
      public static function removeApiData(param1:String) : void {
         _apiData[param1] = null;
      }
      
      public static function initApi(param1:Object, param2:UiModule, param3:ApplicationDomain=null) : String {
         var _loc4_:Object = null;
         var _loc6_:XML = null;
         var _loc7_:* = undefined;
         var _loc8_:String = null;
         var _loc9_:String = null;
         addApiData("module",param2);
         var _loc5_:XML = DescribeTypeCache.typeDescription(param1);
         for each (_loc6_ in _loc5_..variable)
         {
            for each (_loc7_ in _loc6_.metadata)
            {
               if(_loc7_.@name == "Module" && !UiModuleManager.getInstance().getModules()[_loc7_.arg.@value])
               {
                  return _loc7_.arg.@value;
               }
            }
            if(_loc6_.@type.toString().indexOf("d2api::") == 0)
            {
               _loc8_ = _loc6_.@type.toString();
               _loc8_ = _loc8_.substr(7,_loc8_.length - 10);
               _loc4_ = getApiInstance(_loc8_,param2.trusted,param3);
               param2.apiList.push(_loc4_);
               param1[_loc6_.@name] = _loc4_;
            }
            else
            {
               for each (_loc7_ in _loc6_.metadata)
               {
                  if(_loc7_.@name == "Api")
                  {
                     if(_loc7_.arg.@key == "name")
                     {
                        _loc4_ = getApiInstance(_loc7_.arg.@value,param2.trusted,param3);
                        param2.apiList.push(_loc4_);
                        param1[_loc6_.@name] = _loc4_;
                     }
                     else
                     {
                        throw new ApiError(param2.id + " module, unknow property \"" + _loc6_..metadata.arg.@key + "\" in Api tag");
                     }
                  }
                  if(_loc7_.@name == "Module")
                  {
                     if(_loc7_.arg.@key == "name")
                     {
                        _loc9_ = _loc7_.arg.@value;
                        if(!UiModuleManager.getInstance().getModules()[_loc9_])
                        {
                           throw new ApiError("Module " + _loc9_ + " does not exist (in " + param2.id + ")");
                        }
                        else
                        {
                           if((param2.trusted) || _loc9_ == "Ankama_Common" || _loc9_ == "Ankama_ContextMenu" || !UiModuleManager.getInstance().getModules()[_loc9_].trusted)
                           {
                              param1[_loc6_.@name] = new ModuleReference(UiModule(UiModuleManager.getInstance().getModules()[_loc9_]).mainClass,SecureCenter.ACCESS_KEY);
                              continue;
                           }
                           throw new ApiError(param2.id + ", untrusted module cannot acces to trusted modules " + _loc9_);
                        }
                     }
                     else
                     {
                        throw new ApiError(param2.id + " module, unknow property \"" + _loc7_.arg.@key + "\" in Api tag");
                     }
                  }
                  else
                  {
                     continue;
                  }
               }
            }
         }
         return null;
      }
      
      private static function getApiInstance(param1:String, param2:Boolean, param3:ApplicationDomain) : Object {
         var apiDesc:XML = null;
         var api:Object = null;
         var apiRef:* = undefined;
         var instancied:Boolean = false;
         var meta:XML = null;
         var tag:String = null;
         var help:String = null;
         var boxing:Boolean = false;
         var method:XML = null;
         var accessor:XML = null;
         var metaData:XML = null;
         var metaData2:* = undefined;
         var name:String = param1;
         var trusted:Boolean = param2;
         var sharedDefinition:ApplicationDomain = param3;
         if((_apiInstance[name]) && (_apiInstance[name][trusted]))
         {
            return _apiInstance[name][trusted];
         }
         if(_apiClass[name])
         {
            apiDesc = DescribeTypeCache.typeDescription(_apiClass[name]);
            api = new sharedDefinition.getDefinition("d2api::" + name + "Api") as Class();
            apiRef = _apiClass[name];
            instancied = false;
            for each (meta in apiDesc..metadata)
            {
               if(meta.@name == "InstanciedApi")
               {
                  apiRef = new _apiClass[name]();
                  instancied = true;
                  break;
               }
            }
            for each (method in apiDesc..method)
            {
               boxing = true;
               for each (metaData in method.metadata)
               {
                  if(metaData.@name == "Untrusted" || metaData.@name == "Trusted" || metaData.@name == "Deprecated")
                  {
                     tag = metaData.@name;
                     if(metaData.@name == "Deprecated")
                     {
                        help = metaData.arg.(@key == "help").@value;
                     }
                  }
                  if(metaData.@name == "NoBoxing")
                  {
                     boxing = false;
                  }
               }
               if(!(tag == "Untrusted") && !(tag == "Trusted") && !(tag == "Deprecated"))
               {
                  throw new ApiError("Missing tag [Untrusted / Trusted] before function \"" + method.@name + "\" in " + _apiClass[name]);
               }
               else
               {
                  if(tag == "Untrusted" || (tag == "Trusted" || tag == "Deprecated") && (trusted))
                  {
                     if(tag == "Deprecated")
                     {
                        api[method.@name] = createDepreciatedMethod(apiRef[method.@name],method.@name,help);
                     }
                     else
                     {
                        if((boxing) && !isComplexFct(method))
                        {
                           api[method.@name] = SecureCenter.secure(apiRef[method.@name]);
                        }
                        else
                        {
                           api[method.@name] = apiRef[method.@name];
                        }
                     }
                  }
                  else
                  {
                     api[method.@name] = GenericApiFunction.getRestrictedFunctionAccess(apiRef[method.@name]);
                  }
                  continue;
               }
            }
            for each (accessor in apiDesc..accessor)
            {
               for each (metaData2 in accessor.metadata)
               {
                  if(metaData2.@name == "ApiData")
                  {
                     apiRef[accessor.@name] = _apiData[metaData2.arg.@value];
                     break;
                  }
               }
            }
            if(!instancied)
            {
               if(!_apiInstance[name])
               {
                  _apiInstance[name] = new Array();
               }
               _apiInstance[name][trusted] = api;
            }
            return api;
         }
         _log.error("Api [" + name + "] is not avaible");
         return null;
      }
      
      private static function isComplexFct(param1:XML) : Boolean {
         var _loc4_:String = null;
         var _loc2_:String = param1.@declaredBy + "_" + param1.@name;
         if(_isComplexFctCache[_loc2_] != null)
         {
            return _isComplexFctCache[_loc2_];
         }
         var _loc3_:Array = ["int","uint","Number","Boolean","String","void"];
         if(_loc3_.indexOf(param1.@returnType.toString()) == -1)
         {
            _isComplexFctCache[_loc2_] = false;
            return false;
         }
         for each (_loc4_ in param1..parameter..@type)
         {
            if(_loc3_.indexOf(_loc4_) == -1)
            {
               _isComplexFctCache[_loc2_] = false;
               return false;
            }
         }
         _isComplexFctCache[_loc2_] = true;
         return true;
      }
      
      private static function createDepreciatedMethod(param1:Function, param2:String, param3:String) : Function {
         var fct:Function = param1;
         var fctName:String = param2;
         var help:String = param3;
         return function(... rest):*
         {
            var _loc2_:* = new Error();
            if(_loc2_.getStackTrace())
            {
               _log.fatal(fctName + " is a deprecated api function, called at " + _loc2_.getStackTrace().split("at ")[2] + (help.length?help + "\n":""));
            }
            else
            {
               _log.fatal(fctName + " is a deprecated api function. No stack trace available");
            }
            return CallWithParameters.callR(fct,rest);
         };
      }
   }
}
