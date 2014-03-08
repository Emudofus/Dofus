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
      
      public static function addApi(name:String, apiClass:Class) : void {
         _apiClass[name] = apiClass;
      }
      
      public static function removeApi(name:String) : void {
         delete _apiClass[[name]];
      }
      
      public static function reset() : void {
         _apiInstance = [];
         _apiData = [];
      }
      
      public static function addApiData(name:String, value:*) : void {
         _apiData[name] = value;
      }
      
      public static function getApiData(name:String) : * {
         return _apiData[name];
      }
      
      public static function removeApiData(name:String) : void {
         _apiData[name] = null;
      }
      
      public static function initApi(target:Object, module:UiModule, sharedDefinition:ApplicationDomain=null) : String {
         var api:Object = null;
         var metaTag:XML = null;
         var metaData:* = undefined;
         var apiName:String = null;
         var modName:String = null;
         addApiData("module",module);
         var desc:XML = DescribeTypeCache.typeDescription(target);
         for each (metaTag in desc..variable)
         {
            for each (metaData in metaTag.metadata)
            {
               if((metaData.@name == "Module") && (!UiModuleManager.getInstance().getModules()[metaData.arg.@value]))
               {
                  return metaData.arg.@value;
               }
            }
            if(metaTag.@type.toString().indexOf("d2api::") == 0)
            {
               apiName = metaTag.@type.toString();
               apiName = apiName.substr(7,apiName.length - 10);
               api = getApiInstance(apiName,module.trusted,sharedDefinition);
               module.apiList.push(api);
               target[metaTag.@name] = api;
            }
            else
            {
               for each (metaData in metaTag.metadata)
               {
                  if(metaData.@name == "Api")
                  {
                     if(metaData.arg.@key == "name")
                     {
                        api = getApiInstance(metaData.arg.@value,module.trusted,sharedDefinition);
                        module.apiList.push(api);
                        target[metaTag.@name] = api;
                     }
                     else
                     {
                        throw new ApiError(module.id + " module, unknow property \"" + metaTag..metadata.arg.@key + "\" in Api tag");
                     }
                  }
                  if(metaData.@name == "Module")
                  {
                     if(metaData.arg.@key == "name")
                     {
                        modName = metaData.arg.@value;
                        if(!UiModuleManager.getInstance().getModules()[modName])
                        {
                           throw new ApiError("Module " + modName + " does not exist (in " + module.id + ")");
                        }
                        else
                        {
                           if((module.trusted) || (modName == "Ankama_Common") || (modName == "Ankama_ContextMenu") || (!UiModuleManager.getInstance().getModules()[modName].trusted))
                           {
                              target[metaTag.@name] = new ModuleReference(UiModule(UiModuleManager.getInstance().getModules()[modName]).mainClass,SecureCenter.ACCESS_KEY);
                              continue;
                           }
                           throw new ApiError(module.id + ", untrusted module cannot acces to trusted modules " + modName);
                        }
                     }
                     else
                     {
                        throw new ApiError(module.id + " module, unknow property \"" + metaData.arg.@key + "\" in Api tag");
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
      
      private static function getApiInstance(name:String, trusted:Boolean, sharedDefinition:ApplicationDomain) : Object {
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
                  if((metaData.@name == "Untrusted") || (metaData.@name == "Trusted") || (metaData.@name == "Deprecated"))
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
               if((!(tag == "Untrusted")) && (!(tag == "Trusted")) && (!(tag == "Deprecated")))
               {
                  throw new ApiError("Missing tag [Untrusted / Trusted] before function \"" + method.@name + "\" in " + _apiClass[name]);
               }
               else
               {
                  if((tag == "Untrusted") || ((tag == "Trusted") || (tag == "Deprecated")) && (trusted))
                  {
                     if(tag == "Deprecated")
                     {
                        api[method.@name] = createDepreciatedMethod(apiRef[method.@name],method.@name,help);
                     }
                     else
                     {
                        if((boxing) && (!isComplexFct(method)))
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
      
      private static function isComplexFct(methodDesc:XML) : Boolean {
         var paramType:String = null;
         var cacheKey:String = methodDesc.@declaredBy + "_" + methodDesc.@name;
         if(_isComplexFctCache[cacheKey] != null)
         {
            return _isComplexFctCache[cacheKey];
         }
         var simpleType:Array = ["int","uint","Number","Boolean","String","void"];
         if(simpleType.indexOf(methodDesc.@returnType.toString()) == -1)
         {
            _isComplexFctCache[cacheKey] = false;
            return false;
         }
         for each (paramType in methodDesc..parameter..@type)
         {
            if(simpleType.indexOf(paramType) == -1)
            {
               _isComplexFctCache[cacheKey] = false;
               return false;
            }
         }
         _isComplexFctCache[cacheKey] = true;
         return true;
      }
      
      private static function createDepreciatedMethod(fct:Function, fctName:String, help:String) : Function {
         return function(... args):*
         {
            var e:* = new Error();
            if(e.getStackTrace())
            {
               _log.fatal(fctName + " is a deprecated api function, called at " + e.getStackTrace().split("at ")[2] + (help.length?help + "\n":""));
            }
            else
            {
               _log.fatal(fctName + " is a deprecated api function. No stack trace available");
            }
            return CallWithParameters.callR(fct,args);
         };
      }
   }
}
